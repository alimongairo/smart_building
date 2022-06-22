import 'package:another_flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:smart_building/domain/user.dart';
import 'package:smart_building/providers/auth.dart';
import 'package:smart_building/providers/user_provider.dart';
import 'package:smart_building/utils/widgets.dart';
import 'package:provider/provider.dart';
import 'package:smart_building/utils/burgermenu.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final formKey = GlobalKey<FormState>();

  String _username = "", _password = "";

  @override
  Widget build(BuildContext context) {
    AuthProvider auth = Provider.of<AuthProvider>(context);

    final usernameField = TextFormField(
      autofocus: false,
      keyboardType: TextInputType.emailAddress,
      //validator: validateEmail,
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

    var loading = Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: const <Widget>[
        CircularProgressIndicator(),
        Text(" Authenticating ... Please wait")
      ],
    );

    final forgotLabel = Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        TextButton(
          //padding: EdgeInsets.all(0.0),
          child: const Text("Forgot password?",
              style: TextStyle(fontWeight: FontWeight.w300)),
          onPressed: () {
            Navigator.pushReplacementNamed(context, '/reset-password');
          },
        ),
        TextButton(
          //padding: const EdgeInsets.only(left: 0.0),
          child: const Text("Sign up",
              style: TextStyle(fontWeight: FontWeight.w300)),
          onPressed: () {
            Navigator.pushReplacementNamed(context, '/register');
          },
        ),
      ],
    );

    Null Function() doLogin;
    doLogin = () {
      final form = formKey.currentState;

      if (form!.validate()) {
        form.save();

        final Future<Map<String, dynamic>> successfulMessage =
            auth.login(_username, _password);

        successfulMessage.then((response) {
          if (response['status']) {
            User user = response['user'];
            Provider.of<UserProvider>(context, listen: false).setUser(user);
            Navigator.pushReplacementNamed(context, '/building');
          } else {
            Flushbar(
              title: "Failed Login",
              message: response['message']['message'].toString(),
              duration: const Duration(seconds: 3),
            ).show(context);
          }
        });
      } else {
        //print("form is invalid");
      }
    };

    return SafeArea(
      child: Scaffold(
        appBar:
            const CustomAppBar("Login", mainThemeColor, mainTextButtonColor),
        drawer: const CustomDrawer(
            mainThemeColor, mainTextButtonColor, mainTextColor),
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
                    const SizedBox(height: 20.0),
                    label("Password"),
                    const SizedBox(height: 5.0),
                    passwordField,
                    const SizedBox(height: 20.0),
                    auth.loggedInStatus == Status.authenticating
                        ? loading
                        : longButtons("Login", doLogin, mainButtonColor),
                    const SizedBox(height: 5.0),
                    forgotLabel
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
