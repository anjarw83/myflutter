import 'package:app_mobile/common/bloc/authentication_bloc/authentication_event.dart';
import 'package:app_mobile/common/config/configurations.dart';
import 'package:app_mobile/common/utils/authentication_util.dart';
import 'package:app_mobile/data/datasources/local/user_shared_preference.dart';
import 'package:app_mobile/domain/entities/user_entity.dart';
import 'package:app_mobile/domain/usecases/authentication_usecase.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'authentication_state.dart';

class AuthenticationBloc
    extends Bloc<AuthenticationEvent, AuthenticationState> {
  AuthenticationUseCase authenticationUseCase;

  AuthenticationBloc({
    this.authenticationUseCase,
  }) : super(InitAuthenticationState());

  @override
  Stream<AuthenticationState> mapEventToState(
    AuthenticationEvent event,
  ) async* {
    switch (event.runtimeType) {
      case InitialAuthEvent:
        debugPrint('Bloc:Emit:InitialAuthEvent');
        yield InitAuthenticationState();
        break;
      case LoggingInEvent:
        debugPrint('Bloc:Emit:LoggingInEvent');
        yield* _mapLoggingInToState(event);
        break;
      case LoggingOutEvent:
        debugPrint('Bloc:Emit:LoggingOutEvent');
        yield* _mapLoggedOutToState(event);
        break;
      case FetchAuthUser:
        debugPrint('Bloc:Emit:FetchAuthUser');
        yield* _mapAuthUserToState(event);
        break;
    }
  }

  Stream<AuthenticationState> _mapLoggedOutToState(
      LoggingOutEvent event) async* {
    debugPrint('AuthenticationBloc:Emit [UnAuthenticated]');

    try {
      await authenticationUseCase.loggingOut();
    } catch (error) {
      debugPrint(error.toString());
    }
    yield UnAuthenticated();
  }

  Stream<AuthenticationState> _mapLoggingInToState(
      LoggingInEvent event) async* {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      final userPrefs = UserSharedPreference(prefs: prefs);

      final userMap = AuthenticationUtil.parseJwt(event.userMap);


      final user = UserEntity.fromJson(userMap);

      await userPrefs.setAll(user);

      Configurations.accessToken = event.userMap['accessToken'];
      await userPrefs.setString('accessToken', event.userMap['accessToken']);
      yield Authenticated(user: user);
    } catch (error) {
      debugPrint('Error While Parsing');
      debugPrint(error.toString());
      yield InitAuthenticationState();
    }
  }

  Stream<AuthenticationState> _mapAuthUserToState(FetchAuthUser event) async* {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      final userPrefs = UserSharedPreference(prefs: prefs);

      final user = await userPrefs.getAll();
      yield AuthUserState(user: user);
    } catch (error) {
      debugPrint('Error AUthUser');
      debugPrint(error.toString());
      yield AuthUserFailed();
    }
  }
}
