import 'package:app_mobile/common/bloc/authentication_bloc/authentication_event.dart';
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
  UserSharedPreference userPrefs;

  AuthenticationBloc({
    this.authenticationUseCase,
    this.userPrefs,
  }) : super(InitAuthentication());

  @override
  Stream<AuthenticationState> mapEventToState(
      AuthenticationEvent event,) async* {
    switch (event.runtimeType) {
      case LoggingInEvent:

        yield* _mapLoggingInToState(event);
        break;
      case LoggingOutEvent:
        yield* _mapLoggedOutToState(event);
        break;
      case FetchAuthUser:
        final prefs = await SharedPreferences.getInstance();
        userPrefs = UserSharedPreference(prefs: prefs);
        yield* _mapAuthUserToState(event);
        break;
    }
  }

  Stream<AuthenticationState> _mapLoggedOutToState(
      LoggingOutEvent event) async* {
    debugPrint('AuthenticationBloc:Emit [UnAuthenticated]');
    await authenticationUseCase.loggingOut();
    yield UnAuthenticated();
  }

  Stream<AuthenticationState> _mapLoggingInToState(
      LoggingInEvent event) async* {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      userPrefs = UserSharedPreference(prefs: prefs);

      final user = UserEntity.fromJson(event.userMap);

      await userPrefs.setAll(user);
      yield Authenticated(user: user);
    } catch (error){
      debugPrint('Error While Parsing');
      debugPrint(error.toString());
      yield UnAuthenticated();
    }
  }

  Stream<AuthenticationState> _mapAuthUserToState(FetchAuthUser event) async*{
    try{
      SharedPreferences prefs = await SharedPreferences.getInstance();
      userPrefs = UserSharedPreference(prefs: prefs);

      final user = await userPrefs.getAll();
      yield AuthUserState(user: user);
    }catch(error){
      debugPrint('Error AUthUser');
      debugPrint(error.toString());
      yield AuthUserFailed();
    }
  }
}
