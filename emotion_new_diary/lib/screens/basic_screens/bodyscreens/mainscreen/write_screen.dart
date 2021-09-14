import 'package:emotion_new_diary/model/style.dart';
import 'package:flutter/material.dart';

class WriteScreen extends StatefulWidget {
  @override
  _WriteScreenState createState() => _WriteScreenState();
}

class _WriteScreenState extends State<WriteScreen> {
  StyleModel _styleModel;
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
                  child: Container(
                    child: Column(
                      children: [
                        categorical(4, emotion, "emotion"),
                        categorical(4, weather, "weather"),
                        categorical(5, category, "category")
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Container categorical(int num, List type, String typeName) {
    return Container(
      child: Padding(
          padding: const EdgeInsets.all(10),
          child: Container(
            width: _styleModel.getContextSize()["fullScreenWidth"],
            height: _styleModel.getContextSize()["screenHeightLevel8.5"],
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(14),
            ),
            child: Column(
              children: [
                Flexible(flex: 2, child: Container()),
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
                                    type[a]["${typeName}_$a"] = false;
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
                                    type[a]["${typeName}_$a"] = true;
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
}
