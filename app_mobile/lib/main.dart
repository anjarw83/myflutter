import 'package:app_mobile/common/injector/injector_config.dart';
import 'package:app_mobile/presentation/app.dart';
import 'package:flutter/material.dart';

void main() {

  InjectorConfig.setup();
  
  runApp(App());
}


