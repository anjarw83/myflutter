import 'dart:convert';

import 'package:app_mobile/common/config/configurations.dart';
import 'package:app_mobile/common/utils/utils.dart';
import 'package:http/http.dart';
import 'package:flutter/material.dart';
import 'package:flutter/material.dart';

class BaseRemoteDataClient {
  Client client;
  String host;
  String token;
  Map<String, String> header;

  BaseRemoteDataClient({
    this.host,
    this.header,
    this.token,
  }) {
    setUpClient();
  }

  String get accessToken => Configurations.accessToken;

  void setUpClient() {
    debugPrint('setupClient');
    client = Client();
    host = Configurations.remoteHost;
    debugPrint('RemoteHost: $host');
  }

  Map<String, String> generateRequestHeader([
    Map<String, String> overrideHeader = const {},
  ]) =>
      {
        'content-type': 'application/json',
        'Authorization': 'Bearer $accessToken',
        ...overrideHeader,
      };

  Uri getParsedUrl(String path) {
    return Uri.parse('$host$path');
  }

  dynamic getResponse(Response response) {
    // Todo: Handle by Utils
    return Utils.getResponse(response);

    // final Map<String, dynamic> result = json.decode(response.body);
    // return result;
  }

  dynamic get(String path,
      {Map<String, String> overrideHeader = const {}}) async {
    debugPrint('[Method.GET][BaseRemoteDataClient]');
    final requestHeader = generateRequestHeader(overrideHeader);

    final Response response =
        await client.get(getParsedUrl(path), headers: requestHeader);

    debugPrint('[GET] $path}');
    debugPrint('Response ${response.body.toString()}');
    return getResponse(response);
  }

  dynamic patch(String path, dynamic data,
      {Map<String, String> overrideHeader = const {}}) async {
    debugPrint('[Method.Patch][BaseRemoteDataClient]');
    final requestHeader = generateRequestHeader(overrideHeader);

    final Response response = await client.patch(
      getParsedUrl(path),
      body: json.encode(data),
      headers: requestHeader,
    );

    debugPrint('[PATCH] $path}');
    debugPrint('Response ${response.body.toString()}');
    return getResponse(response);
  }
}
