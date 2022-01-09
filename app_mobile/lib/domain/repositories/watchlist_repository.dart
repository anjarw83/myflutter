import 'package:app_mobile/domain/entities/stock_entity.dart';

abstract class WatchlistRepository {
  Future<List<StockEntity>> getWatchlistByUserId(String userId);

  Future<bool> updateWatchlistByUserId(String userId, List<StockEntity> stocks);
}