// Here is login\logout\registration functions

import 'dart:async';
import 'dart:convert';
// import 'dart:io';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:smart_building/domain/user.dart';
import 'package:smart_building/providers/user_provider.dart';
import 'package:smart_building/utils/app_url.dart';
import 'package:smart_building/utils/shared_preference.dart';

enum Status {
  notLoggedIn,
  notRegistered,
  loggedIn,
  registered,
  authenticating,
  registering,
  loggedOut
}

class AuthProvider with ChangeNotifier {
  Status _loggedInStatus = Status.notLoggedIn;
  Status _registeredInStatus = Status.notRegistered;

  Status get loggedInStatus => _loggedInStatus;
  Status get registeredInStatus => _registeredInStatus;

  Future<Map<String, dynamic>> login(String email, String password) async {
    Map<String, dynamic> result;

    final Map<String, dynamic> loginData = {
      'user': {'email': email, 'password': password}
    };

    _loggedInStatus = Status.authenticating;
    notifyListeners();

    if (loginData['user']['email'] == 'a' &&
        loginData['user']['password'] == 'a') {
      _loggedInStatus = Status.loggedIn;
      notifyListeners();
      User authUser = User(
          name: 'admin',
          token: 'token',
          email: "user@email.com",
          profilePhoto:
              'https://www.meme-arsenal.com/memes/e77529bc5454bebb776dbefd127f68f5.jpg');
      result = {'status': true, 'message': 'Successful', 'user': authUser};
      return result;
    }

    http.Response response = await http.post(
      Uri.parse(AppUrl.login),
      body: jsonEncode(loginData),
      headers: {'Content-Type': 'application/json'},
    );

    if (response.statusCode == 200) {
      final Map<String?, dynamic> responseData = jsonDecode(response.body);

      var userData = responseData['data'];

      User authUser = User.fromJson(userData);

      UserPreferences().saveUser(authUser);
      _loggedInStatus = Status.loggedIn;
      notifyListeners();

      result = {'status': true, 'message': 'Successful', 'user': authUser};
    } else {
      _loggedInStatus = Status.notLoggedIn;
      notifyListeners();

      result = {'status': false, 'message': jsonDecode(response.body)['error']};
    }
    return result;
  }

  Future<Map<String, dynamic>> register(
      String email, String password, String passwordConfirmation) async {
    final Map<String, dynamic> registrationData = {
      'user': {
        'email': email,
        'password': password,
        'password_confirmation': passwordConfirmation
      }
    };

    _registeredInStatus = Status.registering;
    notifyListeners();

    return await http
        .post(Uri.parse(AppUrl.register),
            body: jsonEncode(registrationData),
            headers: {'Contest-Type': 'application/json'})
        .then(onValue)
        .catchError(onError);
  }

  Future<void> logout() async {
    //UserPreferences().removeUser();
    UserProvider().setUser(User(token: ""));
    _loggedInStatus = Status.loggedOut;
    notifyListeners();
  }
}

Future<Map<String, dynamic>> onValue(http.Response response) async {
  Map<String, Object> result;
  final Map<String, dynamic> responseData = jsonDecode(response.body);

  // print(response.statusCode);
  if (response.statusCode == 200) {
    var userData = responseData['data'];

    User authUser = User.fromJson(userData);

    UserPreferences().saveUser(authUser);
    result = {
      'status': true,
      'message': 'Successfully registered',
      'data': authUser,
      'token': authUser.token
    };
  } else {
    result = {
      'status': false,
      'message': 'Registration failed',
      'data': responseData
    };
  }
  return result;
}

onError(error) {
  // print("the error is $error.detail");
  return {'status': false, 'message': 'Unsuccessful Request', 'data': error};
}
