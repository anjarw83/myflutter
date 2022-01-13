import 'package:app_mobile/common/bloc/authentication_bloc/authentication_bloc.dart';
import 'package:app_mobile/common/bloc/authentication_bloc/authentication_event.dart';
import 'package:app_mobile/common/injector/injector.dart';
import 'package:app_mobile/presentation/app.dart';
import 'package:flutter/material.dart';

class SideBarMenu extends StatelessWidget {
  const SideBarMenu({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          Container(
            height: 122.0,
            child: const DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.lime,
              ),
              child: Text(
                'Menu',
                style: TextStyle(color: Colors.white, fontSize: 25),
              ),
            ),
          ),
          ListTile(
            leading: const Icon(Icons.exit_to_app),
            title: const Text('Logout'),
            onTap: () => _logout(context),
          ),
        ],
      ),
    );
  }

  void _logout(BuildContext context) {
    debugPrint('Proceed LoggingOut');
    Injector.resolve<AuthenticationBloc>().add(
      LoggingOutEvent(),
    );
  }
}
