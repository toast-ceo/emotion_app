import 'package:emotion_new_diary/api/api.dart';
import 'package:emotion_new_diary/model/chartData.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:emotion_new_diary/model/style.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class InformationScreen extends StatefulWidget {
  @override
  _InformationScreenState createState() => _InformationScreenState();
}

class _InformationScreenState extends State<InformationScreen> {
  int count = 0;
  TextEditingController yController = TextEditingController();
  String yearText;
  var _styleModel;
  List<ChartData> _chartData = [ChartData("Hello", 0, Colors.white)];

  List<ChartData> get chartData => _chartData;
  Api _api;

  Api get api => _api;

  @override
  void initState() {
    super.initState();
    yearText = DateTime.now().year.toString();
  }

  @override
  Widget build(BuildContext context) {
    final styleModel = StyleModel(context);
    _styleModel = styleModel;
    Api api = Provider.of<Api>(context);
    _api = api;

    return FutureBuilder(
      future: api.fetchPostInfo(yearText),
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        if (snapshot.hasData) {
          // print(_api.infoAllNum);
          //ChartData 리스트에 변수를 넣어주는 부분
          _chartData.clear();
          for (int a = 0; a < 5; a++) {
            _chartData.add(ChartData(
                snapshot.data[a]["emotion_type"],
                double.parse(snapshot.data[a]["emotion_count"].toString()),
                styleModel.getBackgroundColor()[snapshot.data[a]["color"]]));

            //총 일기 카운트
            count = _api.infoAllNum;
          }
          return snapshot.connectionState == ConnectionState.done && count != 0
              ? Container(
                  height: MediaQuery.of(context).size.height,
                  width: MediaQuery.of(context).size.width,
                  child: Center(
                    child: Column(
                      children: [
                        Card(
                          child: Container(
                            height: styleModel
                                .getContextSize()["screenHeightLevel8"],
                            width: MediaQuery.of(context).size.width * 1,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                Padding(
                                  padding:
                                      const EdgeInsets.fromLTRB(0, 30, 10, 0),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      FlatButton(
                                        child: Text(
                                          "$yearText년",
                                          style: styleModel
                                              .getTextStyle()["infoTextStyle1"],
                                        ),
                                        onPressed: yearPicker,
                                      ),
                                    ],
                                  ),
                                ),
                                Padding(
                                  padding:
                                      const EdgeInsets.fromLTRB(0, 0, 10, 0),
                                  child: Text(
                                    "${api.userName} 님의 일기분석",
                                    style: styleModel
                                        .getTextStyle()["infoTextStyle2"],
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
                          height:
                              styleModel.getContextSize()["screenHeightLevel3"],
                          width: MediaQuery.of(context).size.width * 1,
                          child: ListView(
                            children: [
                              //수정할 부분
                              Center(
                                  child: Container(
                                      child: Text(
                                "무슨 색이였을까요?",
                                style:
                                    styleModel.getTextStyle()["bodyTextStyle1"],
                              ))),
                              Container(
                                  height: styleModel
                                      .getContextSize()["screenHeightLevel7"],
                                  child: SfCircularChart(
                                      legend: Legend(
                                          isVisible: true,
                                          overflowMode:
                                              LegendItemOverflowMode.wrap),
                                      series: <CircularSeries>[
                                        // Render pie chart
                                        PieSeries<ChartData, String>(
                                          dataSource: chartData,
                                          pointColorMapper:
                                              (ChartData data, _) => data.color,
                                          xValueMapper: (ChartData data, _) =>
                                              data.x,
                                          yValueMapper: (ChartData data, _) =>
                                              data.y,
                                        )
                                      ])),

                              Divider(),
                              Container(
                                child: Column(
                                  children: [
                                    Text(
                                      "일기 현황",
                                      style: styleModel
                                          .getTextStyle()["infoTextStyle3"],
                                    ),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    Text(
                                      "$count 번의 일기를 작성하셨어요!",
                                      style: styleModel
                                          .getTextStyle()["infoTextStyle4"],
                                    ),
                                    SizedBox(
                                      height: 20,
                                    ),
                                    containerChart(
                                        snapshot.data[0]["emotion_count"],
                                        count,
                                        snapshot.data[0]["emotion_type"],
                                        snapshot.data[0]["color"]),
                                    containerChart(
                                        snapshot.data[1]["emotion_count"],
                                        count,
                                        snapshot.data[1]["emotion_type"],
                                        snapshot.data[1]["color"]),
                                    containerChart(
                                        snapshot.data[2]["emotion_count"],
                                        count,
                                        snapshot.data[2]["emotion_type"],
                                        snapshot.data[2]["color"]),
                                    containerChart(
                                        snapshot.data[3]["emotion_count"],
                                        count,
                                        snapshot.data[3]["emotion_type"],
                                        snapshot.data[3]["color"]),
                                    containerChart(
                                        snapshot.data[4]["emotion_count"],
                                        count,
                                        snapshot.data[4]["emotion_type"],
                                        snapshot.data[4]["color"]),
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
                )
              : Container(
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
        } else {
          return Container(
            height: MediaQuery.of(context).size.height,
            child: Center(
              child: Column(children: [
                Card(
                  child: Container(
                    height: MediaQuery.of(context).size.height * 0.2,
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
                                  style: styleModel
                                      .getTextStyle()["infoTextStyle1"],
                                ),
                                onPressed: yearPicker,
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(0, 0, 10, 0),
                          child: Text(
                            "회원 님의 일기분석",
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
                  height: MediaQuery.of(context).size.height * 0.6,
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
                ),
              ]),
            ),
          );
        }
      },
    );
  }

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
                  api.fetchPostInfo(yearText);
                  Navigator.of(context).pop();
                });
              },
            ),
          ),
        );
      },
    );
  }

  Container containerChart(int count, int allCount, String name, String color) {
    return Container(
      height: 50,
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Row(
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(8,0,8,4),
              child: Container(
                width: MediaQuery.of(context).size.width * 0.18,
                child: Center(
                    child: Text(
                  name,
                  style: _styleModel.getTextStyle()["infoTextStyle5"],
                )),
              ),
            ),
            Container(
              width:
                  MediaQuery.of(context).size.width * 0.6 * (count / allCount),
              decoration: BoxDecoration(
                color: _styleModel.getBackgroundColor()[color],
                borderRadius: BorderRadius.only(
                    topRight: Radius.circular(30),
                    bottomRight: Radius.circular(30)),
              ),
            ),
            Container(
              width: MediaQuery.of(context).size.width * 0.12,
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
