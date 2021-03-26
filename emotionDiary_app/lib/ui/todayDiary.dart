import 'package:flutter/material.dart';
import 'package:odd_app/models/provider.dart';
import 'package:provider/provider.dart';

class TodayDiary extends StatefulWidget {
  @override
  _TodayDiaryState createState() => _TodayDiaryState();
}

class _TodayDiaryState extends State<TodayDiary> {
  @override
  Widget build(BuildContext context) {
    final Map args = ModalRoute.of(context).settings.arguments;
    Products userdata = Provider.of<Products>(context);
    String sex = userdata.sex;

    Color nowColor;
    switch (args['image']){
      case 'happy':
        nowColor = Colors.yellow[100];
        break;
      case 'blue':
        nowColor = Colors.blue[100];
        break;
      case 'angry':
        nowColor = Colors.red[100];
        break;
      case 'unknown':
        nowColor = Colors.grey[100];
        break;
      case 'mood':
        nowColor = Colors.purple[100];
        break;
    }
    return Scaffold(
      backgroundColor: nowColor,
      appBar: AppBar(
          toolbarHeight: 40,
          backgroundColor: nowColor,
          elevation: 0.0,
          leading: IconButton(
            icon: Icon(
              Icons.arrow_back,
              color: Colors.grey,
            ),
            onPressed: () {
              Navigator.pushReplacementNamed(context, "/remind");
            },
          )),
      body: ListView(
        children: <Widget>[
          Center(
            child: Container(
              color: Colors.white,
              width: MediaQuery.of(context).size.width * 0.88,
              height: MediaQuery.of(context).size.height * 0.85,
              child: Padding(
                padding: EdgeInsets.fromLTRB(20, 20, 20, 10),
                child: Column(
                  children: <Widget>[
                    SizedBox(
                      height: 30,
                    ),
                    Text(
                      args['title'],
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 32,
                          fontFamily: 'NanumPenScript'),
                    ),
                    SizedBox(height: 50),
                    Container(
                      width: 120.0,
                      height: 120.0,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(16.0)),
                        image: DecorationImage(
                          alignment: Alignment.center,
                          image: AssetImage(
                            "images/${args['image']}$sex.png",
                          ),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    Text(
                      args['content'],
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 24,
                          fontFamily: 'NanumPenScript'),
                    ),
                    SizedBox(
                      height: 30,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
