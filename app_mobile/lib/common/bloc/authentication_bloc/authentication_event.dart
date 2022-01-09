abstract class AuthenticationEvent {
  final String userId;

  AuthenticationEvent(this.userId);
}

class LoggingInEvent extends AuthenticationEvent {
  LoggingInEvent({String userId}) : super(userId);
}

class LoggingOutEvent extends AuthenticationEvent {
  LoggingOutEvent({String userId}) : super(userId);
}
