import 'package:app_mobile/common/network/http/default_remote_data_client.dart';
import 'package:app_mobile/data/datasources/constants/stock_remote_constants.dart';
import 'package:app_mobile/data/models/stock_model.dart';

class StockRemoteDataSource {
  final DefaultRemoteClient remoteDataClient;

  StockRemoteDataSource({
    this.remoteDataClient,
  });

  Future<StockModel> getStock(String keyword) async {
    String url = StockEndpoints.getStock;

    final Map<String, Object> response = await remoteDataClient.get(url);
    return StockModel.fromJson(response);
  }
}
