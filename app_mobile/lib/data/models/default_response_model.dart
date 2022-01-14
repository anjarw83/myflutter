import 'package:app_mobile/domain/entities/default_response_entity.dart';

class DefaultResponseModel extends DefaultResponseEntity {
  DefaultResponseModel({
    int statusCode,
    Map<String, String> headers,
    Map<String, dynamic> body,
  }) : super(
          statusCode: statusCode,
          headers: headers,
          body: body,
        );
}
