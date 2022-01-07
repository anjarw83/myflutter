import 'package:app_mobile/domain/entities/stock_entity.dart';

abstract class StockRepository {
  Future<StockEntity> getStock(String keyword);
}