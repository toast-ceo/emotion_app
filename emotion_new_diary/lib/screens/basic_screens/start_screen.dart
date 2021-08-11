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

    );
  }
}
