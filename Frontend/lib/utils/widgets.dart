import 'package:flutter/material.dart';

const Color mainThemeColor = Colors.lightGreen;
const Color mainButtonColor = Colors.green;
const Color mainTextColor = Colors.black;
const Color mainTextButtonColor = Colors.white;

MaterialButton longButtons(String title, VoidCallback fun, Color color,
    {Color textColor = mainTextButtonColor}) {
  return MaterialButton(
    onPressed: fun,
    color: color,
    textColor: textColor,
    child: SizedBox(
      width: double.infinity,
      child: Text(
        title,
        textAlign: TextAlign.center,
      ),
    ),
    height: 45,
    minWidth: 600,
    shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(10))),
  );
}

label(String title) => Text(title);

InputDecoration buildInputDecoration(String hintText, IconData icon) {
  return InputDecoration(
    prefixIcon: Icon(icon, color: const Color.fromRGBO(50, 62, 72, 1.0)),
    // hintText: hintText,
    contentPadding: const EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
    border: OutlineInputBorder(borderRadius: BorderRadius.circular(5.0)),
  );
}

class CustomAppBar extends StatelessWidget with PreferredSizeWidget {
  @override
  final Size preferredSize;

  final String title;
  final Color backgroundColor;
  final Color textColor;

  const CustomAppBar(
    this.title,
    this.backgroundColor,
    this.textColor, {
    Key? key,
  })  : preferredSize = const Size.fromHeight(50.0),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text(
        title,
        style: TextStyle(color: textColor),
      ),
      backgroundColor: backgroundColor,
    );
  }
}

