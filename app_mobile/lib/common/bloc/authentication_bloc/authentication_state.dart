import 'package:app_mobile/domain/entities/user_entity.dart';

abstract class AuthenticationState {
  final String userId;

  AuthenticationState({this.userId});
}

class InitAuthentication extends AuthenticationState {}

class Authenticated extends AuthenticationState {
  final UserEntity user;

  Authenticated({
    this.user,
  });
}

class AuthUserState extends AuthenticationState {
  final UserEntity user;

  AuthUserState({
    this.user,
  });
}

class AuthUserFailed extends AuthenticationState {}

class UnAuthenticated extends AuthenticationState {}
