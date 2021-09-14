import 'dart:async';
import 'dart:convert';

import 'package:emotion_new_diary/api/api_info.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class Api with ChangeNotifier {
  String uri = ApiInfo.uri;
  Map<String, dynamic> userAllData = {};
  int infoAllNum = 0;

  void inputData(var temp) {
    userAllData = temp;
  }

  Future fetchPost() async {
    final response = await http.get(Uri.parse(uri));
    var temp = jsonDecode(response.body);
    return temp['body'];
  }

  Future fetchPostInfo(String year) async {
    //String infoUri = 'https://5za963.deta.dev/diary/?username=KIM&year=$year';
    String infoUri =
        "https://5za963.deta.dev/diary/chart?username=KIM&year=$year";
    try {
      // await Future.delayed(Duration(seconds:3));
      final response = await http.get(Uri.parse(infoUri));
      if (response.statusCode == 200) {
        var temp = jsonDecode(response.body);
        // infoAllNum = temp['meta']['emotion_count'];
        // print(temp['meta']['diary_count']);
        // print(infoAllNum);
        return temp['body']['$year'];
      } else if (response.statusCode == 404) {
        return null;
      } else {
        // print(response.statusCode.toString());
        throw Exception(
            'Failed Load Data with status code ${response.statusCode}');
      }
    } on Exception catch (e) {
      // print(e);
      return null;
    }
    // String infoUri = uri + '&year=$year';
  }
}
