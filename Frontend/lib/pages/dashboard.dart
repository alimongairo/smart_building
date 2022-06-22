import 'package:flutter/material.dart';
import 'package:smart_building/domain/user.dart';
import 'package:smart_building/providers/user_provider.dart';
import 'package:provider/provider.dart';
import 'package:smart_building/utils/widgets.dart';
import 'package:smart_building/utils/burgermenu.dart';


class DashBoard extends StatefulWidget {
  const DashBoard({Key? key}) : super(key: key);

  @override
  _DashBoardState createState() => _DashBoardState();
}

class _DashBoardState extends State<DashBoard> {
  @override
  Widget build(BuildContext context) {

    User user = Provider.of<UserProvider>(context).user;

    return Scaffold(
      appBar: const CustomAppBar("Dashboard", mainThemeColor, mainTextButtonColor),
      drawer: const CustomDrawer(mainThemeColor, mainTextButtonColor, mainTextColor),
      body: Column(
        children: [
          const SizedBox(height: 100,),
          Center(child: Text(user.email)),
          const SizedBox(height: 100),
          ElevatedButton(onPressed: (){}, child: const Text("Logout"))
        ],
      ),
    );
  }
}