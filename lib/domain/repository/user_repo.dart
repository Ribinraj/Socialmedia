import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:social_media_app/core/url.dart';
import 'package:social_media_app/data/models/loginuser_model.dart';

import 'package:social_media_app/presentation/widgets/shared_preferences.dart';

class LoginUserRepo {
  static Future<Loginuser?> fetchloginuser() async {
    var client = http.Client();
    final token = await getUserToken();
    try {
      var response = await client.get(Uri.parse('$baseurl$loginuserurl'),
          headers: {
            'Content-Type': 'application/json',
            'Authorization': 'Bearer $token'
          });
      debugPrint('statuscode:${response.statusCode}');
      if (response.statusCode == 200) {
        final Map<String, dynamic> responsedata = jsonDecode(response.body);
        final Loginuser loginuser = Loginuser.fromJson(responsedata);
        return loginuser;
      } else if (response.statusCode == 500) {
        return null;
      }
      return null;
    } catch (e) {
      return null;

    }
  }
}
