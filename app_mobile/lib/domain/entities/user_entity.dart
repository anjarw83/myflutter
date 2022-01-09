class UserEntity {
  String id;
  String googleId;
  String displayName;
  String firstName;
  String lastName;
  String image;
  String token;
  String email;

  UserEntity({
    this.id,
    this.googleId,
    this.displayName,
    this.firstName,
    this.lastName,
    this.image,
    this.token,
    this.email,
  });

  static UserEntity fromJson(Map<String, dynamic> jsonMap){
    return UserEntity(
      id: jsonMap['id']??'',
      googleId: jsonMap['googleId']??'',
      displayName: jsonMap['displayName']??'',
      firstName: jsonMap['firstName']??'',
      lastName: jsonMap['lastName']??'',
      image: jsonMap['image']??'',
      token: jsonMap['token']??'',
      email: jsonMap['email']??'',
    );
  }

}
