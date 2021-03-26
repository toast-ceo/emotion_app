import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:odd_app/models/provider.dart';

class ChangeSex extends StatefulWidget {
  @override
  _ChangeSexState createState() => _ChangeSexState();
}

class _ChangeSexState extends State<ChangeSex> {
  bool checkBoy = false;
  bool checkGirl = false;
  bool finalCheck = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    checkBoy = false;
    checkGirl = false;
    finalCheck = false;
  }

  @override
  Widget build(BuildContext context) {
    Products userdata = Provider.of<Products>(context);

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        toolbarHeight: 40,
        backgroundColor: Colors.white,
        elevation: 0.0,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            color: Colors.grey,
          ),
          onPressed: () {
            print(userdata.fetchPost());
            Navigator.pushReplacementNamed(context, "/start");
          },
        ),
      ),
      body: Center(
        child: Column(
          children: [
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.1,
            ),
            Text(
              "What kind of character",
              style: TextStyle(fontSize: 35),
            ),
            Text(
              "do you want?",
              style: TextStyle(fontSize: 36),
            ),
            SizedBox(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Column(
                  children: [
                    Container(
                      height: 300,
                      width: 150,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          alignment: Alignment.center,
                          image: AssetImage(
                            "images\\selectBoy.jpg",
                          ),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    checkBoy
                        ? Container(
                            child: Text(
                              "Boy",
                              style:
                                  TextStyle(color: Colors.black, fontSize: 30),
                            ),
                          )
                        : InkWell(
                            child: Container(
                              child: Text(
                                "Boy",
                                style:
                                    TextStyle(color: Colors.grey, fontSize: 30),
                              ),
                            ),
                            onTap: () {
                              setState(() {
                                checkBoy = true;
                                checkGirl = false;
                                finalCheck = true;
                              });
                            },
                          ),
                  ],
                ),
                Column(
                  children: [
                    Container(
                      height: 300,
                      width: 150,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          alignment: Alignment.center,
                          image: AssetImage(
                            "images\\selectGirl.jpg",
                          ),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    checkGirl
                        ? Container(
                            child: Text(
                              "Girl",
                              style:
                                  TextStyle(color: Colors.black, fontSize: 30),
                            ),
                          )
                        : InkWell(
                            child: Container(
                              child: Text(
                                "Girl",
                                style:
                                    TextStyle(color: Colors.grey, fontSize: 30),
                              ),
                            ),
                            onTap: () {
                              setState(() {
                                checkBoy = false;
                                checkGirl = true;
                                finalCheck = true;
                              });
                            },
                          ),
                  ],
                ),
              ],
            ),
            SizedBox(
              height: 40,
            ),
            finalCheck
                ? InkWell(
                    child: Container(
                      child: Text(
                        "확인",
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 30,
                          fontFamily: 'NanumPenScript',
                        ),
                      ),
                    ),
                    onTap: () {
                      if(checkGirl == true){
                        userdata.changeSexFun('Girl');
                        Navigator.pushReplacementNamed(context, '/start');
                      } else if(checkBoy == true){
                        userdata.changeSexFun('Boy');
                        Navigator.pushReplacementNamed(context, '/start');
                      }
                    },
                  )
                : Container(
                    child: Text(
                      "확인",
                      style: TextStyle(
                        color: Colors.grey,
                        fontSize: 30,
                        fontFamily: 'NanumPenScript',
                      ),
                    ),
                  ),
          ],
        ),
      ),
    );
  }
}
