abstract class StockEvent {}

class StockInitEvent extends StockEvent {}

class FetchStockEvent extends StockEvent {
  final String keyword;

  FetchStockEvent({
    this.keyword,
  });
}
