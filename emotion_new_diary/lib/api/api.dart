import 'dart:convert';

import 'package:emotion_new_diary/api/api_info.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class Api  with ChangeNotifier {

  String uri  = ApiInfo.uri;

  Future fetchPost() async {
    final response = await http.get(Uri.parse(uri));
    var temp = jsonDecode(response.body);
    notifyListeners();
    return temp['body'];
  }

}