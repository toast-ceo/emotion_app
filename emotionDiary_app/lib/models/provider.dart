import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class Products with ChangeNotifier {
  Map<String, dynamic> userAllData = {};
  String server;
  String sex = 'Girl';

  void callInfomation(var temp) {
    userAllData = temp;
  }

  void serverCall(String userId){
    server = 'http://210.123.254.17:9703/info?id=$userId';
  }

  Future fetchPost() async {
    await Future.delayed(Duration(seconds: 2));
    final response = await http.get(server);
    var temp = jsonDecode(response.body);
    notifyListeners();
    return temp['data']['body'];
  }

  void addText(Map<String, dynamic> data) async {
    print(data);
    String bodyF = jsonEncode(data);
    print(bodyF);
    http.Response response = await http.put(
      server,
      body: bodyF,
    );
    print(response.body);
    if (response.statusCode == 200) {
      print("성공");
    } else {
      print("실패");
    }
    notifyListeners();
  }

  void removeText(Map removeData) async {
    final client = http.Client();
    print(removeData);
    String bodyF = jsonEncode(removeData);
    print(bodyF);
    try {
      http.StreamedResponse response = await client
          .send(http.Request("DELETE", Uri.parse(server))..body = bodyF);
      print(response);
      if (response.statusCode == 200) {
        print("성공");
      } else {
        print("실패");
      }
    } finally {
      client.close();
    }
    notifyListeners();
  }

  void changeSexFun(String temp){
    if(temp == 'Girl'){
      sex = 'Girl';
    }
    else if(temp == 'Boy'){
      sex = 'Boy';
    }
    print(sex);
    notifyListeners();
  }
}

///    final dateLogic = DateTime.now();
//     final dateNow = DateFormat('yyyyMMdd').format(dateLogic);
//     int difference = dateLogic.difference(DateTime.parse(data['date'])).inDays;
//     final dateKey = DateFormat('yyyyMMdd')
//         .format(DateTime.parse(dateNow).subtract(Duration(days: difference)));
//
//     if (userAllData.containsKey(dateKey) == true) {
//       userAllData[dateKey].add(data);
//     } else {
//       userAllData.addAll({dateKey: [data]});
//     }
//     print(userAllData);
