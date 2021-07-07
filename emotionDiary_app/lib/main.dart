import 'package:flutter/material.dart';
import 'package:odd_app/models/provider.dart';
import 'package:provider/provider.dart';
import 'package:intl/date_symbol_data_local.dart';


import 'ui/start.dart';
import 'ui/menu.dart';
import 'ui/record/record.dart';
import 'ui/record/secondrecord.dart';
import 'ui/remind/remind.dart';
import 'ui/todayDiary.dart';
import 'ui/remind/remindEmotion.dart';
import 'ui/developPeople.dart';
import 'ui/changeSex.dart';

void main() {
  initializeDateFormatting('ko_KR', null).then((_) =>  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => Products(),),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
          title: 'one day diary',
          theme: ThemeData(
            fontFamily: 'Caveat',
            primaryColor: Colors.white,
          ),
          initialRoute: '/start',
          routes: {
            '/start': (context) => StartPage(),
            '/menu': (context) => MenuPage(),
            '/record': (context) => RecordPage(),
            '/record2': (context) => SecondRecordPage(),
            '/remind' : (context) => RemindPage(),
            '/remind2' : (context) => SecondRemindPage(),
            '/todayDiary' : (context) => TodayDiary(),
            '/people' : (context) => DevelopPeople(),
            '/changeSex' : (context) => ChangeSex(),
          },
      ),
    ),
  ));
}
