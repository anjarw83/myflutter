import 'package:app_mobile/common/injector/injector.dart';
import 'package:app_mobile/domain/entities/stock_entity.dart';
import 'package:app_mobile/presentation/journey/home/watchlist_bloc/watchlist_bloc.dart';
import 'package:app_mobile/presentation/journey/home/watchlist_bloc/watchlist_event.dart';
import 'package:app_mobile/presentation/journey/home/watchlist_bloc/watchlist_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class Watchlist extends StatefulWidget {
  const Watchlist({Key key}) : super(key: key);

  @override
  _WatchlistState createState() => _WatchlistState();
}

class _WatchlistState extends State<Watchlist> {
  WatchlistBloc watchlistBloc;
  final String userId = '61d71a3dd481803a0275b9c5'; // Todo: need to adjust
  List<StockEntity> stock = [];

  @override
  void initState() {
    watchlistBloc = Injector.resolve<WatchlistBloc>()
      ..add(
        FetchWatchlistEvent(userId: userId),
      );
    super.initState();
  }

  @override
  void dispose() {
    watchlistBloc?.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => BlocProvider(
        create: (_) => watchlistBloc,
        child: _buildBody(context),
      );

  Widget _buildBody(BuildContext context) =>
      BlocConsumer<WatchlistBloc, WatchlistState>(
        builder: (context, state) {
          switch (state.runtimeType) {
            case WatchlistLoadingState:
              return const CircularProgressIndicator();
            case WatchlistLoadedState:
              return _builderOrderableListView(context);
            default:
              return Container();
          }
        },
        listener: (context, state) {
          switch (state.runtimeType) {
            case WatchlistLoadedState:
              final WatchlistLoadedState _state = state;
              stock = _state.stocks;
              break;
          }
        },
      );

  Widget _builderOrderableListView(BuildContext context) => ReorderableListView(
        children: stock
            .map(
              (item) => ListTile(
                key: Key('${item.id}'),
                title: Text('${item.description}'),
                trailing: const Icon(Icons.menu),
              ),
            )
            .toList(),
        onReorder: (int start, int current) {
          // dragging from top to bottom
          if (start < current) {
            final int end = current - 1;
            final StockEntity startItem = stock[start];
            int i = 0;
            int local = start;
            do {
              stock[local] = stock[++local];
              i++;
            } while (i < end - start);
            stock[end] = startItem;
          }
          // dragging from bottom to top
          else if (start > current) {
            final StockEntity startItem = stock[start];
            for (int i = start; i > current; i--) {
              stock[i] = stock[i - 1];
            }
            stock[current] = startItem;
          }
          setState(() {});
        },
      );
}
