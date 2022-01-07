import 'package:app_mobile/data/datasources/remotes/stock_remote_datasources.dart';
import 'package:app_mobile/domain/entities/stock_entity.dart';
import 'package:app_mobile/domain/repositories/stock_repository.dart';
import 'package:flutter/material.dart';

class StockRepositoryImpl implements StockRepository {
  final StockRemoteDataSource stockRemoteDataSource;

  StockRepositoryImpl({
    @required this.stockRemoteDataSource,
  });

  @override
  Future<List<StockEntity>> getStock(String keyword) async {
    final data = await stockRemoteDataSource.getStock(keyword);

    return data;
  }
}