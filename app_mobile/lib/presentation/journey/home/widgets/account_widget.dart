import 'package:app_mobile/domain/entities/user_entity.dart';
import 'package:flutter/material.dart';

class MyAccount extends StatefulWidget {
  const MyAccount({Key key, UserEntity userEntity}) : super(key: key);

  @override
  _MyAccount createState() => _MyAccount();
}

class _MyAccount extends State<MyAccount> {
  final UserEntity userEntity = UserEntity(
    displayName: 'Anjar Widiyatmoko',
    email: 'anjar.office@gmail.com',
    image:
        'https://lh3.googleusercontent.com/a-/AOh14GhvIEDyzWOwxJhtdpxpdfTTh2gkDTnYt3Yns_U3=s96-c',
    googleId: '108877747181618390708',
  );

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: <Widget>[
        Container(
          height: 250,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [Colors.red, Colors.deepOrange.shade300],
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
                        userEntity.image,
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
                    color: Colors.deepOrange,
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
                    color: Colors.deepOrange,
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
                    color: Colors.deepOrange,
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
}
