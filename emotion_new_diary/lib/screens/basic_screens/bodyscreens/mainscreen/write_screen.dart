import 'package:emotion_new_diary/api/api.dart';
import 'package:emotion_new_diary/model/style.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class WriteScreen extends StatefulWidget {
  @override
  _WriteScreenState createState() => _WriteScreenState();
}

class _WriteScreenState extends State<WriteScreen> {
  StyleModel _styleModel;
  DateTime todayNow = DateTime.now();

  //일기 컨트롤러
  final TextEditingController _contentController = TextEditingController();
  final TextEditingController _titleController = TextEditingController();
  final FocusNode _titleFocus = FocusNode();
  final FocusNode _contentFocus = FocusNode();


  List<Map<String, dynamic>> emotion = [
    {"emotion_0": false, "type": "angry", "korea_name": "화남"},
    {"emotion_1": false, "type": "happy", "korea_name": "신남"},
    {"emotion_2": false, "type": "sensitiveness", "korea_name": "예민"},
    {"emotion_3": false, "type": "blue", "korea_name": "우울"},
    {"emotion_4": false, "type": "timid", "korea_name": "소심"},
  ];
  List<Map<String, dynamic>> weather = [
    {"weather_0": false, "type": "sun", "korea_name": "해"},
    {"weather_1": false, "type": "cloud", "korea_name": "구름"},
    {"weather_2": false, "type": "rain", "korea_name": "비"},
    {"weather_3": false, "type": "snow", "korea_name": "눈"},
  ];
  List<Map<String, dynamic>> category = [
    {"category_0": false, "type": "study", "korea_name": "공부"},
    {"category_1": false, "type": "exercise", "korea_name": "운동"},
    {"category_2": false, "type": "game", "korea_name": "게임"},
    {"category_3": false, "type": "trip", "korea_name": "여행"},
    {"category_4": false, "type": "Chatter", "korea_name": "수다"},
  ];

  Map<String, dynamic> data = {
    "username": "",
    "date": "",
    "title": "",
    "content": "",
    "image_type": "", //
    "category_json": {
      "weather": "", // 한글
      "activity": [], // 배열, 한글
    }
  };

