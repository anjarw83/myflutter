import 'package:app_mobile/domain/entities/stock_entity.dart';
import 'package:app_mobile/presentation/journey/home/stock_bloc/stock_bloc.dart';
import 'package:app_mobile/presentation/journey/home/stock_bloc/stock_event.dart';
import 'package:app_mobile/presentation/journey/home/stock_bloc/stock_state.dart';
import 'package:app_mobile/presentation/journey/home/widgets/constants.dart';
import 'package:app_mobile/common/injector/injector.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';

class Stocks extends StatefulWidget {
  const Stocks({Key key}) : super(key: key);

  @override
  _StocksState createState() => _StocksState();
}

class _StocksState extends State<Stocks> {
  StockBloc stockBloc;

  List<StockEntity> listStockEntity;
  TextEditingController textController;
  int page = 1;
  double lastPosition = 0;
  ScrollController scrollController = ScrollController();

  @override
  void initState() {
    textController = TextEditingController();
    listStockEntity = [];
    stockBloc = Injector.resolve<StockBloc>()
      ..add(
        FetchStockEvent(
          keyword: '',
          limit: StockConstants.stockPerPage,
        ),
      );
    _initLoadMore();

    super.initState();
  }

  void _initLoadMore() {
    scrollController.addListener(() {
      if (scrollController.position.atEdge) {
        lastPosition = scrollController.position.minScrollExtent;

        final bool isTop = scrollController.position.pixels == 0;
        if (!isTop) {
          debugPrint('LoadMore...');
          stockBloc.add(
            LoadMoreStockEvent(
              keyword: textController.text,
              page: page + 1,
              limit: StockConstants.stockPerPage,
            ),
          );
        }
      }
    });
  }

