import 'package:app_mobile/domain/entities/user_entity.dart';

class UserModel extends UserEntity {
  UserModel({
    String id,
    String googleId,
    String displayName,
    String firstName,
    String lastName,
    String image,
    String token,
    String email,
  }) : super(
          id: id,
          googleId: googleId,
          displayName: displayName,
          firstName: firstName,
          lastName: lastName,
          image: image,
          token: token,
          email: email,
        );
}
