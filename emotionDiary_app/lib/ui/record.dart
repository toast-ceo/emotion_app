import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:odd_app/models/provider.dart';
import 'package:provider/provider.dart';

class RecordPage extends StatefulWidget {
  @override
  _RecordPageState createState() => _RecordPageState();
}

class _RecordPageState extends State<RecordPage> {
  //bool textCheck = false;
  int argumentIndex = 0;
  int index = 0;
  List<Map<String, dynamic>> images = [
    {
      'image': 'happy',
      'status': false,
      'color': Colors.yellow[100],
      'emotion': '행복했던',
      'emotionState': 'happyState'
    },
    {
      'image': 'blue',
      'status': false,
      'color': Colors.blue[100],
      'emotion': '우울했던',
      'emotionState': 'blueState'
    },
    {
      'image': 'unknown',
      'status': false,
      'color': Colors.grey[100],
      'emotion': '알 수 없는',
      'emotionState': 'unknownState'
    },
    {
      'image': 'mood',
      'status': false,
      'color': Colors.purple[100],
      'emotion': '감성충만했던',
      'emotionState': 'moodState'
    },
    {
      'image': 'angry',
      'status': false,
      'color': Colors.red[100],
      'emotion': '화가 났던',
      'emotionState': 'angryState'
    },
  ];

  @override
  Widget build(BuildContext context) {
    Products userdata = Provider.of<Products>(context);
    String sex = userdata.sex;

    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      appBar: AppBar(
          toolbarHeight: 30,
          backgroundColor: Colors.white,
          elevation: 0.0,
          leading: IconButton(
            icon: Icon(
              Icons.arrow_back,
              color: Colors.grey,
            ),
            onPressed: () {
              Navigator.pushReplacementNamed(context, "/menu");
            },
          )),
      body: Padding(
        padding: const EdgeInsets.all(30.0),
        child: ListView(
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                Container(
                  width: MediaQuery.of(context).size.width,
                  height: 2,
                  color: Colors.grey,
                ),
                SizedBox(height: 50),
                Center(
                    child: Text(
                  'What Is Your Color?',
                  style: TextStyle(fontSize: 40, fontWeight: FontWeight.w100),
                )),
                SizedBox(height: 70),
                SizedBox(
                  child: InkWell(
                    child: Card(
                      elevation: 2.4,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(12))),
                      child: Container(
                        height: 260.0,
                        width: 230,
                        decoration: BoxDecoration(
                          color:images[index]['color'],
                          borderRadius:
                          BorderRadius.all(Radius.circular(12.0)),),
                        child: Column(
                          children: <Widget>[
                            SizedBox(
                              height: 30.0,
                            ),
                            Container(
                              width: 120.0,
                              height: 120.0,
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(16.0)),
                                image: DecorationImage(
                                  alignment: Alignment.center,
                                  image: AssetImage(
                                    "images/${images[index]['image']}$sex.png",
                                  ),
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ), 
                            Container(
                              height: 90.0,
                              alignment: Alignment.center,
                              child: Text(
                                "${images[index]['image']}",
                                style: TextStyle(fontSize: 30),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    onTap: () {
                      setState(() {
                        if (index < 4) {
                          index++;
                          argumentIndex = index;
                        } else {
                          index = 0;
                          argumentIndex = index;
                        }
                      });
                    },
                  ),
                ),
                SizedBox(height: 100),
                InkWell(
                  child: Text(
                    'Next',
                    style: TextStyle(fontSize: 30, fontWeight: FontWeight.w300),
                  ),
                  onTap: () => Navigator.of(context).pushReplacementNamed(
                      '/record2',
                      arguments: images[argumentIndex]),
                ),
                SizedBox(height: 100),
                Container(
                  width: MediaQuery.of(context).size.width,
                  height: 2,
                  color: Colors.grey,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

/*
child: ListView.builder(
                    itemCount: 5,
                    itemBuilder: (context, index) {
                      return InkWell(
                        onTap: () {
                          setState(() {
                            if (images[index]['status'] == true) {
                              images[index]['status'] = false;
                              textCheck = false;
                            } else {
                              for (int a = 0; a < 5; a++) {
                                images[a]['status'] = false;
                              }
                              images[index]['status'] = true;
                              textCheck = true;
                              argumentIndex = index;
                            }
                          });
                        },
                        child: images[index]['status']
                            ? Card(
                                elevation: 0,
                                color: images[index]['color'],
                                child: Container(
                                  height: 250.0,
                                  width: 200.0,
                                  alignment: Alignment.center,
                                  child: Column(
                                    children: <Widget>[
                                      SizedBox(
                                        height: 30.0,
                                      ),
                                      Container(
                                        width: 120.0,
                                        height: 120.0,
                                        alignment: Alignment.center,
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(16.0)),
                                          image: DecorationImage(
                                            alignment: Alignment.center,
                                            image: AssetImage(
                                              "images/${images[index]['image']}Girl.png",
                                            ),
                                            fit: BoxFit.cover,
                                          ),
                                        ),
                                      ),
                                      Container(
                                        height: 90.0,
                                        alignment: Alignment.center,
                                        child: Text(
                                          "${images[index]['image']}",
                                          style: TextStyle(fontSize: 30),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              )
                            : Card(
                                elevation: 0,
                                child: Container(
                                  height: 250.0,
                                  width: 200.0,
                                  alignment: Alignment.center,
                                  child: Column(
                                    children: [
                                      SizedBox(
                                        height: 30.0,
                                      ),
                                      Container(
                                        width: 120.0,
                                        height: 120.0,
                                        alignment: Alignment.center,
                                        decoration: BoxDecoration(
                                          image: DecorationImage(
                                            alignment: Alignment.center,
                                            image: AssetImage(
                                              "images/${images[index]['image']}Girl.png",
                                            ),
                                            fit: BoxFit.cover,
                                          ),
                                        ),
                                      ),
                                      Container(
                                        height: 90.0,
                                        alignment: Alignment.center,
                                        child: Text("${images[index]['image']}",
                                            style: TextStyle(fontSize: 25)),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                      );
                    },
                  ),
                  */
