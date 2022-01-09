import 'package:app_mobile/data/models/stock_model.dart';
import 'package:app_mobile/domain/entities/stock_entity.dart';
import 'package:app_mobile/domain/entities/watchlist_entity.dart';
import 'package:flutter/material.dart';

class WatchlistModel extends WatchlistEntity {
  WatchlistModel({
    String id,
    String userId,
    List<StockEntity> items,
    DateTime createdAt,
    DateTime updatedAt,
  }) : super(
          id: id,
          userId: userId,
          items: items,
          createdAt: createdAt,
          updatedAt: updatedAt,
        );

  static List<StockModel> fromJson(Map<String, dynamic> jsonMap) {
    if (jsonMap['data'] != null) {
      final List<dynamic> data = jsonMap['data']['items'];
      return data
          .map((json) => StockModel(
                id: json['_id'] ?? '',
                currency: json['currency'] ?? '',
                description: json['description'] ?? '',
                displaySymbol: json['displaySymbol'] ?? '',
                figi: json['figi'] ?? '',
                isin: json['isin'] ?? '',
                mic: json['mic'] ?? '',
                symbol: json['symbol'] ?? '',
                symbol2: json['symbol2'] ?? '',
                type: json['type'] ?? '',
                watchlist: json['watchlist'] ?? false,
              ))
          .toList();
    }
    return [];
  }

  static List<Map<String, dynamic>> toJson(List<StockEntity> watchlist) {
    final List<Map<String, dynamic>> result = [];

    for (final item in watchlist) {
      result.add({
        '_id': item.id,
        'currency': item.currency,
        'description': item.description,
        'displaySymbol': item.displaySymbol,
        'figi': item.figi,
        'isin': item.isin,
        'mic': item.mic,
        'symbol': item.symbol,
        'symbol2': item.symbol2,
        'type': item.type,
        'watchlist': item.watchlist ?? false,
      });
    }
    return result;
  }
}
