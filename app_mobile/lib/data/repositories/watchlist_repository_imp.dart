import 'package:flutter/material.dart';
import 'package:app_mobile/data/datasources/remotes/watchlist_remote_datasources.dart';
import 'package:app_mobile/domain/entities/stock_entity.dart';
import 'package:app_mobile/domain/repositories/watchlist_repository.dart';

class WatchlistRepositoryImpl implements WatchlistRepository {
  final WatchlistRemoteDatasource watchlistRemoteDatasource;

  WatchlistRepositoryImpl({
    @required this.watchlistRemoteDatasource,
  });

  @override
  Future<List<StockEntity>> getWatchlistByUserId(String userId) async {
    final response =
        await watchlistRemoteDatasource.getWatchlistByUserId(userId);
    return response;
  }

  @override
  Future<bool> updateWatchlistByUserId(
      String userId, List<StockEntity> stocks) async {
    final response =
        await watchlistRemoteDatasource.updateWatchlistByUserId(userId, stocks);
    return response;
  }
}
