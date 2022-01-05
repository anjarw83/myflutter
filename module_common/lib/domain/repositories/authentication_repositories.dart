abstract class AuthenticationRepository {
  Future<String> loginGoogle(String username, String password);

  Future<String> refreshAccessToken();
}
