import 'package:flutter/material.dart';
import 'package:smart_building/providers/auth.dart';
import 'package:smart_building/utils/widgets.dart';
import 'package:provider/provider.dart';
import 'package:smart_building/utils/accordion.dart';
import 'package:smart_building/utils/burgermenu.dart';

class Building extends StatefulWidget {
  const Building({Key? key}) : super(key: key);

  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Building> {
  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
     AuthProvider auth = Provider.of<AuthProvider>(context);

    return const Scaffold(
      appBar: CustomAppBar("Building", mainThemeColor, mainTextButtonColor),
      drawer: CustomDrawer(mainThemeColor, mainTextButtonColor, mainTextColor),
      body: AccordionList(),
      );
  }
}
