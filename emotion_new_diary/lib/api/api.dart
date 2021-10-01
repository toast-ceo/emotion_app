import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:emotion_new_diary/api/api_info.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class Api with ChangeNotifier {
  String userName = "";
  String uri = ApiInfo.userUri;

  String allUri = ApiInfo.allUri;
  String loginUri = ApiInfo.loginUri;
  String membershipUri = ApiInfo.membershipUri;
  int membershipTemp;
  int addTextTemp;
  Map<String, dynamic> userAllData = {};
  int infoAllNum = 0;
  String key = '';
  String keyType = '';

//   static const Map<String, String> header = {
//     'Content-type': 'application/json',
//     'Accept': 'application/json',
//     'Authorization' : keyType + " " + key,
// };
//   static const Map<String, String> header2 = {
//     'Content-type': '"application/x-www-form-urlencoded"',
//     'Accept': 'application/json',
//   };

  //로그인
  void loginApi(Map<String, dynamic> data) async {
    HttpClientResponse response;
    Uri loginUrl = Uri.parse(loginUri);
    HttpClient httpClient = new HttpClient();
    HttpClientRequest request = await httpClient.postUrl(loginUrl);
    request.headers.set(
      HttpHeaders.acceptHeader,
      'application/json',
    );
    request.headers.set(
        HttpHeaders.contentTypeHeader, "application/x-www-form-urlencoded");
    request.add(utf8.encode(json.encode(
        "grant_type=&username=${data['username']}&password=${data['password']}&scope=&client_id=&client_secret=")));
    response = await request.close();
    Map temp;
    response.listen((event) {
      temp = json.decode(String.fromCharCodes(event));
      key = temp['access_token'];
      keyType = temp['token_type'];
      userName = temp['name'];
    });
    if (response.statusCode == 200) {
      print("성공");
    } else {
      print("실패");
      print(response.statusCode);
      print(response.reasonPhrase);
    }
  }

  void membershipApi(Map<String, dynamic> data) async {
    print(data);
    Uri membershipUrl = Uri.parse(membershipUri);
    HttpClient httpClient = new HttpClient();
    HttpClientRequest request = await httpClient.postUrl(membershipUrl);
    request.headers.set('Content-type', 'application/json');
    request.add(utf8.encode(json.encode(data)));
    HttpClientResponse response = await request.close();
    membershipTemp = response.statusCode;
    if (response.statusCode == 200) {
      print("성공");
    } else {
      print("실패");
    }
  }

  // 데이터 넣어주는 함수
  void inputData(var temp) {
    userAllData = temp;
  }

  // 전체 데이터
  Future fetchPost() async {
    final response = await http.get(Uri.parse(uri + userName), headers: {
      'Content-type': 'application/json',
      'Accept': 'application/json',
      'Authorization': keyType + " " + key,
    });
    if (response.statusCode == 500) {
      return null;
    } else {
      var temp = jsonDecode(response.body);
      return temp['body'];
    }
  }

  Future fetchPostInfo(String year) async {
    String infoUri = ApiInfo.infoUri + userName + "&year=" + year;
    try {
      // await Future.delayed(Duration(seconds:3));
      final response = await http.get(Uri.parse(infoUri), headers: {
        'Content-type': 'application/json',
        'Accept': 'application/json',
        'Authorization': keyType + " " + key,
      });
      // print(keyType + " " + key);
      print(response.statusCode);
      if (response.statusCode == 200) {
        var temp = jsonDecode(response.body);
        //print(temp);
        infoAllNum = temp['meta']['diary_count'];
        // print(temp['meta']['diary_count']);
        // print(infoAllNum);
        // print(temp);
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

  //일기 작성
  void addText(Map<String, dynamic> data) async {
    print(data);
    Uri addUrl = Uri.parse(allUri);
    HttpClient httpClient = new HttpClient();
    HttpClientRequest request = await httpClient.postUrl(addUrl);
    request.headers.set('Content-type', 'application/json');
    request.headers.set(HttpHeaders.authorizationHeader, keyType + " " + key);
    request.add(utf8.encode(json.encode(data)));
    HttpClientResponse response = await request.close();
    print(addTextTemp);
    if (response.statusCode == 201) {
      addTextTemp = response.statusCode;
      print("성공");
    } else {
      addTextTemp = response.statusCode;
      print("실패");
    }
  }

  //일기 삭제
  void removeText(Map removeData) async {
    print(removeData);
    Uri removeUri = Uri.parse(allUri);
    HttpClient httpClient = new HttpClient();
    HttpClientRequest request = await httpClient.deleteUrl(removeUri);
    request.headers.set('Content-type', 'application/json');
    request.headers.set(HttpHeaders.authorizationHeader, keyType + " " + key);
    request.add(utf8.encode(json.encode({
      "username": utf8.decode(removeData['username'].toString().codeUnits),
      "date": removeData['date'],
      "title": utf8.decode(removeData['title'].toString().codeUnits),
    })));
    HttpClientResponse response = await request.close();

    if (response.statusCode == 204) {
      print("성공");
    } else {
      print(removeData);
      return Future.error("error: status code ${response.statusCode}");
    }
  }
}
