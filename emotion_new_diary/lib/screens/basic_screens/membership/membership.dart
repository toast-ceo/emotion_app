import 'package:emotion_new_diary/api/api.dart';
import 'package:emotion_new_diary/model/style.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
import 'package:flutter/widgets.dart';

class Membership extends StatefulWidget {
  @override
  _MembershipState createState() => _MembershipState();
}

class _MembershipState extends State<Membership> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _idController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _checkPasswordController =
      TextEditingController();
  final scaffoldKey = GlobalKey<ScaffoldState>();

  bool action0 = false;
  bool action1 = false;
  bool action2 = false;
  bool action3 = false;

  StyleModel _styleModel;
  Api _api;

  @override
  Widget build(BuildContext context) {
    StyleModel styleModel = StyleModel(context);
    _styleModel = styleModel;
    Api api = Provider.of<Api>(context, listen: false);
    _api = api;
    return Scaffold(
        resizeToAvoidBottomInset: false,
        key: scaffoldKey,
        backgroundColor: styleModel.getBackgroundColor()['backgroundColor1'],
        appBar: AppBar(
            backgroundColor:
                styleModel.getBackgroundColor()['backgroundColor1'],
            toolbarHeight: 40,
            elevation: 0.0,
            leading: IconButton(
              icon: Icon(
                Icons.arrow_back,
                color: Colors.grey,
              ),
              onPressed: () {
                Navigator.pushReplacementNamed(context, "/login");
              },
            )),
        body: Builder(
          builder: (BuildContext context) {
            return Center(
              child: Column(
                children: [
                  SizedBox(
                    height: styleModel.getContextSize()['screenHeightLevel9'],
                  ),
                  Container(
                    child: Text(
                      "회원 가입",
                      style: styleModel.getTextStyle()['MembershipTextStyle1'],
                    ),
                  ),
                  Container(
                    child: Text(
                      "\n비밀번호는 8자리 이상으로 작성",
                      style: styleModel.getTextStyle()['MembershipTextStyle2'],
                    ),
                  ),
                  SizedBox(
                    height: styleModel.getContextSize()['screenHeightLevel9'],
                  ),
                  Container(
                    width: styleModel.getContextSize()['screenWidthLevel2'],
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(0, 10, 0, 10),
                      child: TextFormField(
                        style: styleModel.getTextStyle()['LoginTextStyle2'],
                        keyboardType: TextInputType.emailAddress,
                        controller: _emailController,
                        decoration: InputDecoration(
                          labelText: "이메일 입력",
                          labelStyle: TextStyle(
                            color: Colors.grey,
                          ),
                          border: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Colors.black,
                            ),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Colors.black,
                            ),
                          ),
                          suffixIcon: IconButton(
                            onPressed: () => _emailController.clear(),
                            color: Colors.grey,
                            icon: Icon(Icons.clear),
                          ),
                        ),
                        onChanged: (value) {
                          setState(() {
                            if (value.isNotEmpty) {
                              action0 = true;
                            } else {
                              action0 = false;
                            }
                          });
                        },
                      ),
                    ),
                  ),
                  Container(
                    width: styleModel.getContextSize()['screenWidthLevel2'],
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(0, 10, 0, 10),
                      child: TextFormField(
                        style: styleModel.getTextStyle()['LoginTextStyle2'],
                        controller: _idController,
                        decoration: InputDecoration(
                          labelText: "닉네임 입력",
                          labelStyle: TextStyle(
                            color: Colors.grey,
                          ),
                          border: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Colors.black,
                            ),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Colors.black,
                            ),
                          ),
                          suffixIcon: IconButton(
                            onPressed: () => _idController.clear(),
                            color: Colors.grey,
                            icon: Icon(Icons.clear),
                          ),
                        ),
                        onChanged: (value) {
                          setState(() {
                            if (value.isNotEmpty) {
                              action1 = true;
                            } else {
                              action1 = false;
                            }
                          });
                        },
                      ),
                    ),
                  ),
                  Container(
                    width: styleModel.getContextSize()['screenWidthLevel2'],
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(0, 10, 0, 10),
                      child: TextFormField(
                        style: styleModel.getTextStyle()['LoginTextStyle2'],
                        controller: _passwordController,
                        obscureText: true,
                        decoration: InputDecoration(
                          labelText: "비밀번호 입력",
                          labelStyle: TextStyle(
                            color: Colors.grey,
                          ),
                          border: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Colors.black,
                            ),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Colors.black,
                            ),
                          ),
                          suffixIcon: IconButton(
                            onPressed: () => _passwordController.clear(),
                            color: Colors.grey,
                            icon: Icon(Icons.clear),
                          ),
                        ),
                        onChanged: (value) {
                          setState(() {
                            if (value.length > 7) {
                              action2 = true;
                            } else {
                              action2 = false;
                            }
                          });
                        },
                      ),
                    ),
                  ),
                  Container(
                    width: styleModel.getContextSize()['screenWidthLevel2'],
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(0, 10, 0, 10),
                      child: TextFormField(
                        style: styleModel.getTextStyle()['LoginTextStyle2'],
                        controller: _checkPasswordController,
                        obscureText: true,
                        decoration: InputDecoration(
                          labelText: "비밀번호 확인",
                          labelStyle: TextStyle(
                            color: Colors.grey,
                          ),
                          border: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Colors.black,
                            ),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Colors.black,
                            ),
                          ),
                          suffixIcon: IconButton(
                            onPressed: () => _checkPasswordController.clear(),
                            color: Colors.grey,
                            icon: Icon(Icons.clear),
                          ),
                        ),
                        onChanged: (value) {
                          setState(() {
                            if (value.toString() ==
                                _checkPasswordController.text) {
                              action3 = true;
                            } else {
                              action3 = false;
                            }
                          });
                        },
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      width: styleModel.getContextSize()['screenWidthLevel2'],
                      height: 60,
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
                      child: action0 && action1 && action2 && action3
                          ? InkWell(
                              child: Container(
                                decoration: BoxDecoration(
                                  gradient: LinearGradient(
                                    begin: Alignment.topLeft,
                                    end: Alignment.bottomRight,
                                    colors: <Color>[
                                      styleModel.getBackgroundColor()[
                                          'backgroundColor5'],
                                      styleModel.getBackgroundColor()[
                                          'backgroundColor2'],
                                      styleModel.getBackgroundColor()[
                                          'backgroundColor3'],
                                      styleModel.getBackgroundColor()[
                                          'backgroundColor4'],
                                      styleModel.getBackgroundColor()[
                                          'backgroundColor6'],
                                    ],
                                  ),
                                ),
                                child: Center(
                                    child: Text(
                                  '회원가입',
                                  style: styleModel
                                      .getTextStyle()['titleTextStyle1'],
                                )),
                              ),
                              onTap: () {
                                Map<String, dynamic> data = {
                                  "name": _idController.text,
                                  "email": _emailController.text,
                                  "password": _passwordController.text,
                                };
                                checkDialog(data);

                                // api.membershipApi(data);
                                // Navigator.pushReplacementNamed(context, '/login');
                              },
                            )
                          : Container(
                              color: Colors.grey[200],
                              child: Center(
                                  child: Text(
                                '회원가입',
                                style: styleModel
                                    .getTextStyle()['titleTextStyle1'],
                              )),
                            ),
                    ),
                  ),
                ],
              ),
            );
          },
        ));
  }

  void checkDialog(Map data) {
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return AlertDialog(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0)),
            title: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                new Text(
                  "입력 정보",
                  style: _styleModel.getTextStyle()['AlertTextStyle1'],
                ),
              ],
            ),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.all(5.0),
                  child: new Text(
                    "이메일 : ${data["email"]}",
                    style: _styleModel.getTextStyle()['AlertTextStyle3'],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(5.0),
                  child: new Text(
                    "닉네임 : ${data["name"]}",
                    style: _styleModel.getTextStyle()['AlertTextStyle3'],
                  ),
                ),
              ],
            ),
            actions: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: new InkWell(
                      child: new Text(
                        "취소",
                        style: _styleModel.getTextStyle()['AlertTextStyle2'],
                      ),
                      onTap: () {
                        Navigator.pop(context);
                      },
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: new InkWell(
                      child: new Text(
                        "확인",
                        style: _styleModel.getTextStyle()['AlertTextStyle2'],
                      ),
                      onTap: () {
                        int temp;
                        setState(() {
                          _api.membershipApi(data);
                          temp = _api.membershipTemp;
                          if (temp == 200) {
                            SnackbarManager.showSnackBar(
                                scaffoldKey, "회원가입이 되었습니다!");
                            Navigator.pushReplacementNamed(context, '/login');
                          } else if (temp == 409) {
                            SnackbarManager.showSnackBar(
                                scaffoldKey, "중복된 아이디입니다.");
                            Navigator.pop(context);
                          } else {
                            SnackbarManager.showSnackBar(
                                scaffoldKey, "양식이 틀렸습니다.");
                            Navigator.pop(context);
                          }
                        });
                      },
                    ),
                  ),
                ],
              ),
            ],
          );
        });
  }
}

class SnackbarManager {
  static void showSnackBar(
      GlobalKey<ScaffoldState> scaffoldKey, String message) {
    scaffoldKey.currentState.showSnackBar(SnackBar(content: Text(message)));
  }
}
