import 'package:app_mobile/presentation/journey/home/widgets/account_widget.dart';
import 'package:app_mobile/presentation/journey/home/widgets/sidebar_menu.dart';
import 'package:app_mobile/presentation/journey/home/widgets/stock_widget.dart';
import 'package:app_mobile/presentation/journey/home/widgets/watchlist_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) => _buildTabController(context);

  Widget _buildTabController(BuildContext context) => MaterialApp(
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


  TabBar _tabBar() => TabBar(
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

  TabBarView _tabBarView() => const TabBarView(
        children: [
          MyAccount(),
          Stocks(),
          Watchlist(),
        ],
      );
}
