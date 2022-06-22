import 'package:flutter/material.dart';
import 'package:smart_building/utils/widgets.dart';
import 'package:smart_building/utils/burgermenu.dart';


class Logout extends StatelessWidget {
  const Logout({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      appBar: CustomAppBar("Smart building", mainThemeColor, mainTextButtonColor),
      drawer: CustomDrawer(mainThemeColor, mainTextButtonColor, mainTextColor),
      body: Center(
        child: Text("Thank You"),
      ),
    );
  }
}