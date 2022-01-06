import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class Routes {
  static Route<dynamic> generateRoutes(
      RouteSettings settings,
      ) {
    RouteSettings loginSetting = settings;
    if( settings.name != null) {
      loginSetting = _getRoutingData(settings.name);
    }
  }

  static RouteSettings _getRoutingData(String input){
    final uriData = Uri.parse(input);

    return RouteSettings(
      arguments: uriData.queryParameters,
      name: uriData.path
    );
  }
}