  @override
  Widget build(BuildContext context) {
    final styleModel = StyleModel(context);
    _styleModel = styleModel;
    Api api = Provider.of<Api>(context);
    String todayData = DateFormat('yyyy-MM-dd').format(todayNow);

    return Container(
      height: MediaQuery.of(context).size.height * 1,
      width: MediaQuery.of(context).size.width * 1,
      color: styleModel.getBackgroundColor()['homeBackgroundColor2'],
      child: ListView(
        children: [
          Container(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(0, 10, 0, 10),
                  child: Column(
                    children: [
                      categorical(5, emotion, "emotion", "감정"),
                      categorical(4, weather, "weather", "날씨"),
                      categorical(5, category, "category", "활동"),
                      // 일기 작성
                      Padding(
                        padding: const EdgeInsets.all(10),
                        child: Container(
                          width:
                              _styleModel.getContextSize()["fullScreenWidth"],
                          height: _styleModel
                              .getContextSize()["screenHeightLevel6"],
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(14),
                          ),
                          child: Column(
                            children: [
                              Flexible(
                                flex: 2,
                                child: TextFormField(
                                  controller: _titleController,
                                  cursorColor: Colors.grey,
                                  textAlign: TextAlign.center,
                                  maxLength: 15,
                                  maxLines: 1,
                                  textInputAction: TextInputAction.next,
                                  focusNode: _titleFocus,
                                  onFieldSubmitted: (term) {
                                    _fieldFocusChange(
                                        context, _titleFocus, _contentFocus);
                                  },
                                  decoration: InputDecoration(
                                    border: InputBorder.none,
                                    contentPadding:
                                        EdgeInsets.fromLTRB(20, 10, 20, 0),
                                    hintText: "제목",
                                    hintStyle: _styleModel
                                        .getTextStyle()['writeTextStyle1'],
                                    counterStyle: _styleModel
                                        .getTextStyle()['writeTextStyle2'],
                                  ),
                                  style: _styleModel
                                      .getTextStyle()['writeTextStyle1'],
                                  onChanged: (value) {
                                    setState(() {
                                      print(_titleController);
                                    });
                                  },
                                ),
                              ),
                              Flexible(
                                flex: 1,
                                child: Center(
                                  child: Container(
                                    height: 0.5,
                                    width: _styleModel
                                        .getContextSize()["screenWidthLevel1"],
                                    color: Colors.grey,
                                  ),
                                ),
                              ),
                              Flexible(
                                flex: 9,
                                child: TextFormField(
                                  controller: _contentController,
                                  cursorColor: Colors.grey,
                                  textAlign: TextAlign.center,
                                  maxLines: 10,
                                  keyboardType: TextInputType.multiline,
                                  focusNode: _contentFocus,
                                  textInputAction: TextInputAction.done,
                                  decoration: InputDecoration(
                                    hoverColor: Colors.yellow,
                                    border: InputBorder.none,
                                    contentPadding:
                                        EdgeInsets.fromLTRB(20, 10, 20, 0),
                                    hintText: "내용",
                                    hintStyle: _styleModel
                                        .getTextStyle()['writeTextStyle3'],
                                  ),
                                  style: _styleModel
                                      .getTextStyle()['writeTextStyle3'],
                                  onChanged: (value) {
                                    setState(() {});
                                  },
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      InkWell(
                        child: Padding(
                          padding: EdgeInsets.all(10),
                          child: Container(
                            width:
                                _styleModel.getContextSize()["fullScreenWidth"],
                            height: _styleModel
                                .getContextSize()["screenHeightLevel10"],
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(14),
                            ),
                            child: Center(
                              child: Text(
                                "작성 완료",
                                style: _styleModel
                                    .getTextStyle()['writeTextStyle4'],
                              ),
                            ),
                          ),
                        ),
                        onTap: () {
                          //유저 이름 넣음
                          data['username'] = api.userName;
                          //감정 넣음
                          for (int a = 0; a < 5; a++) {
                            if (emotion[a]['emotion_$a'] == true) {
                              data["image_type"] = emotion[a]['type'];
                            }
                            //카테고리
                            else if (category[a]['category_$a'] == true) {
                              if (!data["category_json"]["activity"]
                                  .contains(category[a]['korea_name'])) {
                                data["category_json"]["activity"]
                                    .add(category[a]['korea_name']);
                              }
                            }
                          }
                          for (int a = 0; a < 4; a++) {
                            //날씨 넣음
                            if (weather[a]['weather_$a'] == true) {
                              data["category_json"]["weather"] =
                                  weather[a]['korea_name'];
                            }
                          }
                          //내용 넣음
                          data["title"] = _titleController.text;
                          data["content"] = _contentController.text;
                          data["date"] = todayData;
                           api.addText(data);
                        },
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Container categorical(int num, List type, String typeName, String title) {
    return Container(
      child: Padding(
          padding: const EdgeInsets.all(10),
          child: Container(
            width: _styleModel.getContextSize()["fullScreenWidth"],
            height: _styleModel.getContextSize()["screenHeightLevel8.3"],
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(14),
            ),
            child: Column(
              children: [
                Flexible(
                    flex: 3,
                    child: Center(
                        child: Text(
                      title,
                      style: _styleModel.getTextStyle()['writeTextStyle1'],
                    ))),
                Flexible(
                  flex: 6,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      for (int a = 0; a < num; a++)
                        (type[a]["${typeName}_$a"]
                            ? InkWell(
                                child: Container(
                                  height: _styleModel
                                      .getContextSize()["screenHeightLevel9.5"],
                                  width: _styleModel
                                      .getContextSize()["screenHeightLevel9.5"],
                                  decoration: BoxDecoration(
                                    color: Colors.yellow,
                                    borderRadius: BorderRadius.circular(360),
                                  ),
                                ),
                                onTap: () {
                                  setState(() {
                                    if (typeName == "emotion") {
                                      type[a]["${typeName}_$a"] = false;
                                    } else if (typeName == "weather") {
                                      type[a]["${typeName}_$a"] = false;
                                    } else {
                                      type[a]["${typeName}_$a"] = false;
                                    }
                                  });
                                },
                              )
                            : InkWell(
                                child: Container(
                                  height: _styleModel
                                      .getContextSize()["screenHeightLevel9.5"],
                                  width: _styleModel
                                      .getContextSize()["screenHeightLevel9.5"],
                                  decoration: BoxDecoration(
                                    color: Colors.black12,
                                    borderRadius: BorderRadius.circular(360),
                                  ),
                                ),
                                onTap: () {
                                  setState(() {
                                    if (typeName == "emotion") {
                                      type[0]['emotion_0'] = false;
                                      type[1]['emotion_1'] = false;
                                      type[2]['emotion_2'] = false;
                                      type[3]['emotion_3'] = false;
                                      type[4]['emotion_4'] = false;
                                      type[a]["${typeName}_$a"] = true;
                                    } else if (typeName == "weather") {
                                      type[0]['weather_0'] = false;
                                      type[1]['weather_1'] = false;
                                      type[2]['weather_2'] = false;
                                      type[3]['weather_3'] = false;
                                      type[a]["${typeName}_$a"] = true;
                                    } else {
                                      type[a]["${typeName}_$a"] = true;
                                    }
                                  });
                                },
                              ))
                    ],
                  ),
                ),
              ],
            ),
          )),
    );
  }

  _fieldFocusChange(
      BuildContext context, FocusNode currentFocus, FocusNode nextFocus) {
    currentFocus.unfocus();
    FocusScope.of(context).requestFocus(nextFocus);
  }
}
