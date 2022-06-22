import 'package:another_flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:smart_building/domain/user.dart';
import 'package:smart_building/providers/auth.dart';
import 'package:smart_building/providers/user_provider.dart';
import 'package:smart_building/utils/widgets.dart';
import 'package:provider/provider.dart';
import 'package:smart_building/utils/burgermenu.dart';


class Register extends StatefulWidget {
  const Register({Key? key}) : super(key: key);

  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  final formKey = GlobalKey<FormState>();

  String _username ="", _password="", _confirmPassword="";

  @override
  Widget build(BuildContext context) {
    AuthProvider auth = Provider.of<AuthProvider>(context);

    final usernameField = TextFormField(
      autofocus: false,
      // validator: validateEmail,
      onSaved: (value) => _username = value!,
      decoration: buildInputDecoration("Confirm password", Icons.email),
    );

    final passwordField = TextFormField(
      autofocus: false,
      obscureText: true,
      validator: (value) => value!.isEmpty ? "Please enter password" : null,
      onSaved: (value) => _password = value!,
      decoration: buildInputDecoration("Confirm password", Icons.lock),
    );

    final confirmPassword = TextFormField(
      autofocus: false,
      validator: (value) => value!.isEmpty ? "Your password is required" : null,
      onSaved: (value) => _confirmPassword = value!,
      obscureText: true,
      decoration: buildInputDecoration("Confirm password", Icons.lock),
    );

    var loading = Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: const <Widget>[
        CircularProgressIndicator(),
        Text(" Registering ... Please wait")
      ],
    );

    Future<void> Function() doRegister;
    doRegister = () async {
      final form = formKey.currentState;
      if (form!.validate()) {
        form.save();
        auth.register(_username, _password, _confirmPassword).then((response) {
          if (response['status']) {
            User user = response['data'];
            Provider.of<UserProvider>(context, listen: false).setUser(user);
            Navigator.pushReplacementNamed(context, '/dashboard');
          } else {
            Flushbar(
              title: "Registration Failed",
              message: response.toString(),
              duration: const Duration(seconds: 10),
            ).show(context);
          }
        });
      } else {
        Flushbar(
          title: "Invalid form",
          message: "Please Complete the form properly",
          duration: const Duration(seconds: 10),
        ).show(context);
      }
    };

    return SafeArea(
      child: Scaffold(
        appBar: const CustomAppBar("Registration", mainThemeColor, mainTextButtonColor),
        drawer: const CustomDrawer(mainThemeColor, mainTextButtonColor, mainTextColor),
        body: Center(
          child: FractionallySizedBox(
            widthFactor: MediaQuery.of(context).size.width > 500 ? 0.4 : 1,
            child: Container(
              padding: const EdgeInsets.all(40.0),
              child: Form(
                key: formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                  const SizedBox(height: 15.0),
                  label("Email"),
                  const SizedBox(height: 5.0),
                  usernameField,
                  const SizedBox(height: 15.0),
                  label("Password"),
                  const SizedBox(height: 10.0),
                  passwordField,
                  const SizedBox(height: 15.0),
                  label("Confirm Password"),
                  const SizedBox(height: 10.0),
                  confirmPassword,
                  const SizedBox(height: 20.0),
                  auth.loggedInStatus == Status.authenticating
                  ? loading
                      : longButtons("Login", doRegister, mainButtonColor),
                  ],
                ),
              )
            ),
          ),
        ),
      ),
    );
  }
}