import 'package:app_mobile/domain/entities/stock_entity.dart';

abstract class StockState {}

class StockInitialState extends StockState {}

class StockLoadingState extends StockState {}

class StockLoadedState extends StockState {
  final List<StockEntity> listStockEntity;

  StockLoadedState({
    this.listStockEntity,
  });
}

class StockLoadFailedState extends StockState {}

class StockWatchListUpdatingState extends StockState {}

class StockWatchListUpdateSuccessState extends StockState {}

class StockWatchListUpdateFailedState extends StockState {}
