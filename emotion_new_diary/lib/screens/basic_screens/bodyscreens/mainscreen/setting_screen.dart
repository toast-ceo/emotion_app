import 'package:emotion_new_diary/model/style.dart';
import 'package:flutter/material.dart';

class SettingScreen extends StatefulWidget {
  @override
  _SettingScreenState createState() => _SettingScreenState();
}

/// 1. 로그아웃
/// 2. 개발자들
/// 3. 오픈소스 라이센스
/// 4. (보류) 알람 설정
class _SettingScreenState extends State<SettingScreen> {
  @override
  Widget build(BuildContext context) {
    StyleModel styleModel = new StyleModel(context);
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
          child: ListView(
        children: [
          Container(
            height: styleModel.getContextSize()['screenWidthLevel8'],
            child: Center(
              child: Text("이모저모", style: styleModel.getTextStyle()['SettingTextStyle3'],),

            ),
          ),
          Card(
            child: Container(
              height: styleModel.getContextSize()['screenWidthLevel8.5'],
              width: MediaQuery.of(context).size.width * 1,
              child: Padding(
                padding: const EdgeInsets.fromLTRB(20, 0 , 20, 0),
                child: Stack(
                  children: [
                    Center(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                        Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text("계정 관리", style: styleModel.getTextStyle()['SettingTextStyle1'],),
                          )
                        ],
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Center(
                          child: InkWell(
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text("로그아웃 하기 :)", style: styleModel.getTextStyle()['SettingTextStyle2'],),
                            ),
                            onTap: () => Navigator.pushReplacementNamed(context, '/login'),
                          ),
                        )
                      ],
                    ),
                  ],
                ),
              ),
            ),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(5),
            ),
            elevation: 0,
          ),
          SizedBox(height: 5,),
          Card(
            child: Container(
              height: styleModel.getContextSize()['screenWidthLevel8.5'],
              width: MediaQuery.of(context).size.width * 1,
              child: Padding(
                padding: const EdgeInsets.fromLTRB(20, 0 , 20, 0),
                child: Stack(
                  children: [
                    Center(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text("개발자들", style: styleModel.getTextStyle()['SettingTextStyle1'],),
                          )
                        ],
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Center(
                          child: InkWell(
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text("구경하러 가기 :)", style: styleModel.getTextStyle()['SettingTextStyle2'],),
                            ),
                            onTap: () => Navigator.pushReplacementNamed(context, '/login'),
                          ),
                        )
                      ],
                    ),
                  ],
                ),
              ),
            ),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            elevation: 0,
          ),
          SizedBox(height: 5,),
          Card(
            child: Container(
              height: styleModel.getContextSize()['screenWidthLevel8.5'],
              width: MediaQuery.of(context).size.width * 1,
              child: Padding(
                padding: const EdgeInsets.fromLTRB(20, 0 , 20, 0),
                child: Stack(
                  children: [
                    Center(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text("개발 현황", style: styleModel.getTextStyle()['SettingTextStyle1'],),
                          )
                        ],
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Center(
                          child: InkWell(
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text("보러 가기 :)", style: styleModel.getTextStyle()['SettingTextStyle2'],),
                            ),
                            onTap: () => Navigator.pushReplacementNamed(context, '/login'),
                          ),
                        )
                      ],
                    ),
                  ],
                ),
              ),
            ),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            elevation: 0,
          ),
        ],
      )),
    );
  }
}
