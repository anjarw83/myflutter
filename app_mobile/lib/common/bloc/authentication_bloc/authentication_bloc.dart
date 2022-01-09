import 'package:app_mobile/common/bloc/authentication_bloc/authentication_event.dart';
import 'package:app_mobile/domain/usecases/authentication_usecase.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'authentication_state.dart';

class AuthenticationBloc
    extends Bloc<AuthenticationEvent, AuthenticationState> {
  AuthenticationUseCase authenticationUseCase;

  AuthenticationBloc({
    this.authenticationUseCase,
  }) : super(InitAuthentication());

  @override
  Stream<AuthenticationState> mapEventToState(
    AuthenticationEvent event,
  ) async* {
    switch (event.runtimeType) {
      case LoggingOutEvent:
        yield* _mapLoggedOutToState(event);
    }
  }

  Stream<AuthenticationState> _mapLoggedOutToState(
      LoggingOutEvent event) async* {
    debugPrint('AuthenticationBloc:Emit [UnAuthenticated]');
    await authenticationUseCase.loggingOut();
    yield UnAuthenticated();
  }
}
