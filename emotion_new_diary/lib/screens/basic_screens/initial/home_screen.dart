import 'package:emotion_new_diary/api/api.dart';
import 'package:emotion_new_diary/model/style.dart';
import 'package:emotion_new_diary/screens/basic_screens/bodyscreens/mainscreen/calendar_read.dart';
import 'package:emotion_new_diary/screens/basic_screens/bodyscreens/mainscreen/information_screen.dart';
import 'package:emotion_new_diary/screens/basic_screens/bodyscreens/mainscreen/read_screen.dart';
import 'package:emotion_new_diary/screens/basic_screens/bodyscreens/mainscreen/setting_screen.dart';
import 'package:emotion_new_diary/screens/basic_screens/bodyscreens/mainscreen/write_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

///1. 분석
///2. 일기 작성
///3. 일기 보여주는 거
///4. 설정

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  // 네비게이션 스크린
  final List<Widget> _bodyScreens = [
    InformationScreen(),
    CalendarRead(),
    WriteScreen(),
    ReadScreen(),
    SettingScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    final styleModel = new StyleModel(context);
    Api api = Provider.of(context);
    return FutureBuilder(
      future: api.fetchPost(),
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        return Scaffold(
          body: _bodyScreens[_selectedIndex],
          bottomNavigationBar: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.only(
                  topRight: Radius.circular(30), topLeft: Radius.circular(30)),
              boxShadow: [
                BoxShadow(
                    color: Colors.black38, spreadRadius: 0, blurRadius: 2),
              ],
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(30.0),
                topRight: Radius.circular(30.0),
              ),
              child: BottomNavigationBar(
                elevation: 0,
                type: BottomNavigationBarType.fixed,
                backgroundColor: Colors.white,
                unselectedItemColor:
                    styleModel.getBackgroundColor()['selectColor1'],
                selectedItemColor:
                    styleModel.getBackgroundColor()['selectColor2'],
                items: [
                  BottomNavigationBarItem(
                    icon: Padding(
                      padding: const EdgeInsets.only(top: 8.0),
                      child: new Icon(
                        Icons.home,
                        size: styleModel.getContextSize()['bigIconSize'],
                      ),
                    ),
                    title: new Text('', overflow: TextOverflow.ellipsis),
                  ),
                  BottomNavigationBarItem(
                    icon: Padding(
                      padding: const EdgeInsets.only(top: 8.0),
                      child: new Icon(
                        Icons.calendar_today,
                        size: styleModel.getContextSize()['bigIconSize'],
                      ),
                    ),
                    title: new Text('', overflow: TextOverflow.ellipsis),
                  ),
                  BottomNavigationBarItem(
                    icon: Padding(
                      padding: const EdgeInsets.only(top: 8.0),
                      child: Icon(
                        Icons.create,
                        size: styleModel.getContextSize()['bigIconSize'],
                      ),
                    ),
                    title: new Text('', overflow: TextOverflow.ellipsis),
                  ),
                  BottomNavigationBarItem(
                    icon: Padding(
                      padding: const EdgeInsets.only(top: 8.0),
                      child: Icon(
                        Icons.event_note,
                        size: styleModel.getContextSize()['bigIconSize'],
                      ),
                    ),
                    title: new Text('', overflow: TextOverflow.ellipsis),
                  ),
                  BottomNavigationBarItem(
                    icon: Padding(
                      padding: const EdgeInsets.only(top: 8.0),
                      child: Icon(
                        Icons.settings,
                        size: styleModel.getContextSize()['bigIconSize'],
                      ),
                    ),
                    title: new Text('', overflow: TextOverflow.ellipsis),
                  ),
                ],
                onTap: _onItemTapped,
                currentIndex: _selectedIndex,
              ),
            ),
          ),
        );
      },
    );
  }
}
