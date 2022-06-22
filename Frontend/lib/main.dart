import 'package:flutter/material.dart';
import 'package:smart_building/pages/dashboard.dart';
import 'package:smart_building/pages/login.dart';
import 'package:smart_building/pages/register.dart';
import 'package:smart_building/pages/home.dart';
import 'package:smart_building/providers/auth.dart';
import 'package:smart_building/providers/user_provider.dart';
import 'package:smart_building/utils/shared_preference.dart';
import 'package:provider/provider.dart';
import 'package:smart_building/pages/buildingpage.dart';

import 'domain/user.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Future<User> getUserData() => UserPreferences().getUser();

    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AuthProvider()),
        ChangeNotifierProvider(create: (_) => UserProvider()),
      ],
      child: MaterialApp(
          title: 'Flutter Demo',
          theme: ThemeData(
            primarySwatch: Colors.blue,
            visualDensity: VisualDensity.adaptivePlatformDensity,
          ),
          home: FutureBuilder(
              future: getUserData(),
              builder: (context, snapshot) {
                //print(snapshot);
                switch (snapshot.connectionState) {
                  case ConnectionState.none:
                  case ConnectionState.waiting:
                    return const CircularProgressIndicator();
                  default:
                    if (snapshot.hasError) {
                      return Text('Error: ${snapshot.hasError}');
                    } else if (snapshot.hasData) {
                      if ((snapshot.data as User).token == "") {
                        return const Home();
                      } else {
                        UserPreferences().removeUser();
                      }
                    }
                    return const Building();
                      //Welcome(user: snapshot.data as User);
                }
                // return const Login();
              }),
          routes: {
            '/building': (context) => const Building(),
            '/dashboard': (context) => const DashBoard(),
            '/login': (context) => const Login(),
            '/register': (context) => const Register(),
          }),
    );
  }
}
