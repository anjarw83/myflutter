import 'package:app_mobile/presentation/journey/login/widget/google_signin_button.dart';
import 'package:flutter/material.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      // child: _loginButton(context),
      child: GoogleSignInButton()
    );
  }

}
