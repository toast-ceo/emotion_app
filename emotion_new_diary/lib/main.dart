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
        debugShowCheckedModeBanner: false,
        title: 'one day diary',
        theme: ThemeData(
          //fontFamily: 'Caveat',
          primaryColor: Colors.white,
        ),
        initialRoute: '/start',
        routes: {

        },
      ),
    ),
  ));
}