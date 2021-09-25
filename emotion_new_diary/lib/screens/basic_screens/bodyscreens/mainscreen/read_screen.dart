import 'dart:convert';

import 'package:emotion_new_diary/api/api.dart';
import 'package:emotion_new_diary/model/style.dart';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class ReadScreen extends StatefulWidget {
  @override
  _ReadScreenState createState() => _ReadScreenState();
}

class _ReadScreenState extends State<ReadScreen> {
  Map<DateTime, List> _events = {};

  @override
  Widget build(BuildContext context) {
    Api api = Provider.of<Api>(context, listen: false);
    final styleModel = StyleModel(context);
    List userListData = [];

    return FutureBuilder(
        future: api.fetchPost(),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.hasData) {
            api.inputData(snapshot.data);
            List userKeyData = api.userAllData.keys.toList();
            for (int a = 0; a < api.userAllData.keys.length; a++) {
              for (int b = 0; b < api.userAllData[userKeyData[a]].length; b++) {
                userListData.add(api.userAllData[userKeyData[a]][b]);
              }
            }
            print(userListData);
            return ListView.builder(
                itemCount: userListData.length,
                itemBuilder: (BuildContext context, int index) {
                  return  Container(
                    color: styleModel.getBackgroundColor()["backgroundColor1"],
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
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
                                    width: styleModel.getContextSize()['fullScreenWidth'],
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
                                          DateTime.parse(userListData[index]['date'])),
                                      style:
                                      styleModel.getTextStyle()["calenderTextStyle1"],
                                    ),
                                  ),
                                ),
                                Flexible(
                                  flex: 1,
                                  child: Container(
                                    width: styleModel.getContextSize()['fullScreenWidth'],
                                    height: 2,
                                    color: Colors.grey[200],
                                  ),
                                ),
                              ],
                            ),
                            //제목
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  Text(
                                    utf8.decode(userListData[index]['title']
                                        .toString()
                                        .codeUnits),
                                    style: styleModel.getTextStyle()["calenderTextStyle2"],
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
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                utf8.decode(
                                    userListData[index]['content'].toString().codeUnits),
                                style: styleModel.getTextStyle()["calenderTextStyle3"],
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
                                    style: styleModel.getTextStyle()["calenderTextStyle2"],
                                    textAlign: TextAlign.center,
                                  ),
                                  Container(
                                    width: styleModel.getContextSize()["screenWidthLevel2"],
                                    height:
                                    styleModel.getContextSize()["screenHeightLevel11"],
                                    child: ListView.builder(
                                      scrollDirection: Axis.horizontal,
                                      itemCount: 10,
                                      itemBuilder: (BuildContext context, int index) {
                                        return Container(
                                          width: styleModel
                                              .getContextSize()["screenHeightLevel11"],
                                          height: styleModel
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
                            //FlatButton(child: Container(color: Colors.yellow,width: 100,height: 100,), onPressed: () => cancelCheckDialog(context, index, _selectedEvents[index]))
                          ],
                        ),
                      ),
                    ),
                  );
                });
          } else {
            return  Container(
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
                      "No information :(",
                      style: styleModel.getTextStyle()['titleTextStyle'],
                    ),
                  ),
                ),
              ),
            );
          }
        });
  }
}
