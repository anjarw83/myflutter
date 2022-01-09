import 'package:app_mobile/domain/repositories/authentication_repository.dart';

class AuthenticationUseCase {
  final AuthenticationRepository authenticationRepository;

  AuthenticationUseCase({
    this.authenticationRepository,
  });

  Future<void> loggingOut() async{
    return authenticationRepository.loggingOut();
  }

}
