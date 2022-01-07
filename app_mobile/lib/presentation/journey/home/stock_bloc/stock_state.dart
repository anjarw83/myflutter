import 'package:app_mobile/domain/entities/stock_entity.dart';

abstract class StockState {}

class StockInitialState extends StockState {}

class StockLoadingState extends StockState {}

class StockLoadedState extends StockState {
  final StockEntity stockEntity;

  StockLoadedState({
    this.stockEntity,
  });
}

class StockLoadFailedState extends StockState {}
