import 'package:app_mobile/common/network/http/default_remote_data_client.dart';
import 'package:app_mobile/data/datasources/constants/authentication_remoote_constants.dart';
import 'package:flutter/material.dart';

class AuthenticationRemoteDatasource {
  final DefaultRemoteClient remoteClient;

  AuthenticationRemoteDatasource({
    @required this.remoteClient,
  });

  Future<void> loggingOut() async{
    final String url = AuthenticationEndpoints.loggingOut;
    try{
      await remoteClient.get(url);
    }catch (error){
      debugPrint('Error when loggingOut:');
      debugPrint(error.toString());
    }
  }
}
