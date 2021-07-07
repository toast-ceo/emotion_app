import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:odd_app/models/provider.dart';
import 'package:provider/provider.dart';

class SecondRemindPage extends StatefulWidget {
  @override
  _SecondRemindPageState createState() => _SecondRemindPageState();
}

class _SecondRemindPageState extends State<SecondRemindPage> {
  List userListData = [];
  String selectedItem = 'all';
  String sex;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Products userdata = Provider.of<Products>(context, listen: false);
    List userKeyData = userdata.userAllData.keys.toList();
    sex = userdata.sex;
    for (int a = 0; a < userdata.userAllData.keys.length; a++) {
      for (int b = 0; b < userdata.userAllData[userKeyData[a]].length; b++) {
        userListData.add(userdata.userAllData[userKeyData[a]][b]);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    List _options = ['all','happy', 'blue', 'unknown', 'mood', 'angry'];

    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      appBar: AppBar(
        toolbarHeight: 50,
        backgroundColor: Colors.white,
        elevation: 0.0,
        title: Text(
          "Emotions",
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
          PopupMenuButton(
              icon: Icon(
                Icons.format_list_bulleted,
                size: 28,
                color: Colors.grey,
              ),
              itemBuilder: (BuildContext bc) {
                return _options
                    .map((emotion) => PopupMenuItem(
                          child: Text(
                            emotion,
                            style: TextStyle(fontSize: 25),
                          ),
                          value: emotion,
                        ))
                    .toList();
              },
              onSelected: (value) {
                setState(() {
                  selectedItem = value;
                  print(selectedItem);
                });
              }),
          IconButton(
            icon: Icon(
              Icons.calendar_today_outlined,
              size: 30,
              color: HexColor("#4F8FA8"),
            ),
            onPressed: () {
              print(userListData);
              Navigator.pushReplacementNamed(context, "/remind");
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: ListView.builder(
          itemCount: userListData.length,
          itemBuilder: (context, index) {
            print(selectedItem);
            return userListData[index]['image'] == selectedItem || selectedItem =='all'
                ? Container(
                    decoration: BoxDecoration(
                      border: Border.all(width: 0.8),
                    ),
                    margin: const EdgeInsets.symmetric(
                        vertical: 10.0, horizontal: 2),
                    child: Row(
                      children: [
                        FlatButton(
                          child: Container(
                            child: Row(
                              children: <Widget>[
                                Container(
                                  width:
                                      MediaQuery.of(context).size.width * 0.22,
                                  height:
                                      MediaQuery.of(context).size.width * 0.22,
                                  alignment: Alignment.center,
                                  child: Container(
                                    width: 80,
                                    height: 80,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(2.0)),
                                      image: DecorationImage(
                                        alignment: Alignment.center,
                                        image: AssetImage(
                                          "images/${userListData[index]['image']}$sex.png",
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
                                  width:
                                      MediaQuery.of(context).size.width * 0.47,
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: <Widget>[
                                      Text(
                                        "${userListData[index]['title']}",
                                        style: TextStyle(
                                            fontSize: 28,
                                            color: Colors.black,
                                            fontFamily: "NanumPenScript"),
                                      ),
                                      SizedBox(
                                        height: 10,
                                      ),
                                      Text(
                                        "${userListData[index]['date']}",
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
                            print(userListData[index]['emotionState'] == selectedItem);
                            Navigator.pushReplacementNamed(
                                context, "/todayDiary",
                                arguments: userListData[index]);
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
                                      context, index, userListData[index]);
                                }),
                          ],
                        )
                      ],
                    ),
                  )
                : Container();
          },
        ),
      ),
    );
  }

  void cancelCheckDialog(BuildContext context, int removeIndex, var removeData) {
    Products userdata = Provider.of<Products>(context, listen: false);
    print(removeData);

    showDialog(
        context: context,
        //barrierDismissible - Dialog를 제외한 다른 화면 터치 x
        barrierDismissible: false,
        builder: (BuildContext context) {
          return AlertDialog(
            // RoundedRectangleBorder - Dialog 화면 모서리 둥글게 조절
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0)),
            title: Column(
              children: <Widget>[
                new Text(
                  "삭제",
                  style: TextStyle(fontSize: 30, fontFamily: "NanumPenScript"),
                ),
              ],
            ),
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
            actions: <Widget>[Row(
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
                        userdata.removeText(removeData);
                      });
                      Navigator.of(context).pushReplacementNamed('/menu');
                    },
                  ),
                ],
              ),],
          );
        });
  }
}

///IconButton(
//             icon: Icon(
//               Icons.format_list_bulleted,
//               size: 28,
//               color: Colors.grey,
//             ),
//             onPressed: () {
