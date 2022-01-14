import 'package:app_mobile/data/models/stock_model.dart';
import 'package:app_mobile/domain/entities/default_response_entity.dart';
import 'package:app_mobile/domain/entities/stock_entity.dart';
import 'package:flutter/material.dart';
import 'package:app_mobile/common/network/http/default_remote_data_client.dart';
import 'package:app_mobile/data/datasources/constants/watchlist_remote_constants.dart';
import 'package:app_mobile/data/models/watchlist_model.dart';

class WatchlistRemoteDatasource {
  final DefaultRemoteClient remoteClient;

  WatchlistRemoteDatasource({
    this.remoteClient,
  });

  Future<List<StockModel>> getWatchlistByUserId(String userId) async {
    final url = '${WatchlistConstants.watchlist}/$userId';


    final DefaultResponseEntity response = await remoteClient.get(url);
    return  WatchlistModel.fromJson(response.body);
  }

  Future<bool> updateWatchlistByUserId(
      String userId, List<StockEntity> listStock) async {
    final url = '${WatchlistConstants.watchlist}/$userId';
    final data = {
      'data': WatchlistModel.toJson(listStock)
    };

    try{
      final DefaultResponseEntity response = await remoteClient
          .patch(url, data);
      if(response.statusCode == 204){
        return true;
      }
    }catch(error){
      debugPrint(error.toString());
      return false;
    }
    return true;
  }
}
