import 'dart:convert';

import 'package:app_mobile/domain/entities/default_response_entity.dart';
import 'package:http/http.dart';

class Utils {

  static DefaultResponseEntity getResponse(Response response){

    return DefaultResponseEntity(
      statusCode: response.statusCode,
      body: json.decode(response.body),
      headers: response.headers
    );
  }
}