import 'package:flutter/material.dart';
//import 'package:smart_building/domain/user.dart';
//import 'package:smart_building/providers/user_provider.dart';
import 'package:provider/provider.dart';
import 'package:smart_building/providers/auth.dart';
import 'package:smart_building/utils/widgets.dart';
import 'package:smart_building/utils/burgermenu.dart';


class Home extends StatelessWidget {
  const Home({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    AuthProvider auth = Provider.of<AuthProvider>(context);

    final loginLabel = Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        TextButton(
          //padding: EdgeInsets.all(0.0),
          child: const Text("Let's start",
              style: TextStyle(fontWeight: FontWeight.w300)),
          onPressed: () {
           Navigator.pushReplacementNamed(context, '/login');
          },
        ),
      ],
    );

    return Scaffold(
      appBar: const CustomAppBar("Home page", mainThemeColor, mainTextButtonColor),
      drawer: const CustomDrawer(mainThemeColor, mainTextButtonColor, mainTextColor),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.network('https://www.meme-arsenal.com/memes/e77529bc5454bebb776dbefd127f68f5.jpg'),
            const Text("WELCOME PAGE"),
            loginLabel
          ],
        ),
      ),
    );
  }
}