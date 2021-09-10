import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:provider/provider.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:odd_app/models/provider.dart';

class RemindPage extends StatefulWidget {
  @override
  _RemindPageState createState() => _RemindPageState();
}

class _RemindPageState extends State<RemindPage> with TickerProviderStateMixin {
  Map<DateTime, List> _events = {};
  List _selectedEvents;
  AnimationController _animationController;
  CalendarController _calendarController = CalendarController();
  DateTime selectedDay;
  String sex;

  @override
  void initState() {
    super.initState();
    final _selectedDay = DateTime.now();
    Products userdata = Provider.of<Products>(context, listen: false);

    for (int a = 0; a < userdata.userAllData.length; a++) {
      _events[DateTime.parse(userdata.userAllData.keys.toList()[a])] =
          userdata.userAllData.values.toList()[a];
      print(_events);
    }

    sex = userdata.sex;
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
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      appBar: AppBar(
        toolbarHeight: 50,
        backgroundColor: Colors.white,
        elevation: 0.0,
        title: Text(
          "Calender",
          style: TextStyle(fontSize: 25, fontWeight: FontWeight.w300),
        ),
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            size: 30,
            color: Colors.grey,
          ),
          onPressed: () {
            Navigator.pushReplacementNamed(context, "/menu");
          },
        ),
        actions: <Widget>[
          IconButton(
            icon: Icon(
              Icons.book,
              size: 30,
              color: HexColor("#4F8FA8"),
            ),
            onPressed: () {
              Navigator.pushReplacementNamed(context, "/remind2");
            },
          ),
        ],
      ),
      body: ListView(
        children: <Widget>[
          Padding(
            padding: EdgeInsets.all(10),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                Container(
                  width: MediaQuery.of(context).size.width,
                  height: 2,
                  color: Colors.grey,
                ),
                _buildTableCalendarWithBuilders(),
                SizedBox(
                  height: 10,
                ),
                Container(
                  width: MediaQuery.of(context).size.width,
                  height: 2,
                  color: Colors.grey,
                ),
                // _buildButtons(), -> 달력이 어떻게 표시될 지 선택할 버튼
                SizedBox(
                  height: 10,
                ),
                Container(
                    height: MediaQuery.of(context).size.height * 0.35,
                    child: _buildEventList()),
                SizedBox(
                  height: 10,
                ),
                Container(
                  width: MediaQuery.of(context).size.width,
                  height: 2,
                  color: Colors.grey,
                ),
                SizedBox(
                  height: 10,
                ),
              ],
            ),
          ),
        ],
      ),
    );
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
        outsideWeekendStyle: TextStyle()
            .copyWith(color: HexColor("#4F8FA8"), fontFamily: "NanumMyeongjo"),
        eventDayStyle: TextStyle().copyWith(fontFamily: "NanumMyeongjo"),
        //이벤트 있는 숫자
        weekdayStyle: TextStyle().copyWith(fontFamily: "NanumMyeongjo"),
        //달력 숫자
        weekendStyle: TextStyle().copyWith(
            color: HexColor("#4F8FA8"), fontFamily: "NanumMyeongjo"), //휴일 숫자 색
      ),
      daysOfWeekStyle: DaysOfWeekStyle(
        weekdayStyle: TextStyle().copyWith(fontFamily: "NanumMyeongjo"),
        weekendStyle: TextStyle()
            .copyWith(color: HexColor("#4F8FA8"), fontFamily: "NanumMyeongjo"),
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
              color: HexColor("#D0C3A3"),
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
            color: HexColor("#E8E6D1"),
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
            ? HexColor("#6F825A")
            : _calendarController.isToday(date)
                ? HexColor("#A6CBD4") //선택 x
                : HexColor("#4F8FA8"), //지난날의 정보
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
            decoration: BoxDecoration(
              border: Border.all(width: 0.8),
            ),
            margin: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 2),
            child: Row(
              children: [
                FlatButton(
                  child: Container(
                    child: Row(
                      children: <Widget>[
                        Container(
                          width: MediaQuery.of(context).size.width * 0.22,
                          height: MediaQuery.of(context).size.width * 0.22,
                          alignment: Alignment.center,
                          child: Container(
                            width: 80,
                            height: 80,
                            decoration: BoxDecoration(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(2.0)),
                              image: DecorationImage(
                                alignment: Alignment.center,
                                image: AssetImage(
                                  "images/${_selectedEvents[index]['image']}$sex.png",
                                ),
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 10,
                        ), //그림
                        Container(
                          width: MediaQuery.of(context).size.width * 0.47,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Text(
                                "${_selectedEvents[index]['title']}",
                                style: TextStyle(
                                    fontSize: 28,
                                    color: Colors.black,
                                    fontFamily: "NanumPenScript"),
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Text(
                                "${_selectedEvents[index]['date']}",
                                style: TextStyle(
                                    fontSize: 16, color: Colors.black),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  onPressed: () {
                    print(_selectedEvents[index].hashCode);
                    Navigator.pushReplacementNamed(context, "/todayDiary",
                        arguments: _selectedEvents[index]);
                  },
                ),
                Column(
                  children: [
                    IconButton(
                        icon: Icon(Icons.cancel_outlined),
                        iconSize: 20,
                        color: Colors.grey,
                        onPressed: () {
                          cancelCheckDialog(
                              context, index, _selectedEvents[index]);
                        }),
                  ],
                )
              ],
            ),
          );
        });
  }

  void cancelCheckDialog(
      BuildContext context, int removeIndex, var removeData) {
    print(context);
    print(removeData);

    showDialog(
        context: context,
        //barrierDismissible - Dialog를 제외한 다른 화면 터치 x
        barrierDismissible: false,
        builder: (BuildContext context) {
          Products userdata = Provider.of<Products>(context, listen: false);

          return AlertDialog(
            // RoundedRectangleBorder - Dialog 화면 모서리 둥글게 조절
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0)),
            //Dialog Main Title
            title: Column(
              children: <Widget>[
                new Text(
                  "삭제",
                  style: TextStyle(fontSize: 30, fontFamily: "NanumPenScript"),
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
                  style: TextStyle(fontSize: 24, fontFamily: "NanumPenScript"),
                ),
              ],
            ),
            actions: <Widget>[
              Row(
                children: [
                  new FlatButton(
                    child: new Text(
                      "취소",
                      style: TextStyle(
                          fontSize: 20,
                          fontFamily: "NanumPenScript",
                          color: Colors.black),
                    ),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  ),
                  new FlatButton(
                    child: new Text(
                      "확인",
                      style: TextStyle(
                          fontSize: 20,
                          fontFamily: "NanumPenScript",
                          color: Colors.black),
                    ),
                    onPressed: () {
                      setState(() {
                        print(selectedDay.runtimeType);
                        userdata.removeText(removeData);
                      });
                      Navigator.of(context).pushReplacementNamed('/menu');
                    },
                  ),
                ],
              ),
            ],
          );
        });
  }
}

/*
*  ListView(
      children: _selectedEvents.map(
              (event) => Container(
                decoration: BoxDecoration(
                  border: Border.all(width: 0.8),
                ),
                margin:
                    const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
                child: ListTile(
              title: Text( "${event['title']}",style: TextStyle(fontFamily: 'NanumPenScript',fontSize: 24),),
              onTap: () => print('${event['title']} tapped!'),
            ),
              ))
          .toList(),
    );
    * */
/*
// 달력 타입
  Widget _buildButtons() {
    final dateTime = _events.keys.elementAt(_events.length - 2);

    return Column(
      children: <Widget>[
        Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            RaisedButton(
              child: Text('Month'),
              onPressed: () {
                setState(() {
                  _calendarController.setCalendarFormat(CalendarFormat.month);
                });
              },
            ),
            RaisedButton(
              child: Text('2 weeks'),
              onPressed: () {
                setState(() {
                  _calendarController
                      .setCalendarFormat(CalendarFormat.twoWeeks);
                });
              },
            ),
            RaisedButton(
              child: Text('Week'),
              onPressed: () {
                setState(() {
                  _calendarController.setCalendarFormat(CalendarFormat.week);
                });
              },
            ),
          ],
        ),
        const SizedBox(height: 8.0),
        RaisedButton(
          child: Text(
              'Set day ${dateTime.day}-${dateTime.month}-${dateTime.year}'),
          onPressed: () {
            _calendarController.setSelectedDay(
              DateTime(dateTime.year, dateTime.month, dateTime.day),
              runCallback: true,
            );
          },
        ),
      ],
    );
  }
*/
