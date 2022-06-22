import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:smart_building/utils/app_url.dart';

enum Status {
  notLoggedIn,
  notRegistered,
  loggedIn,
  registered,
  authenticating,
  registering,
  loggedOut
}

class BuildingInfo with ChangeNotifier {
  Future<Map<String, dynamic>> building(Map buildingInfo) async {
    // Map<String, dynamic> result;

    Map<String, dynamic> info = {};

    final Map<String, dynamic> buildingData = {
      'building': {}
    };

    http.Response response = await http.post(
      Uri.parse(AppUrl.login),
      body: jsonEncode(buildingData),
      headers: {'Content-Type': 'application/json'},
    );

    if (response.statusCode == 200) {
      info = jsonDecode(response.body);
    }

    return info;
  }
}