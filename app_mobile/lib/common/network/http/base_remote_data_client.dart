import 'package:app_mobile/common/config/configurations.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';

class BaseRemoteDataClient {

  Client client;
  String host;
  String token;
  Map<String, String> header;

  BaseRemoteDataClient({
    this.host,
    this.header,
    this.token,
  })
  {
    setUpClient();
  }


  void setUpClient() {
    client = Client();
    host = Configurations.remoteHost;
  }

  Map<String, String> generateRequestHeader([
    Map<String, String> overrideHeader = const {},
  ]) =>
      {
        ...header,
        ...overrideHeader,
      };

  Uri getParsedUrl(String path) {
    return Uri.parse('$host$path');
  }

  dynamic get(String path,
      {Map<String, String> overrideHeader = const {}
      }) async {
    final requestHeader = generateRequestHeader(overrideHeader);

    final Response response = await client.get(
        getParsedUrl(path),
        headers: requestHeader
    );
    return response;
  }

}