  @override
  void dispose() {
    textController.dispose();
    stockBloc.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => BlocProvider(
        create: (_) => stockBloc,
        child: _buildBody(context),
      );

  Widget _buildBody(BuildContext context) {
    return Column(
      children: [
        const SizedBox(
          height: 20,
        ),
        _buildSearchTable(context),
        const SizedBox(
          height: 20,
        ),
        BlocConsumer<StockBloc, StockState>(
          builder: (context, state) {
            switch (state.runtimeType) {
              case StockLoadingState:
                return const CircularProgressIndicator();
              case StockLoadedState:
              case LoadMoreStockSuccessState:
                return _buildStockTable(context);
              default:
                return Container();
            }
          },
          listener: (context, state) {
            switch (state.runtimeType) {
              case StockLoadedState:
                debugPrint('InsideListener');
                final StockLoadedState _state = state;
                listStockEntity = _state.listStockEntity;
                // lastPosition = listStockEntity.length;
                break;
              case StockWatchListUpdateSuccessState:
                debugPrint('UpdateWatchList Succeed');
                stockBloc.add(
                  FetchStockEvent(
                    keyword: textController.text,
                    limit: StockConstants.stockPerPage,
                  ),
                );
                break;
              case LoadMoreStockInProgressState:
                if (scrollController.hasClients) {
                  lastPosition = scrollController.position.maxScrollExtent;
                  // scrollController.jumpTo(lastPosition);
                }
                break;
              case LoadMoreStockSuccessState:
                debugPrint('LoadMoreSuccess');
                page++;
                final LoadMoreStockSuccessState _state = state;
                listStockEntity.addAll(_state.listStockEntity);

                break;
              case LoadMoreStockFailedState:
                _showMessage(StockConstants.loadMoreFailedText);
                break;
            }
          },
        )

        // _buildStockTable(context)
      ],
    );
  }

  Widget _buildSearchTable(BuildContext context) {
    return TextField(
      controller: textController,
      onChanged: _runFilter,
      decoration: const InputDecoration(
        labelText: StockConstants.searchText,
        suffixIcon: Icon(Icons.search),
      ),
    );
  }

  Widget _buildStockHeader(BuildContext context) {}

  Widget _buildStockTable(BuildContext context) => Expanded(
        child: listStockEntity != null
            ? RefreshIndicator(
                onRefresh: _onRefresh,
                child: ListView.builder(
                  key: ObjectKey('key_list_${listStockEntity[0].id}'),
                  controller: scrollController,
                  itemCount: listStockEntity.length,
                  itemBuilder: (context, index) => Card(
                    key: ValueKey('${listStockEntity[index]}_id'),
                    color: Colors.white70,
                    // elevation: 2,
                    margin: const EdgeInsets.symmetric(
                      vertical: 1,
                    ),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        ..._buildListRow(context, index),
                      ],
                    ),
                  ),
                ),
              )
            : const Text(
                StockConstants.resultNotFoundText,
                style: TextStyle(fontSize: 24),
              ),
      );

  List<Widget> _buildListRow(BuildContext context, index) {
    final bool watchList = listStockEntity[index].watchlist ?? true;
    return [
      Container(
        width: 30,
        alignment: Alignment.centerLeft,
        margin: const EdgeInsets.only(
          left: 15,
        ),
        child: Text(
          (index + 1).toString(),
          style: const TextStyle(
            fontSize: 15,
          ),
        ),
      ),
      GestureDetector(
        onTap: () => _toggleWatchList(listStockEntity[index]),
        child: Container(
          height: 50,
          width: 25,
          alignment: Alignment.center,
          child: _watchIcon(
            listStockEntity[index],
          ),
        ),
      ),
      Container(
        height: 50,
        margin: const EdgeInsets.only(left: 20),
        alignment: Alignment.centerLeft,
        child: Text(
          listStockEntity[index].currency,
          style: const TextStyle(
              color: Colors.deepPurpleAccent, fontWeight: FontWeight.bold),
        ),
      ),
      Container(
        height: 50,
        width: 150,
        margin: const EdgeInsets.only(left: 20),
        alignment: Alignment.centerLeft,
        child: Text(
          listStockEntity[index].description,
        ),
      ),
      Container(
        height: 50,
        margin: const EdgeInsets.only(left: 20),
        alignment: Alignment.centerLeft,
        child: Text(
          listStockEntity[index].displaySymbol,
        ),
      ),
    ];
  }

  Widget _buildFooterloader(BuildContext context) => Container(
        height: 25,
        child: CircularProgressIndicator(),
      );

  void _toggleWatchList(StockEntity entity) {
    debugPrint('Screen Toggle Watchlist');
    stockBloc.add(ToggleStockWatchlistEvent(
      id: entity.id,
      status: !entity.watchlist,
    ));
  }

  Future<void> _runFilter(String searchKeyword) async {
    textController
      ..text = searchKeyword
      ..selection = TextSelection.fromPosition(
        TextPosition(offset: textController.text.length),
      );

    await Future.delayed(
        const Duration(
          milliseconds: StockConstants.searchDelay,
        ), () {
      if (textController.text == searchKeyword) {
        stockBloc.add(
          FetchStockEvent(
              keyword: searchKeyword, limit: StockConstants.stockPerPage),
        );
      }
    });
  }

  Future<void> _onRefresh() async {
    await Future.delayed(
      const Duration(milliseconds: StockConstants.searchDelay),
      () {
        textController.text = '';
        page = 1;
        stockBloc.add(
          FetchStockEvent(
              keyword: textController.text, limit: StockConstants.stockPerPage),
        );
      },
    );
  }

  void _showMessage(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
      ),
    );
  }

  Widget _watchIcon(StockEntity entity) {
    bool hasWatchlist = entity.watchlist ?? true;
    Color watchColors;
    if (hasWatchlist) {
      watchColors = Colors.orangeAccent;
    } else {
      watchColors = Colors.white;
    }

    return SvgPicture.asset(
      'assets/binoculars.svg',
      height: 25.0,
      width: 25.0,
      semanticsLabel: 'watch',
      color: watchColors,
    );
  }
}
