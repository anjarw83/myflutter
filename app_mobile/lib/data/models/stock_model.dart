import 'package:app_mobile/domain/entities/stock_entity.dart';

class StockModel extends StockEntity {
  StockModel({
    String id,
    String currency,
    String description,
    String displaySymbol,
    String figi,
    String isin,
    String mic,
    String symbol,
    String symbol2,
    String type,
    bool watchlist,
  }) : super(
          id: id,
          currency: currency,
          description: description,
          displaySymbol: displaySymbol,
          figi: figi,
          isin: isin,
          mic: mic,
          symbol: symbol,
          symbol2: symbol2,
          watchlist: watchlist,
        );

  static List<StockModel> fromJson(Map<String, dynamic> jsonMap) {
    if (jsonMap['data'] != null) {
      final List<dynamic> listStock = jsonMap['data'];

      return listStock
          .map((json) => StockModel(
                id: json['id'] ?? '',
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

    return null;
  }
}
