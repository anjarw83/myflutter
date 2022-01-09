import 'package:app_mobile/domain/entities/stock_entity.dart';

class WatchlistEntity {
  String id;
  String userId;
  List<StockEntity> items;
  DateTime createdAt;
  DateTime updatedAt;

  WatchlistEntity({
    this.id,
    this.userId,
    this.items,
    this.createdAt,
    this.updatedAt,
  });
}
