abstract class AuthenticationState {
  final String userId;

  AuthenticationState({this.userId});
}

class InitAuthentication extends AuthenticationState {}

class Authenticated extends AuthenticationState {}

class UnAuthenticated extends AuthenticationState {}
