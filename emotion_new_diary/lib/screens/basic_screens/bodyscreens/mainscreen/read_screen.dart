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
  StyleModel _styleModel;
  String selectedItem = 'all';

  @override
  Widget build(BuildContext context) {
    Api api = Provider.of<Api>(context, listen: false);
    final styleModel = StyleModel(context);
    _styleModel = styleModel;
    List userListData = [];
    List _options = ['all', 'angry', 'happy', 'sensitiveness', 'blue', 'timid'];

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
            return Container(
              height: styleModel.getContextSize()["fullScreenHeight"],
              color: styleModel.getBackgroundColor()["backgroundColor1"],
              child: Column(
                children: [
                  Flexible(
                      flex: 2,
                      child: Card(
                        child: Container(
                          height: MediaQuery.of(context).size.height * 0.25,
                          width: MediaQuery.of(context).size.width * 1,
                          child: Row(
                            children: [
                              Flexible(
                                flex: 1,
                                child: InkWell(
                                  child: Container(
                                    color: styleModel.getBackgroundColor()[
                                        "backgroundColor1"], //흰색
                                  ),
                                  onTap: () {
                                    setState(() {
                                      selectedItem = _options[0];
                                    });
                                  },
                                ),
                              ),
                              Flexible(
                                flex: 1,
                                child: InkWell(
                                  child: Container(
                                    color: styleModel.getBackgroundColor()[
                                        "backgroundColor6"], //빨강
                                  ),
                                  onTap: () {
                                    setState(() {
                                      selectedItem = _options[1];
                                    });
                                  },
                                ),
                              ),
                              Flexible(
                                flex: 1,
                                child: InkWell(
                                  child: Container(
                                    color: styleModel.getBackgroundColor()[
                                        "backgroundColor4"], // 노랑
                                  ),
                                  onTap: () {
                                    setState(() {
                                      selectedItem = _options[2];
                                    });
                                  },
                                ),
                              ),
                              Flexible(
                                flex: 1,
                                child: InkWell(
                                  child: Container(
                                    color: styleModel.getBackgroundColor()[
                                        "backgroundColor3"], //초록
                                  ),
                                  onTap: () {
                                    setState(() {
                                      selectedItem = _options[3];
                                    });
                                  },
                                ),
                              ),
                              Flexible(
                                flex: 1,
                                child: InkWell(
                                  child: Container(
                                    color: styleModel.getBackgroundColor()[
                                        "backgroundColor2"], // 파랑
                                  ),
                                  onTap: () {
                                    setState(() {
                                      selectedItem = _options[4];
                                    });
                                  },
                                ),
                              ),
                              Flexible(
                                flex: 1,
                                child: InkWell(
                                  child: Container(
                                    color: styleModel.getBackgroundColor()[
                                        "backgroundColor5"], //보라
                                  ),
                                  onTap: () {
                                    setState(() {
                                      selectedItem = _options[5];
                                    });
                                  },
                                ),
                              ),
                            ],
                          ),
                        ),
                        elevation: 1,
                      )),
                  Flexible(
                    flex: 11,
                    child: ListView.builder(
                        itemCount: userListData.length,
                        itemBuilder: (BuildContext context, int index) {
                          return userListData[index]['image_type'] ==
                                      selectedItem ||
                                  selectedItem == 'all'
                              ? Container(
                                  color: styleModel
                                      .getBackgroundColor()["backgroundColor1"],
                                  child: Padding(
                                    padding:
                                        const EdgeInsets.fromLTRB(8, 0, 8, 0),
                                    child: Container(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          //날짜
                                          Row(
                                            children: [
                                              // 위의 바
                                              Flexible(
                                                flex: 1,
                                                child: Container(
                                                  width: styleModel
                                                          .getContextSize()[
                                                      'fullScreenWidth'],
                                                  height: 2,
                                                  color: Colors.grey[200],
                                                ),
                                              ),
                                              Flexible(
                                                flex: 1,
                                                child: Padding(
                                                  padding:
                                                      const EdgeInsets.fromLTRB(
                                                          10, 0, 10, 0),
                                                  child: Text(
                                                    DateFormat("yyyy.MM.dd")
                                                        .format(DateTime.parse(
                                                            userListData[index]
                                                                ['date'])),
                                                    style: styleModel
                                                            .getTextStyle()[
                                                        "calenderTextStyle1"],
                                                  ),
                                                ),
                                              ),
                                              Flexible(
                                                flex: 1,
                                                child: Container(
                                                  width: styleModel
                                                          .getContextSize()[
                                                      'fullScreenWidth'],
                                                  height: 2,
                                                  color: Colors.grey[200],
                                                ),
                                              ),
                                            ],
                                          ),
                                          //제목
                                          Padding(
                                            padding: const EdgeInsets.fromLTRB(
                                                8, 20, 8, 20),
                                            child: Stack(
                                              children: [
                                                Row(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.center,
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  children: [
                                                    Text(
                                                      utf8.decode(
                                                          userListData[index]
                                                                  ['title']
                                                              .toString()
                                                              .codeUnits),
                                                      style: styleModel
                                                              .getTextStyle()[
                                                          "calenderTextStyle2"],
                                                      textAlign:
                                                          TextAlign.center,
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
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.end,
                                                  children: [
                                                    Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment.end,
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: [
                                                        IconButton(
                                                            icon: Icon(Icons
                                                                .cancel_outlined),
                                                            color: Colors.grey,
                                                            iconSize: _styleModel
                                                                    .getContextSize()[
                                                                'middleIconSize'],
                                                            onPressed: () =>
                                                                cancelCheckDialog(
                                                                    context,
                                                                    index,
                                                                    userListData[
                                                                        index]))
                                                      ],
                                                    )
                                                  ],
                                                )
                                              ],
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Text(
                                              utf8.decode(userListData[index]
                                                      ['content']
                                                  .toString()
                                                  .codeUnits),
                                              style: styleModel.getTextStyle()[
                                                  "calenderTextStyle3"],
                                              textAlign: TextAlign.center,
                                            ),
                                          ),
                                          // tag
                                          Padding(
                                            padding: const EdgeInsets.fromLTRB(
                                                20, 10, 20, 0),
                                            child: Row(
                                              children: [
                                                Container(
                                                  width: styleModel
                                                          .getContextSize()[
                                                      "screenWidthLevel2"],
                                                  height: styleModel
                                                          .getContextSize()[
                                                      "screenHeightLevel11"],
                                                  child: ListView.builder(
                                                    scrollDirection:
                                                        Axis.horizontal,
                                                    itemCount: 10,
                                                    itemBuilder:
                                                        (BuildContext context,
                                                            int index) {
                                                      return Container(
                                                        width: styleModel
                                                                .getContextSize()[
                                                            "screenHeightLevel11"],
                                                        height: styleModel
                                                                .getContextSize()[
                                                            "screenHeightLevel11"],
                                                      );
                                                    },
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                          SizedBox(
                                            height: 20,
                                          ),
                                          //FlatButton(child: Container(color: Colors.yellow,width: 100,height: 100,), onPressed: () => cancelCheckDialog(context, index, _selectedEvents[index]))
                                        ],
                                      ),
                                    ),
                                  ),
                                )
                              : Container();
                        }),
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
                        });
                        Navigator.pushReplacementNamed(context, '/home');

                        // Navigator.of(context).pop();
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
