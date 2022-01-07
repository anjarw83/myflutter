import 'package:app_mobile/domain/usecases/stock_usecase.dart';
import 'package:app_mobile/presentation/journey/home/stock_bloc/stock_event.dart';
import 'package:app_mobile/presentation/journey/home/stock_bloc/stock_state.dart';
import 'package:flutter/material.dart';
import 'package:bloc/bloc.dart';

class StockBloc extends Bloc<StockEvent, StockState> {
  StockUseCase stockUseCase;

  StockBloc({
    @required this.stockUseCase,
  }): super(StockInitialState());

  @override
  Stream<StockState> mapEventToState(
      StockEvent event,
      ) async* {
    debugPrint('MapEventToState');
    switch(event.runtimeType){
      case StockInitEvent:
        debugPrint('Emit Initial Event');
        yield StockInitialState();
        break;
      case FetchStockEvent:
        yield* _mapFetchStockToState(event);
        break;
    }
  }

  Stream<StockState> _mapFetchStockToState(FetchStockEvent event) async*{
    yield StockLoadingState();

    try{
      final result = await stockUseCase.getStock(event.keyword);
      yield StockLoadedState(stockEntity: result);
    } catch (error){
      yield StockLoadFailedState();
    }
  }
}
