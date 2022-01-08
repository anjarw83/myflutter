import 'package:app_mobile/domain/usecases/stock_usecase.dart';
import 'package:app_mobile/presentation/journey/home/stock_bloc/stock_event.dart';
import 'package:app_mobile/presentation/journey/home/stock_bloc/stock_state.dart';
import 'package:flutter/material.dart';
import 'package:bloc/bloc.dart';

class StockBloc extends Bloc<StockEvent, StockState> {
  StockUseCase stockUseCase;

  StockBloc({
    @required this.stockUseCase,
  }) : super(StockInitialState());

  @override
  Stream<StockState> mapEventToState(
    StockEvent event,
  ) async* {
    debugPrint('MapEventToState');
    switch (event.runtimeType) {
      case StockInitEvent:
        debugPrint('Emit Initial Event');
        yield StockInitialState();
        break;
      case FetchStockEvent:
        yield* _mapFetchStockToState(event);
        break;
      case ToggleStockWatchlistEvent:
        yield* _mapToggleWatchlist(event);
        break;
      case LoadMoreStockEvent:
        yield* _mapLoadMoreStock(event);
        break;
    }
  }

  Stream<StockState> _mapFetchStockToState(FetchStockEvent event) async* {
    const page = 1;
    yield StockLoadingState();
    debugPrint('BLOC: Search ${event.keyword}');
    try {
      final result =
          await stockUseCase.getStock(event.keyword, page, event.limit);
      yield StockLoadedState(listStockEntity: result);
    } catch (error) {
      yield StockLoadFailedState();
    }
  }

  Stream<StockState> _mapToggleWatchlist(
      ToggleStockWatchlistEvent event) async* {
    yield StockWatchListUpdatingState();
    try {
      await stockUseCase.toggleStockWatchlist(
        event.id,
        event.status,
      );
      yield StockWatchListUpdateSuccessState();
    } catch (error) {
      debugPrint(error.toString());
      yield StockWatchListUpdateFailedState();
    }
  }

  Stream<StockState> _mapLoadMoreStock(LoadMoreStockEvent event) async* {
    yield LoadMoreStockInProgressState();
    try {
      final result =
          await stockUseCase.getStock(event.keyword, event.page, event.limit);
      yield LoadMoreStockSuccessState(listStockEntity: result);
    } catch (error) {
      debugPrint(error.toString());
      yield LoadMoreStockFailedState();
    }
  }
}
