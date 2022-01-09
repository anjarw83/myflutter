import 'package:app_mobile/common/bloc/authentication_bloc/authentication_bloc.dart';
import 'package:app_mobile/common/bloc/authentication_bloc/authentication_event.dart';
import 'package:app_mobile/common/bloc/authentication_bloc/authentication_state.dart';
import 'package:app_mobile/common/injector/injector.dart';
import 'package:app_mobile/domain/entities/user_entity.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MyAccount extends StatefulWidget {
  const MyAccount({Key key, UserEntity userEntity}) : super(key: key);

  @override
  _MyAccount createState() => _MyAccount();
}

class _MyAccount extends State<MyAccount> {
  AuthenticationBloc authenticationBloc;

  UserEntity userEntity = UserEntity();

  @override
  void initState() {
    authenticationBloc = Injector.resolve<AuthenticationBloc>();
    authenticationBloc.add(FetchAuthUser());
    super.initState();
  }

  @override
  void dispose() {
    authenticationBloc?.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider<AuthenticationBloc>(
      create: (_) => authenticationBloc,
      child: BlocConsumer<AuthenticationBloc, AuthenticationState>(
        builder: (context, state) {
          if (state is AuthUserState) {
            return _buildProfile();
          } else {
            return Container();
          }
        },
      listener: (context, state) {
          switch(state.runtimeType){
            case AuthUserState:
              final AuthUserState _state = state;
              userEntity = _state.user;
              break;
          }
      },
      ),
    );
  }

  ListView _buildProfile() => ListView(
        children: <Widget>[
          Container(
            height: 250,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [Colors.blue, Colors.blueAccent.shade700],
                begin: Alignment.centerLeft,
                end: Alignment.centerRight,
                stops: [0.5, 0.9],
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: <Widget>[
                    CircleAvatar(
                      backgroundColor: Colors.white70,
                      minRadius: 60.0,
                      child: CircleAvatar(
                        radius: 50.0,
                        backgroundImage: NetworkImage(
                          userEntity.image.toString(),
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 10,
                ),
                Text(
                  userEntity.displayName,
                  style: TextStyle(
                    fontSize: 35,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                Text(
                  'Developer',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 25,
                  ),
                ),
              ],
            ),
          ),
          Container(
            child: Column(
              children: <Widget>[
                ListTile(
                  title: Text(
                    'Email',
                    style: TextStyle(
                      color: Colors.blueAccent,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  subtitle: Text(
                    userEntity.email,
                    style: TextStyle(
                      fontSize: 18,
                    ),
                  ),
                ),
                Divider(),
                ListTile(
                  title: Text(
                    'GitHub',
                    style: TextStyle(
                      color: Colors.blueAccent,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  subtitle: Text(
                    'https://github.com',
                    style: TextStyle(
                      fontSize: 18,
                    ),
                  ),
                ),
                Divider(),
                ListTile(
                  title: Text(
                    'Linkedin',
                    style: TextStyle(
                      color: Colors.blueAccent,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  subtitle: Text(
                    'https://www.linkedin.com',
                    style: TextStyle(
                      fontSize: 18,
                    ),
                  ),
                ),
              ],
            ),
          )
        ],
      );
}
