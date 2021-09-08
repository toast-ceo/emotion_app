import 'package:emotion_new_diary/api/api.dart';
import 'package:emotion_new_diary/model/chartData.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:emotion_new_diary/model/style.dart';
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
  final List<ChartData> chartData = [];

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
    super.initState();
    yearText = DateTime.now().year.toString();
  }

  @override
  Widget build(BuildContext context) {
    Api api = Provider.of(context);
    final styleModel = StyleModel(context);
    _styleModel = styleModel;


    return FutureBuilder(
      future: api.fetchPostInfo(yearText),
      builder: (BuildContext context, AsyncSnapshot snapshot) {

        //총 일기 카운트
        count = snapshot.data[0]["year_count"] +
            snapshot.data[1]["year_count"] +
            snapshot.data[2]["year_count"] +
            snapshot.data[3]["year_count"] +
            snapshot.data[4]["year_count"];

        //ChartData 리스트에 변수를 넣어주는 부분
        for(int a = 0; a<5; a++){
          chartData.add(ChartData(
              snapshot.data[a]["emotion_type"],
              double.parse(snapshot.data[a]["year_count"].toString()),
              styleModel.getBackgroundColor()[snapshot.data[a]["color"]]));
        }


        if (snapshot.hasData) {
          return Container(
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
                              "삭님의 일기분석",
                              style:
                                  styleModel.getTextStyle()["infoTextStyle2"],
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
                            height: styleModel
                                .getContextSize()["screenHeightLevel7"],
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
                                style:
                                    styleModel.getTextStyle()["infoTextStyle3"],
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Text(
                                "$count 번의 일기를 작성하셨어요!",
                                style:
                                    styleModel.getTextStyle()["infoTextStyle4"],
                              ),
                              SizedBox(
                                height: 20,
                              ),
                              containerChart(
                                  snapshot.data[0]["year_count"],
                                  count,
                                  snapshot.data[0]["emotion_type"],
                                  snapshot.data[0]["color"]),
                              containerChart(
                                  snapshot.data[1]["year_count"],
                                  count,
                                  snapshot.data[1]["emotion_type"],
                                  snapshot.data[1]["color"]),
                              containerChart(
                                  snapshot.data[2]["year_count"],
                                  count,
                                  snapshot.data[2]["emotion_type"],
                                  snapshot.data[2]["color"]),
                              containerChart(
                                  snapshot.data[3]["year_count"],
                                  count,
                                  snapshot.data[3]["emotion_type"],
                                  snapshot.data[3]["color"]),
                              containerChart(
                                  snapshot.data[4]["year_count"],
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
          );
        }
        else {return Center(child: CircularProgressIndicator());}
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
