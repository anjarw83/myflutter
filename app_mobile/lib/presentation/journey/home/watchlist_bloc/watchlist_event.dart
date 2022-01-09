import 'package:app_mobile/domain/entities/stock_entity.dart';
import 'package:flutter/material.dart';

abstract class WatchlistEvent {}

class FetchWatchlistEvent extends WatchlistEvent {
  String userId;

  FetchWatchlistEvent({
    @required this.userId,
  });
}

class UpdateWatchlistEvent extends WatchlistEvent {
  String userId;
  List<StockEntity> stocks;

  UpdateWatchlistEvent({
    @required this.userId,
    @required this.stocks,
  });
}
