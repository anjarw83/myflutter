import 'package:app_mobile/common/network/http/default_remote_data_client.dart';
import 'package:app_mobile/data/datasources/constants/stock_remote_constants.dart';
import 'package:app_mobile/data/models/stock_model.dart';
import 'package:flutter/material.dart';

class StockRemoteDataSource {
  final DefaultRemoteClient remoteDataClient;

  StockRemoteDataSource({
    this.remoteDataClient,
  });

  Future<List<StockModel>> getStock(String keyword) async {
    final String url = StockEndpoints.getStock;
    debugPrint('StockRemoteDS::getStock');

    final Map<String, dynamic> response = await remoteDataClient.get(url);
    return StockModel.fromJson(response);
  }
}
