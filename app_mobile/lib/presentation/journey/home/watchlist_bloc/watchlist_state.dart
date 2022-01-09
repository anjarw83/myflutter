import 'package:app_mobile/domain/entities/stock_entity.dart';
import 'package:flutter/cupertino.dart';

abstract class WatchlistState {}

class WatchlistInitialState extends WatchlistState {}

class WatchlistLoadingState extends WatchlistState {}

class WatchlistLoadedState extends WatchlistState {
  final List<StockEntity> stocks;

  WatchlistLoadedState({
    @required this.stocks,
  });
}

class WatchlistLoadFailedState extends WatchlistState {}

class UpdatedWatchlistInProgressState extends WatchlistState {}

class UpdatedWatchlistSuccessState extends WatchlistState {
  final List<StockEntity> stocks;

  UpdatedWatchlistSuccessState({
    @required this.stocks,
  });
}

class UpdatedWatchlistFailedState extends WatchlistState {
}
