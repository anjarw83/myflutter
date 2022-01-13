import 'package:flutter/material.dart';
import 'dart:convert';

class AuthenticationUtil {

  static dynamic parseJwt(Map<String, dynamic> jwt){
    final decodedJwt = json.decode(
        ascii.decode(
            base64.decode(base64.normalize(jwt['accessToken'].split('.')[1]))
        )
    );
    debugPrint('DecodedJWT : $decodedJwt');
   return decodedJwt;
  }
}