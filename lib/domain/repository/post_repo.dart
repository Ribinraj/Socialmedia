import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:photo_manager/photo_manager.dart';
import 'package:social_media_app/core/url.dart';

import 'package:social_media_app/presentation/widgets/cloudinary.dart';
import 'package:social_media_app/presentation/widgets/shared_preferences.dart';

class PostRepo {
  //fetchpost
  static Future fetchPost() async {
    var client = http.Client();

    final token = await getUserToken();
    try {
      var response =
          await client.get(Uri.parse('$baseurl$fetchposturl'), headers: {
        'content_Type': 'application/json',
        'Authorization': 'Bearer $token',
      });
      debugPrint('statuscode:${response.statusCode}');
      return response;
    } catch (e) {
      debugPrint(e.toString());
      log(e.toString());
      return 'failed';
    }
  }

  //fetchuserby id
  static Future fetchuserpost() async {
    var client = http.Client();
    final userid = await getUserId();
    try {
      var response = await client.get(
          Uri.parse('$baseurl$fetchuserposturl/$userid'),
          headers: {'content_Type': 'application/json'});
      debugPrint('statuscode:${response.statusCode}');
      return response;
    } catch (e) {
      debugPrint(e.toString());
      log(e.toString());
      return 'failed';
    }
  }

  //add post
  static Future<String> addpost(
      {required AssetEntity image, required String description}) async {
    var client = http.Client();
    try {
      final imageUrl = await uploadImage(image);
      final token = await getUserToken();
      final userId = await getUserId();
      final userpost = {
        'imageUrl': imageUrl,
        'description': description,
        'userId': userId
      };

      var response = await client.post(Uri.parse('$baseurl$addposturl'),
          body: jsonEncode(userpost),
          headers: {
            'Content-Type': 'application/json',
            'Authorization': 'Bearer $token'
          });
      debugPrint('statuscode:${response.statusCode}');
      debugPrint(response.body);
      final responsebody = jsonDecode(response.body);
      if (response.statusCode == 200) {
        return 'post created successfully';
      } else if (responsebody['message'] ==
          'Something went wrong while saving to the database') {
        return 'Something went wrong while saving to the database';
      } else if (responsebody['message'] ==
          'Something went wrong on the server') {
        return 'Something went wrong on the server';
      } else {
        return 'failed';
      }
    } catch (e) {
      debugPrint(e.toString());
      log(e.toString());
      return 'failed';
    }
  }

  //deletepost
  static Future<String> deletepost({required String postid}) async {
    debugPrint('postid:$postid');
    var client = http.Client();
    try {
      final token = await getUserToken();
      var response = await client
          .delete(Uri.parse('$baseurl$deleteposturl/$postid'), headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token'
      });
      debugPrint('statuscode:${response.statusCode}');
      if (response.statusCode == 200) {
        return 'post deleted successfully';
      } else if (response.statusCode == 500) {
        return 'internal server error';
      } else {
        return 'failed';
      }
    } catch (e) {
      debugPrint(e.toString());
      log(e.toString());
      return 'failed';
    }
  }

  //updatepost
  static Future<String> editpost(
      {required AssetEntity image,
      required String description,
      required String postid}) async {
    var client = http.Client();
    try {
      final token = await getUserToken();
      var response =
          await client.put(Uri.parse('$baseurl$editposturl/$postid'));
    } catch (e) {}
  }
}
