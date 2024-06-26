import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:social_media_app/core/url.dart';
import 'package:social_media_app/data/models/signup_model.dart';
import 'package:http/http.dart' as http;

class SignupRepo {
  static Future<String> signupuser({required UserModel user}) async {
    var client = http.Client();
    try {
      var response = await client.post(Uri.parse('${EndPoints.baseurl}${EndPoints.signup}'),
          body: jsonEncode(user),
          headers: {'Content-Type': 'application/json'});
      debugPrint('statuscode:${response.statusCode}');
      debugPrint(response.body);
      final responseBody = jsonDecode(response.body);
      if (response.statusCode == 200) {
        return 'Successful';
      } else if (responseBody['message'] == "You already have an account.") {
        return 'You already have an account';
      } else if (responseBody['message'] ==
          "OTP already sent within the last one minute") {
        return 'OTP already sent within the last one minute';
      }
        else if (responseBody['message'] ==
          "The username is already taken.") {
        return 'The username is already taken.';
      }
       else if (response.statusCode == 500) {
        return 'Internal server Error';
      } else {
        return ' failed';
      }
    } catch (e) {
      debugPrint(e.toString());
      log(e.toString());
      return 'failed';
    }
  }

  //otp
  static Future<String> verifyOtp(
      {required String email, required String oteepee}) async {
    var client = http.Client();
    try {
      final user = {'email': email, 'otp': oteepee};

      var response = await client.post(
        Uri.parse('${EndPoints.baseurl}${EndPoints.otpurl}'),
        body: user,
      );
      debugPrint('statuscode:${response.statusCode}');
      debugPrint(response.body);
      final responsebody = jsonDecode(response.body);
      if (response.statusCode == 200) {
        return 'successful';
      } else if (responsebody['message'] ==
          'Invalid verification code or OTP expired') {
        return 'Invalid verification code or OTP expired';
      } else if (response.statusCode == 500) {
        return 'Internal server error';
      } else {
        return 'failed';
      }
    } catch (e) {
      debugPrint(e.toString());
      log(e.toString());
      return 'failed';
    }
  }

  //signin
  static Future<String> userlogin(
      {required String email, required String password}) async {
    var client = http.Client();
    try {
      final loginuser = {'email': email, 'password': password};
      var response =
          await client.post(Uri.parse('${EndPoints.baseurl}${EndPoints.loginurl}'), body: loginuser);
      debugPrint('statuscode:${response.statusCode}');
      debugPrint(response.body);
      final responsebody = jsonDecode(response.body);
      // print(responsebody['message']);
      if (response.statusCode == 200) {
        SharedPreferences preferences = await SharedPreferences.getInstance();
        preferences.setBool('LOGIN', true);
        preferences.setString('USER_TOKEN', responsebody['user']['token']);
        preferences.setString('USER_ID', responsebody['user']['_id']);
         preferences.setString('USER_NAME', responsebody['user']['userName']);
        return 'login successful';
      } else if (responsebody['message'] ==
          'User not found with the provided email') {
        return 'User not found with the provided email';
      } else if (responsebody['message'] ==
          'Something went wrong on the server') {
        return 'internal server error';
      } else if (responsebody['message'] == 'Invalid password') {
        return 'Invalid password';
      } else if (responsebody['message'] == 'Your Account is Blocked') {
        return 'account is blocked';
      } else {
        return 'failed';
      }
    } catch (e) {
      debugPrint(e.toString());
      log(e.toString());
      return 'failed';
    }
  }
}
