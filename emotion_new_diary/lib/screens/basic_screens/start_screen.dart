import 'package:flutter/material.dart';


import 'package:emotion_new_diary/model/provider.dart';
import 'package:provider/provider.dart';

class StartScreen extends StatefulWidget {
  @override
  _StartScreenState createState() => _StartScreenState();
}

class _StartScreenState extends State<StartScreen> {
  @override
  Widget build(BuildContext context) {
    Products data = Provider.of<Products>(context);
    return Scaffold(
        backgroundColor: Colors.white,
        body: Stack(
          children: [
            //시작 버튼
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Center(child: Text('What Is Your Colors?',)),
              ],
            ),
            //기타 환경설정, 개발자들 표시
            Column(),
          ],
        )
    );
  }
}
