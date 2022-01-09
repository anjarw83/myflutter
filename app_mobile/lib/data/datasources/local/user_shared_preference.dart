import 'package:app_mobile/domain/entities/user_entity.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserSharedPreference {
  UserEntity userEntity = UserEntity();
  final SharedPreferences prefs;

  UserSharedPreference({this.prefs});

  Future<UserEntity> getAll() async {
    userEntity
      ..id = prefs.getString('id')
      ..displayName = prefs.getString('displayName')
      ..email = prefs.getString('email')
      ..googleId = prefs.getString('googleId')
      ..image = prefs.getString('image')
      ..token = prefs.getString('token');
    return userEntity;
  }

  Future<void> setAll(UserEntity user) async {
    await prefs.setString('id', user.id);
    await prefs.setString('displayName', user.displayName);
    await prefs.setString('email', user.email);
    await prefs.setString('googleId', user.googleId);
    await prefs.setString('image', user.image);
    await prefs.setString('token', user.token);
  }

  Future<String> getString(String key) async {
    return prefs.getString(key);
  }

  Future<void> setString(String key, String value) async {
    await prefs.setString(key, value);
  }

  Future<void> removeAll() async {
    await prefs.remove('id');
    await prefs.remove('displayName');
    await prefs.remove('email');
    await prefs.remove('googleId');
    await prefs.remove('image');
    await prefs.remove('token');
  }
}
