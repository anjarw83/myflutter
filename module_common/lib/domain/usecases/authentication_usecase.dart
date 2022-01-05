import 'package:flutter/material.dart';
import 'package:module_common/domain/repositories/authentication_repositories.dart';

class AuthenticationUseCase {
  final AuthenticationRepository authenticationRepository;

  AuthenticationUseCase({
    @required this.authenticationRepository,
  });

  Future<String> loginGoogle(String username, String password)async{

  }
}
