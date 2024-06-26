import 'dart:convert';

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:social_media_app/core/url.dart';

import 'package:social_media_app/presentation/widgets/cloudinary.dart';

import 'package:social_media_app/presentation/widgets/shared_preferences.dart';

class LoginUserRepo {
  //
  static Future fetchloginuser() async {
    var client = http.Client();
    final token = await getUserToken();
   
    try {
      var response = await client.get(Uri.parse('${EndPoints.baseurl}${EndPoints.loginuserurl}'),
          headers: {
            'Content-Type': 'application/json',
            'Authorization': 'Bearer $token'
          });
      debugPrint('statuscodeloginuser:${response.body}');
      return response;
    } catch (e) {
      return null;
    }
  }

  //editprofile
  static Future<String> editprofile(
      {String? imageurl,
      File? image,
      String? backgroundImageurl,
      File? backgroundImage,
      String? bio,
      String? name}) async {
    var client = http.Client();
    try {
      //  final imageUrl=image==null?imageurl:await uploadImage(image);
      final imageUrl = image != null ? await uploadImage(image) : imageurl;
      final backgroundimageurl = backgroundImage != null
          ? await uploadImage(backgroundImage)
          : backgroundImageurl;
      final token = await getUserToken();
      debugPrint('image:$imageurl');
      final editdata = {
        'image': imageUrl,
        'name': name,
        'bio': bio,
        'backGroundImage': backgroundimageurl
      };

      var response = await client.put(Uri.parse('${EndPoints.baseurl}${EndPoints.editprofileurl}'),
          headers: {
            'Content-Type': 'application/json',
            'Authorization': 'Bearer $token'
          },
          body: jsonEncode(editdata));
      debugPrint('statuscode:${response.statusCode}');
      if (response.statusCode == 200) {
        return 'data edited successfully';
      } else if (response.statusCode == 500) {
        return 'Internal server Error';
      } else {
        return 'failed';
      }
    } catch (e) {
      debugPrint(e.toString());

      return 'failed';
    }
  }

  //get singleuser
  static Future getsingleuser({required String userId}) async {
    var client = http.Client();
    try {
      final token = await getUserToken();
      var response = await client.get(
        Uri.parse('${EndPoints.baseurl}${EndPoints. getSingleuserurl}/$userId'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token'
        },
      );
      return response;
    } catch (e) {
      debugPrint(e.toString());

      return 'failed';
    }
  }

  //getfollowers count
  static Future getconnectioncount({required String userId}) async {
    var client = http.Client();
    try {
      final token = await getUserToken();
      var response = await client.get(
        Uri.parse('${EndPoints.baseurl}${EndPoints.connectioncounturl}/$userId'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token'
        },
      );
      return response;
    } catch (e) {
      debugPrint(e.toString());

      return 'failed';
    }
  }

  //notification
  static Future getnotification() async {
    var client = http.Client();
    try {
      final token = await getUserToken();
      var response = await client.get(
        Uri.parse('${EndPoints.baseurl}${EndPoints.notificationurl}'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token'
        },
      );
      debugPrint('notification:${response.body}');
      return response;
    } catch (e) {
      debugPrint(e.toString());

      return 'failed';
    }
  }
}
