import 'package:emotion_new_diary/model/style.dart';
import 'package:flutter/material.dart';

class StartScreen extends StatefulWidget {
  @override
  _StartScreenState createState() => _StartScreenState();
}

class _StartScreenState extends State<StartScreen> {
  @override

  void initState(){
    super.initState();
    Future.delayed(Duration(seconds: 5), () {
      Navigator.pushReplacementNamed(context, '/home');
    });}

  Widget build(BuildContext context) {
    final styleModel = new StyleModel(context);
    return Scaffold(
        backgroundColor: styleModel.getBackgroundColor()['backgroundColor1'],
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: styleModel.getContextSize()['screenWidthLevel3'],
                height: styleModel.getContextSize()['screenWidthLevel8'],
               decoration: BoxDecoration(
                 gradient: LinearGradient(
                   begin: Alignment.topLeft,
                   end: Alignment.bottomRight,
                   colors: <Color> [
                     styleModel.getBackgroundColor()['backgroundColor2'],
                     styleModel.getBackgroundColor()['backgroundColor3'],
                     styleModel.getBackgroundColor()['backgroundColor4'],
                     styleModel.getBackgroundColor()['backgroundColor5'],
                     styleModel.getBackgroundColor()['backgroundColor6'],
                   ],
                 ),
               ),
                child: Center(
                  child: Text(
                    "What is Your Colors?",
                    style: styleModel.getTextStyle()['titleTextStyle'],
                  ),
                ),
              ),
            ],
          ),
        ));
  }
}
