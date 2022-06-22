import 'package:flutter/material.dart';
import 'package:smart_building/providers/user_provider.dart';
import 'package:provider/provider.dart';
import 'package:smart_building/domain/user.dart';
import 'package:smart_building/providers/auth.dart';

class CustomDrawer extends Drawer {
  final Color backgroundColor;
  final Color topicColor;
  final Color textColor;

  const CustomDrawer(this.backgroundColor, this.topicColor, this.textColor,
      {Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    AuthProvider auth = Provider.of<AuthProvider>(context, listen: true);
    User user = Provider.of<UserProvider>(context, listen: true).user;

    if (auth.loggedInStatus != Status.loggedIn) {
      return Drawer(
        child: ListView(
          // Important: Remove any padding from the ListView.
          padding: EdgeInsets.zero,
          children: [
            ListTile(
              leading: const Icon(Icons.login),
              title: Text('Log in', style: TextStyle(color: textColor)),
              onTap: () {
                Navigator.pushReplacementNamed(context, '/login');
              },
            ),
          ],
        ),
      );
    }
    return Drawer(
      child: ListView(
        // Important: Remove any padding from the ListView.
        padding: EdgeInsets.zero,
        children: [
          DrawerHeader(
            margin: EdgeInsets.zero,
            padding: EdgeInsets.zero,
            child: Scaffold(
              body: UserAccountsDrawerHeader(
                  margin: EdgeInsets.zero,
                  decoration: BoxDecoration(
                    color: backgroundColor,
                  ),
                  accountEmail: Text(user.email),
                  accountName: Text(user.name),
                  currentAccountPicture: Image.network(user.profilePhoto)),
            ),
          ),
          ListTile(
            title: Text('Building', style: TextStyle(color: textColor)),
            leading: const Icon(Icons.house),
            onTap: () {
              Navigator.pushReplacementNamed(context, '/building');
            },
          ),
          ListTile(
            title: Text('Users', style: TextStyle(color: textColor)),
            leading: const Icon(Icons.group),
            onTap: () {
              // Update the state of the app
              // ...
              // Then close the drawer
              //Navigator.pop(context);
            },
          ),
          ListTile(
            title: Text('Settings', style: TextStyle(color: textColor)),
            leading: const Icon(Icons.settings),
            onTap: () {
              // Update the state of the app
              // ...
              // Then close the drawer
              //Navigator.pop(context);
            },
          ),
          ListTile(
            title: Text('Log out', style: TextStyle(color: textColor)),
            leading: const Icon(Icons.logout),
            onTap: () {
              auth.logout();
              Navigator.pushReplacementNamed(context, '/login');
              // Update the state of the app
              // ...
              // Then close the drawer
              //Navigator.pop(context);
            },
          )
        ],
      ),
    );
  }
}
