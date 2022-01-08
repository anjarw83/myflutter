import 'package:app_mobile/common/network/http/default_remote_data_client.dart';
import 'package:app_mobile/data/datasources/constants/stock_remote_constants.dart';
import 'package:app_mobile/data/models/stock_model.dart';
import 'package:flutter/material.dart';

class StockRemoteDataSource {
  final DefaultRemoteClient remoteDataClient;

  StockRemoteDataSource({
    this.remoteDataClient,
  });

  Future<List<StockModel>> getStock(String keyword, int page, int limit) async {
    String url = StockEndpoints.stock;
    if (keyword != null) {
      url = '${StockEndpoints.stock}?search=$keyword&page=$page&limit=$limit';
    }
    debugPrint('StockRemoteDS::getStock');

    final Map<String, dynamic> response = await remoteDataClient.get(url);
    return StockModel.fromJson(response);
  }

  Future<bool> toggleStockWatchlist(String id, bool watchlist) async {
    final String url = '${StockEndpoints.stock}/$id/watchlist';
    final body = {'watchlist': watchlist};
    try {
      await remoteDataClient.patch(url, body);
      return true;
    } catch (error) {
      debugPrint(error.toString());
      return false;
    }
  }
}
