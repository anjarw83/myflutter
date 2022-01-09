import 'package:app_mobile/data/datasources/remotes/authentication_remote_datasource.dart';
import 'package:app_mobile/domain/repositories/authentication_repository.dart';

class AuthenticationRepositoryImpl implements AuthenticationRepository {
  final AuthenticationRemoteDatasource authenticationRemoteDatasource;

  AuthenticationRepositoryImpl({
    this.authenticationRemoteDatasource,
  });

  @override
  Future<void> loggingOut()async {
    await authenticationRemoteDatasource.loggingOut();
  }
}
