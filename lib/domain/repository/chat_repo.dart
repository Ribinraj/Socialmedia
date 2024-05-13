import 'dart:convert';
import 'dart:developer';


import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:social_media_app/core/url.dart';
import 'package:social_media_app/presentation/widgets/shared_preferences.dart';

class ChatRopo {
  //get conversation
  static Future getconversation() async {
    var client = http.Client();
    final token = await getUserToken();
    try {
      var respose = await client.get(Uri.parse('$baseurl$getconversationurl'),
          headers: {
            'content_Type': 'application/json',
            'Authorization': 'Bearer $token'
          });
      debugPrint('statuscode:${respose.statusCode}');
      return respose;
    } catch (e) {
      debugPrint(e.toString());
      log(e.toString());
      return 'failed';
    }
  }

  //create conversation
  static Future createconversation({required List<String> members}) async {
    var client = http.Client();
    try {
      final token = await getUserToken();
      //final userId = await getUserId();
      final body = {"members": members};

      var response = await client.post(
        Uri.parse('$baseurl$createconversationurl'),
        body: jsonEncode(body),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token'
        },
      );
      debugPrint('statuscode:${response.statusCode}');
      debugPrint(response.body);

      return response;
    } catch (e) {
      debugPrint(e.toString());
      log(e.toString());
      return 'failed';
    }
  }

  //addmessage
  static Future addmessage(
      {required String recieverId,
      required String text,
      required String conversationId,
      required String senderId}) async {
    var client = http.Client();
    try {
      final token = await getUserToken();
      final body = {
        "senderId": senderId,
        "conversationId": conversationId,
        "text": text,
        "recieverId": recieverId
      };
      var response = await client.post(
        Uri.parse('$baseurl$addmessageurl'),
        body: jsonEncode(body),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token'
        },
      );
      return response;
    } catch (e) {
      debugPrint(e.toString());
      log(e.toString());
      return 'failed';
    }
  }

  //getallmessage
  static Future getallmessages({required String conversationId}) async {
    var client = http.Client();
    try {
      final token = await getUserToken();
      var response = client.get(
        Uri.parse('$baseurl$getallmessageurl/$conversationId'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token'
        },
      );
      return response;
    } catch (e) {
      debugPrint(e.toString());
      log(e.toString());
      return 'failed';
    }
  }
}
