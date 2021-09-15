import 'package:emotion_new_diary/model/style.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

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
    {"emotion_0": false},
    {"emotion_1": false},
    {"emotion_2": false},
    {"emotion_3": false},
    {"emotion_4": false},
  ];
  List<Map<String, dynamic>> weather = [
    {"weather_0": false},
    {"weather_1": false},
    {"weather_2": false},
    {"weather_3": false},
  ];
  List<Map<String, dynamic>> category = [
    {"category_0": false},
    {"category_1": false},
    {"category_2": false},
    {"category_3": false},
    {"category_4": false},
  ];

  @override
  Widget build(BuildContext context) {
    final styleModel = StyleModel(context);
    _styleModel = styleModel;

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
                               width:
                                      _styleModel.getContextSize()["screenWidthLevel1"],
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
                        child: Padding(padding: EdgeInsets.all(10),
                          child:  Container(
                              width: _styleModel.getContextSize()["fullScreenWidth"],
                              height: _styleModel.getContextSize()["screenHeightLevel10"],
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(14),
                              ),
                           child: Center(
                            child: Text("작성 완료", style: _styleModel.getTextStyle()['writeTextStyle4'],),
                          ),),
                        ),
                        onTap: (){
                          print(todayData);
                          Map<String, dynamic> data = {
                            "username": "KIM",
                            "date": todayData,
                            "title":  _titleController.text,
                            "content":  _contentController.text,
                            "image_type": "happy",
                            "category_json": {
                              "weather": "string",
                              "activity": [
                                "string"
                              ]
                            }
                          };
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
