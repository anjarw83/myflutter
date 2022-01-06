import 'package:app_mobile/presentation/journey/home/home_screen.dart';
import 'package:flutter/material.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: _loginButton(context),
    );
  }

  Widget _loginButton(BuildContext context) {
    return ElevatedButton(
        child: const Text('Goto Home'),
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const HomeScreen(),
            ),
          );
        });
  }
}
