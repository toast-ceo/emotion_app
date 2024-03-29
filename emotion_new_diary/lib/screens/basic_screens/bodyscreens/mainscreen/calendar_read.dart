// ignore_for_file: unnecessary_statements

import 'dart:convert';

import 'package:emotion_new_diary/api/api.dart';
import 'package:emotion_new_diary/model/style.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:table_calendar/table_calendar.dart';

Color hexToColor(String code) {
  return new Color(int.parse(code.substring(1, 7), radix: 16) + 0xFF000000);
}

class CalendarRead extends StatefulWidget {
  @override
  _CalendarRead createState() => _CalendarRead();
}

class _CalendarRead extends State<CalendarRead> with TickerProviderStateMixin {
  Map<DateTime, List> _events = {};
  List _selectedEvents;
  AnimationController _animationController;
  CalendarController _calendarController = CalendarController();
  DateTime selectedDay;
  StyleModel _styleModel;
  FutureBuilder _futureBuilder;

  @override
  void initState() {
    super.initState();
    final _selectedDay = DateTime.now();

    _selectedEvents = _events[_selectedDay] ?? [];
    _calendarController = CalendarController();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 400),
    );
    _animationController.forward();

  }

  @override
  void dispose() {
    _animationController.dispose();
    _calendarController.dispose();
    super.dispose();
  }

  ///상태를 확인해줌
  void _onDaySelected(DateTime day, List events, List holidays) {
    print('CALLBACK: _onDaySelected');
    setState(() {
      _selectedEvents = events;
      selectedDay = day;
    });
  }

  void _onVisibleDaysChanged(
      DateTime first, DateTime last, CalendarFormat format) {
    print('CALLBACK: _onVisibleDaysChanged');
  }

  void _onCalendarCreated(
      DateTime first, DateTime last, CalendarFormat format) {
    print('CALLBACK: _onCalendarCreated');
  }

  @override
  Widget build(BuildContext context) {
    Api api = Provider.of<Api>(context, listen: false);
    final styleModel = StyleModel(context);
    _styleModel = styleModel;

    final builder = FutureBuilder(
        future: api.fetchPost(),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.hasData) {
            api.inputData(snapshot.data);
            for (int a = 0; a < api.userAllData.length; a++) {
              _events[DateTime.parse(api.userAllData.keys.toList()[a])] =
              api.userAllData.values.toList()[a];
              print(_events);
            }
            return Container(
              color: styleModel.getBackgroundColor()['homeBackgroundColor1'],
              child: ListView(
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.all(10),
                    child: Column(
                      children: <Widget>[
                        Container(
                          width: _styleModel
                              .getContextSize()['fullScreenWidth'],
                          height: 2,
                          color: Colors.grey[200],
                        ),
                        _buildTableCalendarWithBuilders(),
                        SizedBox(
                          height: 10,
                        ),

                        // _buildButtons(), -> 달력이 어떻게 표시될 지 선택할 버튼
                        SizedBox(
                          height: 10,
                        ),
                        Container(
                            height: styleModel
                                .getContextSize()['screenHeightLevel6.5'],
                            child: _buildEventList()),
                      ],
                    ),
                  ),
                ],
              ),
            );
          } else {
            return Container(
              height: styleModel.getContextSize()['fullScreenHeight'],
              child: Center(
                child: Container(
                  width: styleModel.getContextSize()['screenWidthLevel3'],
                  height: styleModel.getContextSize()['screenWidthLevel8'],
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: <Color>[
                        styleModel.getBackgroundColor()['backgroundColor5'],
                        styleModel.getBackgroundColor()['backgroundColor2'],
                        styleModel.getBackgroundColor()['backgroundColor3'],
                        styleModel.getBackgroundColor()['backgroundColor4'],
                        styleModel.getBackgroundColor()['backgroundColor6'],
                      ],
                    ),
                  ),
                  child: Center(
                    child: Text(
                      "일기를 작성해보세요!",
                      style: styleModel.getTextStyle()['titleTextStyle2'],
                    ),
                  ),
                ),
              ),
            );
          }
        });
    _futureBuilder = builder;
    return _futureBuilder;
  }

  Widget _buildTableCalendarWithBuilders() {
    return TableCalendar(
      locale: 'en_Us',
      calendarController: _calendarController,
      events: _events,
      initialCalendarFormat: CalendarFormat.month,
      formatAnimation: FormatAnimation.slide,
      startingDayOfWeek: StartingDayOfWeek.sunday,
      availableGestures: AvailableGestures.all,
      availableCalendarFormats: const {
        CalendarFormat.month: '',
        //CalendarFormat.week: '',
      },
      calendarStyle: CalendarStyle(
        outsideDaysVisible: false,
        outsideWeekendStyle: TextStyle().copyWith(
            color: hexToColor("#4F8FA8"), fontFamily: "NanumMyeongjo"),
        eventDayStyle: TextStyle().copyWith(fontFamily: "NanumMyeongjo"),
        //이벤트 있는 숫자
        weekdayStyle: TextStyle().copyWith(fontFamily: "NanumMyeongjo"),
        //달력 숫자
        weekendStyle: TextStyle().copyWith(
            color: hexToColor("#4F8FA8"),
            fontFamily: "NanumMyeongjo"), //휴일 숫자 색
      ),
      daysOfWeekStyle: DaysOfWeekStyle(
        weekdayStyle: TextStyle().copyWith(fontFamily: "NanumMyeongjo"),
        weekendStyle: TextStyle().copyWith(
            color: hexToColor("#4F8FA8"), fontFamily: "NanumMyeongjo"),
      ),
      headerStyle: HeaderStyle(
        centerHeaderTitle: true,
        formatButtonVisible: false,
        titleTextStyle: TextStyle().copyWith(fontFamily: "NanumMyeongjo"),
      ),
      builders: CalendarBuilders(
        selectedDayBuilder: (context, date, _) {
          return FadeTransition(
            opacity: Tween(begin: 0.0, end: 1.0).animate(_animationController),
            child: Container(
              margin: const EdgeInsets.all(4.0),
              padding: const EdgeInsets.only(top: 5.0, left: 6.0),
              //선택칸 색상
              color: hexToColor("#D0C3A3"),
              width: 100,
              height: 100,
              child: Text(
                '${date.day}',
                style: TextStyle().copyWith(
                  fontSize: 14.0,
                  fontFamily: 'NanumMyeongjo',
                ),
              ),
            ),
          );
        },
        todayDayBuilder: (context, date, _) {
          return Container(
            margin: const EdgeInsets.all(4.0),
            padding: const EdgeInsets.only(top: 5.0, left: 6.0),
            color: hexToColor("#E8E6D1"),
            width: 100,
            height: 100,
            child: Text(
              '${date.day}',
              style: TextStyle().copyWith(
                fontSize: 14.0,
                fontFamily: 'NanumMyeongjo',
              ),
            ),
          );
        },
        markersBuilder: (context, date, events, holidays) {
          final children = <Widget>[];
          if (events.isNotEmpty) {
            children.add(
              Positioned(
                right: 1,
                bottom: 1,
                child: _buildEventsMarker(date, events),
              ),
            );
          }
          return children;
        },
      ),
      onDaySelected: (date, events, holidays) {
        _onDaySelected(date, events, holidays);
        _animationController.forward(from: 0.0);
      },
      onVisibleDaysChanged: _onVisibleDaysChanged,
      onCalendarCreated: _onCalendarCreated,
    );
  }

  Widget _buildEventsMarker(DateTime date, List events) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      decoration: BoxDecoration(
        shape: BoxShape.rectangle,
        color: _calendarController.isSelected(date)
            ? hexToColor("#6F825A")
            : _calendarController.isToday(date)
                ? hexToColor("#A6CBD4") //선택 x
                : hexToColor("#4F8FA8"), //지난날의 정보
      ),
      width: 16.0,
      height: 16.0,
      child: Center(
        child: Text(
          '${events.length}',
          style: TextStyle().copyWith(
            color: Colors.white,
            fontSize: 12.0,
            fontFamily: 'NanumMyeongjo',
          ),
        ),
      ),
    );
  }

  Widget _buildEventList() {
    return ListView.builder(
        itemCount: _selectedEvents.length,
        itemBuilder: (context, index) {
          return Container(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                //날짜
                Row(
                  children: [
                    // 위의 바
                    Flexible(
                      flex: 5,
                      child: Container(
                        width: _styleModel.getContextSize()['fullScreenWidth'],
                        height: 2,
                        color: Colors.grey[200],
                      ),
                    ),
                    Flexible(
                      flex: 3,
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                        child: Text(
                          DateFormat("yyyy.MM.dd").format(
                              DateTime.parse(_selectedEvents[index]['date'])),
                          style:
                              _styleModel.getTextStyle()["calenderTextStyle1"],
                        ),
                      ),
                    ),
                    Flexible(
                      flex: 1,
                      child: Container(
                        width: _styleModel.getContextSize()['fullScreenWidth'],
                        height: 2,
                        color: Colors.grey[200],
                      ),
                    ),
                  ],
                ),
                //제목
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Stack(
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Text(
                            utf8.decode(_selectedEvents[index]['title']
                                .toString()
                                .codeUnits),
                            style: _styleModel
                                .getTextStyle()["calenderTextStyle2"],
                            textAlign: TextAlign.center,
                          ),
                          // SizedBox(
                          //   width: 10,
                          // ),
                          // Text(
                          //   _selectedEvents[index]['image_type'],
                          //   style: _styleModel.getTextStyle()["calenderTextStyle4"],
                          //   textAlign: TextAlign.center,
                          // ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          IconButton(
                              icon: Icon(Icons.cancel_outlined),
                              color: Colors.grey,
                              iconSize: _styleModel
                                  .getContextSize()['middleIconSize'],
                              onPressed: () => cancelCheckDialog(
                                  context, index, _selectedEvents[index]))
                        ],
                      )
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    utf8.decode(
                        _selectedEvents[index]['content'].toString().codeUnits),
                    style: _styleModel.getTextStyle()["calenderTextStyle3"],
                    textAlign: TextAlign.center,
                  ),
                ),
                // tag
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    children: [
                      Text(
                        "#",
                        style: _styleModel.getTextStyle()["calenderTextStyle2"],
                        textAlign: TextAlign.center,
                      ),
                      Container(
                        width:
                            _styleModel.getContextSize()["screenWidthLevel2"],
                        height:
                            _styleModel.getContextSize()["screenHeightLevel11"],
                        child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: 10,
                          itemBuilder: (BuildContext context, int index) {
                            return Container(
                              width: _styleModel
                                  .getContextSize()["screenHeightLevel11"],
                              height: _styleModel
                                  .getContextSize()["screenHeightLevel11"],
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 40,
                ),
              ],
            ),
          );
        });
  }

  void cancelCheckDialog(
      BuildContext context, int removeIndex, var removeData) {


    showDialog(
        context: context,
        //barrierDismissible - Dialog를 제외한 다른 화면 터치 x
        barrierDismissible: false,
        builder: (BuildContext context) {
          Api api = Provider.of<Api>(context, listen: false);

          return AlertDialog(
            // RoundedRectangleBorder - Dialog 화면 모서리 둥글게 조절
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0)),
            //Dialog Main Title
            title: Column(
              children: <Widget>[
                new Text(
                  "삭제",
                  style: _styleModel.getTextStyle()['AlertTextStyle1'],
                ),
              ],
            ),
            //
            content: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                new Text(
                  "일기를 삭제 하시겠습니까?",
                  style: _styleModel.getTextStyle()['AlertTextStyle3'],
                ),
              ],
            ),
            actions: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: new InkWell(
                      child: new Text(
                        "취소",
                        style: _styleModel.getTextStyle()['AlertTextStyle2'],
                      ),
                      onTap: () {
                        Navigator.pop(context);
                      },
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: new InkWell(
                      child: new Text(
                        "확인",
                        style: _styleModel.getTextStyle()['AlertTextStyle2'],
                      ),
                      onTap: () {
                        setState(() {
                          api.removeText(removeData);
                          _futureBuilder;
                        });
                        Navigator.pushReplacementNamed(context, '/home');

                      },
                    ),
                  ),
                ],
              ),
            ],
          );
        });
  }
}
