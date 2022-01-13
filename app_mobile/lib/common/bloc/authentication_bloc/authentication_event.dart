abstract class AuthenticationEvent {
  final String userId;

  AuthenticationEvent(this.userId);
}

class InitialAuthEvent extends AuthenticationEvent {
  InitialAuthEvent({
    String userId,
  }) : super(userId);
}

class LoggingInEvent extends AuthenticationEvent {
  final Map<String, dynamic> userMap;

  LoggingInEvent({
    String userId,
    this.userMap,
  }) : super(userId);
}

class FetchAuthUser extends AuthenticationEvent {
  FetchAuthUser({
    String userId,
  }) : super(userId);
}

class LoggingOutEvent extends AuthenticationEvent {
  LoggingOutEvent({
    String userId,
  }) : super(userId);
}
