import 'package:app_mobile/common/bloc/authentication_bloc/authentication_bloc.dart';
import 'package:app_mobile/common/bloc/authentication_bloc/authentication_state.dart';
import 'package:flutter/material.dart';
import 'package:app_mobile/presentation/routes.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'home_constants.dart';
import 'journey/login/login_screen.dart';

class App extends StatelessWidget {
  final AuthenticationBloc authenticationBloc;

  const App({
    Key key,
    this.authenticationBloc,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: _getBlocProvider(),
      child: BlocBuilder<AuthenticationBloc, AuthenticationState>(
        builder: (BuildContext context, _) => _buildApp(context),
      ),
    );
  }

  List<BlocProvider> _getBlocProvider() => [
        BlocProvider<AuthenticationBloc>(
          create: (BuildContext context) => authenticationBloc,
        )
      ];

  Widget _buildApp(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.lightBlue,
      ),
      home: const MyHomePage(),
      onGenerateRoute: Routes.generateRoutes,
    );
  }
}

class MyHomePage extends StatelessWidget {
  final AuthenticationBloc authenticationBloc;

  const MyHomePage({
    Key key,
    this.authenticationBloc,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(HomeConstants.homeTitleText),
      ),
      body: const Center(child: LoginScreen(),),
    );
  }
}
