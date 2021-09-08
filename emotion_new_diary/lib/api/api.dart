import 'dart:async';
import 'dart:convert';

import 'package:emotion_new_diary/api/api_info.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class Api  with ChangeNotifier {
  String uri  = ApiInfo.uri;

  Future fetchPost() async {
    final response = await http.get(Uri.parse(uri));
    var temp = jsonDecode(response.body);
    return temp['body'];
  }

  Future fetchPostInfo(String year) async {
   // // String infoUri = uri + '&year=$year';
   //  await Future.delayed(Duration(seconds:2));
    String infoUri= 'https://5za963.deta.dev/diary/?username=KIM&year=$year';
    final response = await http.get(Uri.parse(infoUri));
    var temp = jsonDecode(response.body);
    print(temp);
    return temp['body']['$year'];
  }

}
