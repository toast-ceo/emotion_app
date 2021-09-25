import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:emotion_new_diary/api/api_info.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class Api with ChangeNotifier {
  String uri = ApiInfo.userUri;
  String allUri = ApiInfo.allUri;
  String userName = "KIM";
  Map<String, dynamic> userAllData = {};
  int infoAllNum = 0;

  static const Map<String, String> header = {
    'Content-type': 'application/json',
    'Accept': 'application/json',
  };

  // 데이터 넣어주는 함수
  void inputData(var temp) {
    userAllData = temp;
  }

  // 전체 데이터
  Future fetchPost() async {
    final response = await http.get(Uri.parse(uri));
    var temp = jsonDecode(response.body);
    return temp['body'];
  }

  Future fetchPostInfo(String year) async {
    String infoUri =  ApiInfo.infoUri+year;
    try {
      // await Future.delayed(Duration(seconds:3));
      final response = await http.get(Uri.parse(infoUri));
      if (response.statusCode == 200) {
        var temp = jsonDecode(response.body);
        //print(temp);
        infoAllNum = temp['meta']['diary_count'];
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

  void addText(Map<String, dynamic> data) async {

    Uri addUrl = Uri.parse(allUri);
    HttpClient httpClient = new HttpClient();
    HttpClientRequest request = await httpClient.postUrl(addUrl);
    request.headers.set('Content-type', 'application/json');
    request.add(utf8.encode(json.encode(data)));
    HttpClientResponse response = await request.close();

    if (response.statusCode == 201) {
      print("성공");
    } else {
      print("실패");
    }
  }

  void removeText(Map removeData) async {
    Uri removeUri = Uri.parse(allUri);
    HttpClient httpClient = new HttpClient();
    HttpClientRequest request = await httpClient.deleteUrl(removeUri);
    request.headers.set('Content-type', 'application/json');
    request.add(
        utf8.encode(json.encode({"username": "KIM", "date": "2021-09-17"})));
    HttpClientResponse response = await request.close();

    if (response.statusCode == 204) {
      print("성공");
    } else {
      return Future.error("error: status code ${response.statusCode}");
    }
  }
}
