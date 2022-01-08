import 'package:flutter/material.dart';

abstract class StockEvent {}

class StockInitEvent extends StockEvent {}

class FetchStockEvent extends StockEvent {
  final String keyword;

  FetchStockEvent({
    this.keyword,
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
