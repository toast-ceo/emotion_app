import 'package:emotion_new_diary/model/chartData.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:emotion_new_diary/model/style.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class InformationScreen extends StatefulWidget {
  @override
  _InformationScreenState createState() => _InformationScreenState();
}

class _InformationScreenState extends State<InformationScreen> {
  int count;
  TextEditingController yController = TextEditingController();
  String yearText;
  var _styleModel;

  final List<Map> emotionDate = [
    {"emotion_type": "unknown", "year_count": "70", "color": "backgroundColor3"},
    {"emotion_type": "happy", "year_count": "30", "color": "backgroundColor4"},
    {"emotion_type": "mood", "year_count": "40", "color": "backgroundColor6"},
    {"emotion_type": "blue", "year_count": "20", "color": "backgroundColor2"},
    {"emotion_type": "angry", "year_count": "10", "color": "backgroundColor5"},
  ];


  // 년도 설정
  yearPicker() {
    final year = DateTime.now().year;

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(
            '시작년도를 입력하세요',
            textAlign: TextAlign.center,
          ),
          content: Container(
            height: MediaQuery.of(context).size.height / 4.0,
            width: MediaQuery.of(context).size.width,
            color: Colors.grey[200],
            child: YearPicker(
              selectedDate: DateTime(year - 10),
              firstDate: DateTime(year - 10),
              lastDate: DateTime(year + 10),
              onChanged: (value) {
                setState(() {
                  yController.text = value.toString().substring(0, 4);
                  yearText = yController.text;
                  print(yearText);
                  Navigator.of(context).pop();
                });
              },
            ),
          ),
        );
      },
    );
  }

  @override
  void initState() {
    // TODO: implement initState

    yearText = DateTime.now().year.toString();
    count = int.parse(emotionDate[0]["year_count"]) +
        int.parse(emotionDate[1]["year_count"]) +
        int.parse(emotionDate[2]["year_count"]) +
        int.parse(emotionDate[3]["year_count"]) +
        int.parse(emotionDate[4]["year_count"]);
  }

  @override
  Widget build(BuildContext context) {
    final styleModel = StyleModel(context);
    _styleModel = styleModel;

    final List<ChartData> chartData = [
      ChartData('blue', 10, styleModel.getBackgroundColor()["backgroundColor2"]),
      ChartData('unknown', 2, styleModel.getBackgroundColor()["backgroundColor3"]),
      ChartData('happy', 20, styleModel.getBackgroundColor()["backgroundColor4"]),
      ChartData('mood', 2, styleModel.getBackgroundColor()["backgroundColor6"]),
      ChartData('angry', 8, styleModel.getBackgroundColor()["backgroundColor5"]),
    ];

    return Scaffold(
      backgroundColor: styleModel.getBackgroundColor()['homeBackgroundColor1'],
      body: Container(
        height: MediaQuery.of(context).size.height,
        child: Center(
          child: Column(
            children: [
              Card(
                child: Container(
                  height: styleModel.getContextSize()["screenHeightLevel8"],
                  width: MediaQuery.of(context).size.width * 1,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Padding(
                        padding: const EdgeInsets.fromLTRB(0, 30, 10, 0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            FlatButton(
                              child: Text(
                                "$yearText년",
                                style:
                                    styleModel.getTextStyle()["infoTextStyle1"],
                              ),
                              onPressed: yearPicker,
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(0, 0, 10, 0),
                        child: Text(
                          "삭님의 일기분석",
                          style: styleModel.getTextStyle()["infoTextStyle2"],
                        ),
                      ),
                    ],
                  ),
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(40),
                ),
                elevation: 1,
              ),
              Container(
                height: styleModel.getContextSize()["screenHeightLevel3"],
                width: MediaQuery.of(context).size.width * 1,
                child: ListView(
                  children: [
                    //수정할 부분
                    Center(
                        child: Container(
                            child: Text(
                      "행복한 일이 많군요!",
                      style: styleModel.getTextStyle()["bodyTextStyle1"],
                    ))),
                    Container(
                        height:
                            styleModel.getContextSize()["screenHeightLevel7"],
                        child: SfCircularChart(
                            legend: Legend(
                                isVisible: true,
                                overflowMode: LegendItemOverflowMode.wrap),
                            series: <CircularSeries>[
                              // Render pie chart
                              PieSeries<ChartData, String>(
                                dataSource: chartData,
                                pointColorMapper: (ChartData data, _) =>
                                    data.color,
                                xValueMapper: (ChartData data, _) => data.x,
                                yValueMapper: (ChartData data, _) => data.y,
                              )
                            ])),

                    Divider(),
                    Container(
                      child: Column(
                        children: [
                          Text(
                            "일기 현황",
                            style: styleModel.getTextStyle()["infoTextStyle3"],
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Text(
                            "$count 번의 일기를 작성하셨어요!",
                            style: styleModel.getTextStyle()["infoTextStyle4"],
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          containerChart(
                              int.parse(emotionDate[0]["year_count"]),
                              count,
                              emotionDate[0]["emotion_type"],
                              emotionDate[0]["color"]),
                          containerChart(
                              int.parse(emotionDate[1]["year_count"]),
                              count,
                              emotionDate[1]["emotion_type"],
                              emotionDate[1]["color"]),
                          containerChart(
                              int.parse(emotionDate[2]["year_count"]),
                              count,
                              emotionDate[2]["emotion_type"],
                              emotionDate[2]["color"]),
                          containerChart(
                              int.parse(emotionDate[3]["year_count"]),
                              count,
                              emotionDate[3]["emotion_type"],
                              emotionDate[3]["color"]),
                          containerChart(
                              int.parse(emotionDate[4]["year_count"]),
                              count,
                              emotionDate[4]["emotion_type"],
                              emotionDate[4]["color"]),
                          Divider(),
                        ],
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Container containerChart(int count, int allCount, String name, String color) {
    return Container(
      height: 50,
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Row(
          children: [
            Container(
              width: MediaQuery.of(context).size.width * 0.18,
              child: Center(
                  child: Text(
                name,
                style: _styleModel.getTextStyle()["infoTextStyle5"],
              )),
            ),
            Container(
              width:
                  MediaQuery.of(context).size.width * 0.64 * (count / allCount),
              decoration: BoxDecoration(
                color: _styleModel.getBackgroundColor()[color],
                borderRadius: BorderRadius.only(
                    topRight: Radius.circular(30),
                    bottomRight: Radius.circular(30)),
              ),
            ),
            Container(
              width: MediaQuery.of(context).size.width * 0.18,
              child: Center(
                  child: Text(
                "$count",
                style: _styleModel.getTextStyle()["infoTextStyle5"],
              )),
            ),
          ],
        ),
      ),
    );
  }
}
