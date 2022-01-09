import 'package:app_mobile/data/models/user_model.dart';
import 'package:hive/hive.dart';
import 'package:app_mobile/data/datasources/constants/local_database_type_constants.dart';

part 'user_table.g.dart';

@HiveType(typeId: HypeTypeIdConstants.userTableId)
class UserTable extends UserModel {
  UserTable({
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
