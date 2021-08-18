import 'package:emotion_new_diary/screens/basic_screens/initial/home_screen.dart';
import 'package:emotion_new_diary/screens/basic_screens/start_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:intl/date_symbol_data_local.dart';

import 'model/provider.dart';

void main() {
  initializeDateFormatting('ko_KR', null).then((_) =>  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => Products(),),
      ],
      child: MaterialApp(
        title: 'one day diary',
        theme: ThemeData(
          fontFamily: 'PoiretOne',
          primaryColor: Colors.white ,
        ),
        initialRoute: '/start',
        routes: {
          '/start' : (context) => StartScreen(),
          '/home' : (context) => HomeScreen(),
        },
      ),
    ),
  ));
}