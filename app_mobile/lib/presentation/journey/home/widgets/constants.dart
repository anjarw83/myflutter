import 'package:flutter/cupertino.dart';

class StockConstants {
  static const String resultNotFoundText = 'No result found';
  static const String loadMoreFailedText = 'Failed to Fetch More Data';
  static const String searchText = 'Search';
  static const int searchDelay = 1200;
  static const int stockPerPage = 20;
  static const int defaultRowHeight = 50;

  static const ValueKey stockTable = ValueKey('key_stock_table');

  static const String watchlistSuccessUpdated = 'Watchlist Successfully Updated';
}