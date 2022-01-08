import 'package:flutter/material.dart';

abstract class StockEvent {}

class StockInitEvent extends StockEvent {}

class FetchStockEvent extends StockEvent {
  final String keyword;
  final int limit;

  FetchStockEvent({
    @required this.keyword,
    @required this.limit,
  });
}

class ToggleStockWatchlistEvent extends StockEvent {
  final String id;
  final bool status;

  ToggleStockWatchlistEvent({
    @required this.id,
    @required this.status,
  });
}

class LoadMoreStockEvent extends StockEvent {
  final String keyword;
  final int page;
  final int limit;

  LoadMoreStockEvent({
    this.keyword = '',
    this.page = 1,
    this.limit = 20,
  });
}
