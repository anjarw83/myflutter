import 'package:app_mobile/common/config/configurations.dart';
import 'package:app_mobile/common/network/http/base_remote_data_client.dart';

class DefaultRemoteClient extends BaseRemoteDataClient {
  DefaultRemoteClient() : super(host: Configurations.remoteHost);
}
