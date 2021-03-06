import 'package:app_mobile/domain/entities/stock_entity.dart';

abstract class StockRepository {
  Future<List<StockEntity>> getStock(String keyword, int page, int limit);

  Future<bool> toggleStockWatchlist(String id, bool watchlist);
}