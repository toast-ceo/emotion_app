import 'package:emotion_new_diary/model/style.dart';
import 'package:flutter/material.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _idController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool action = false;
  bool action1 = false;

  @override
  Widget build(BuildContext context) {
    StyleModel styleModel = StyleModel(context);
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: styleModel.getContextSize()['screenWidthLevel2'],
              child: Padding(
                padding: const EdgeInsets.fromLTRB(0, 10, 0, 10),
                child: TextFormField(
                  controller: _idController,
                  decoration: InputDecoration(
                    labelText: "아이디 입력",
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
                      if (value.isEmpty) {
                        action = false;
                      } else {
                        action = true;
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
                  controller: _passwordController,
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
                      if (value.isEmpty) {
                        action1 = false;
                      } else {
                        action1 = true;
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
                      styleModel.getBackgroundColor()['backgroundColor2'],
                      styleModel.getBackgroundColor()['backgroundColor3'],
                      styleModel.getBackgroundColor()['backgroundColor4'],
                      styleModel.getBackgroundColor()['backgroundColor5'],
                      styleModel.getBackgroundColor()['backgroundColor6'],
                    ],
                  ),
                ),
                child: action1 &&action
                    ? FlatButton(
                        child: Text(
                          'Login',
                          style: styleModel.getTextStyle()['titleTextStyle'],
                        ),
                        onPressed: () {
                          Navigator.pushReplacementNamed(context, '/home');
                        },
                      )
                    : Container(
                        color: Colors.grey[200],
                        child: Center(
                            child: Text(
                          'Login',
                          style: styleModel.getTextStyle()['titleTextStyle'],
                        )),
                      ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
