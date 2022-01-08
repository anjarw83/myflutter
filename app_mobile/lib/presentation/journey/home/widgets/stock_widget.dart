import 'package:app_mobile/domain/entities/stock_entity.dart';
import 'package:app_mobile/presentation/journey/home/stock_bloc/stock_bloc.dart';
import 'package:app_mobile/presentation/journey/home/stock_bloc/stock_event.dart';
import 'package:app_mobile/presentation/journey/home/stock_bloc/stock_state.dart';
import 'package:app_mobile/presentation/journey/home/widgets/constants.dart';
import 'package:app_mobile/common/injector/injector.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class Stocks extends StatefulWidget {
  const Stocks({Key key}) : super(key: key);

  @override
  _StocksState createState() => _StocksState();
}

class _StocksState extends State<Stocks> {
  StockBloc stockBloc;

  List<StockEntity> listStockEntity;
  TextEditingController textController;
  String _prevKeyword;

  @override
  void initState() {
    textController = TextEditingController();
    stockBloc = Injector.resolve<StockBloc>()..add(FetchStockEvent());
    super.initState();
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
                break;
              case StockWatchListUpdateSuccessState:
                debugPrint('UpdateWatchList Succeed');
                stockBloc.add(
                  FetchStockEvent(
                    keyword: textController.text,
                  ),
                );
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
            ? ListView.builder(
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
          child: Icon(
            watchList ? Icons.star_border : Icons.star_outlined,
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
      if ( textController.text == searchKeyword) {
        stockBloc.add(FetchStockEvent(keyword: searchKeyword));
      }
    });
  }
}
