import 'package:app_mobile/common/bloc/authentication_bloc/authentication_bloc.dart';
import 'package:app_mobile/common/bloc/authentication_bloc/authentication_event.dart';
import 'package:app_mobile/common/bloc/authentication_bloc/authentication_state.dart';
import 'package:app_mobile/common/injector/injector.dart';
import 'package:app_mobile/domain/entities/user_entity.dart';
import 'package:app_mobile/presentation/journey/home/widgets/account_widget.dart';
import 'package:app_mobile/presentation/journey/home/widgets/sidebar_menu.dart';
import 'package:app_mobile/presentation/journey/home/widgets/stock_widget.dart';
import 'package:app_mobile/presentation/journey/home/widgets/watchlist_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../app.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  AuthenticationBloc authenticationBloc;
  UserEntity userEntity;

  @override
  void initState() {
    authenticationBloc = Injector.resolve<AuthenticationBloc>();
    authenticationBloc.add(FetchAuthUser());
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  // Widget build(BuildContext context) => _buildTabController(context);
  Widget build(BuildContext context) =>
      BlocProvider<AuthenticationBloc>(
        create: (_) => authenticationBloc,
        child: BlocConsumer<AuthenticationBloc, AuthenticationState>(
          builder: (context, state) {
            switch (state.runtimeType) {
              case InitAuthenticationState:
                return const CircularProgressIndicator();
              case AuthUserState:
                if (userEntity.googleId.isNotEmpty) {
                  return _buildTabController(context);
                }
                return _UnAuthorizedAccess();
              default:
                return _UnAuthorizedAccess();
            }
          },
          listener: (context, state) {
            switch (state.runtimeType) {
              case AuthUserState:
                final AuthUserState _state = state;
                userEntity = _state.user;
                break;
              case UnAuthenticated:
                Navigator.pop(
                  context
                );
                break;
              default:
                userEntity = null;
                break;
            }
          },
        ),
      );

  Widget _buildTabController(BuildContext context) =>
      MaterialApp(
        home: DefaultTabController(
          length: 3,
          child: Scaffold(
            drawer: const SideBarMenu(),
            appBar: AppBar(
              title: const Text('Home'),
              bottom: PreferredSize(
                preferredSize: const Size.fromHeight(15.0),
                child: _tabBar(),
              ),
            ),
            body: _tabBarView(),
          ),
        ),
      );

  TabBar _tabBar() =>
      TabBar(
        tabs: [
          const Text(
            'Account',
            style: TextStyle(fontSize: 20),
          ),
          const Text(
            'Stocks',
            style: TextStyle(fontSize: 20),
          ),
          SvgPicture.asset(
            'assets/binoculars.svg',
            height: 25.0,
            width: 25.0,
            semanticsLabel: 'watch',
            color: Colors.white,
          ),
        ],
      );

  TabBarView _tabBarView() =>
      TabBarView(
        children: [
          MyAccount(userEntity: userEntity),
          Stocks(),
          Watchlist(),
        ],
      );

  Widget _UnAuthorizedAccess() =>
      Container(
        child: const Text(
          'UnAuthorized Access',
        ),);
}
