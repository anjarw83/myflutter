import 'package:app_mobile/domain/entities/stock_entity.dart';
import 'package:flutter/material.dart';
import 'package:app_mobile/domain/repositories/stock_repository.dart';

class StockUseCase {
  final StockRepository stockRepository;

  StockUseCase({
    @required this.stockRepository,
  });

  Future<StockEntity> getStock(String keyword) async {
    return stockRepository.getStock(keyword);
  }
}
