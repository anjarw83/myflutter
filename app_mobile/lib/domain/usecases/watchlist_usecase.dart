import 'package:app_mobile/data/models/stock_model.dart';
import 'package:app_mobile/domain/entities/stock_entity.dart';
import 'package:app_mobile/domain/repositories/watchlist_repository.dart';
import 'package:flutter/material.dart';

class WatchlistUseCase {
  final WatchlistRepository watchlistRepository;

  WatchlistUseCase({
    @required this.watchlistRepository,
  });

  Future<List<StockModel>> getWatchlistByUserId(String userId) async {
    final response = await watchlistRepository.getWatchlistByUserId(userId);
    return response;
  }

  Future<bool> updateWatchlistByUserId(
      String userId, List<StockEntity> stocks) async {
    final response =
        await watchlistRepository.updateWatchlistByUserId(userId, stocks);
    return response;
  }
}
