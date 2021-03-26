import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:odd_app/models/provider.dart';
import 'package:provider/provider.dart';


class SecondRecordPage extends StatefulWidget {
  @override
  _SecondRecordPageState createState() => _SecondRecordPageState();
}

class _SecondRecordPageState extends State<SecondRecordPage> {
  final TextEditingController _contentController = TextEditingController();
  final TextEditingController _titleCotroller = TextEditingController();
  final FocusNode _titleFocus = FocusNode();
  final FocusNode _contentFocus = FocusNode();
  bool titleCheck = false;
  bool contentCheck = false;
  DateTime todaynow = DateTime.now();

  Widget build(BuildContext context) {
    String now = DateFormat('yyyy.MM.dd').format(todaynow);
    String todayData = DateFormat('yyyyMMdd').format(todaynow);
    final Map args = ModalRoute.of(context).settings.arguments;
    Products userdata = Provider.of<Products>(context);

    return Scaffold(
      backgroundColor: args['color'],
      appBar: AppBar(
          toolbarHeight: 30,
          backgroundColor: args['color'],
          elevation: 0.0,
          leading: IconButton(
            icon: Icon(
              Icons.arrow_back,
              color: Colors.grey,
            ),
            onPressed: () {
              Navigator.pushReplacementNamed(context, "/record");
            },
          )),
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: ListView(
          children: [
            Card(
              elevation: 0,
              shape: BeveledRectangleBorder(
                borderRadius: BorderRadius.circular(2.0),
              ),
              child: Padding(
                padding: const EdgeInsets.only(
                    left: 12, bottom: 20, top: 30, right: 12),
                child: Column(
                  children: <Widget>[
                    Container(
                      width: MediaQuery.of(context).size.width,
                      height: 2,
                      color: Colors.grey,
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Text(
                      '$now',
                      style:
                          TextStyle(fontSize: 40, fontWeight: FontWeight.w300),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          '${args['emotion']} 하루',
                          style: TextStyle(
                            fontFamily: 'NanumPenScript',
                            fontSize: 22,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width,
                      height: 2,
                      color: Colors.grey,
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    TextFormField(
                      controller: _titleCotroller,
                      cursorColor: Colors.grey,
                      textAlign: TextAlign.center,
                      maxLength: 15,
                      maxLines: 1,
                      textInputAction: TextInputAction.next,
                      focusNode: _titleFocus,
                      onFieldSubmitted: (term) {
                        _fieldFocusChange(context, _titleFocus, _contentFocus);
                      },
                      decoration: InputDecoration(
                          border: InputBorder.none,
                          contentPadding: EdgeInsets.only(
                              left: 10, bottom: 10, top: 10, right: 10),
                          hintText: "Title",
                          hintStyle: TextStyle(fontSize: 20, letterSpacing: 2),
                        counterStyle: TextStyle(fontSize: 12,  fontFamily: 'NanumMeongjo',)
                      ),
                      style: TextStyle(
                        fontSize: 22,
                        fontFamily: 'NanumPenScript',
                      ),
                      onChanged: (value){
                        setState(() {
                          if(value.length< 16&&value.isNotEmpty){
                            titleCheck = true;
                          }else{
                            titleCheck = false;
                          }
                        });
                      },
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width,
                      height: 2,
                      color: Colors.grey,
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    TextFormField(
                      controller: _contentController,
                      cursorColor: Colors.grey,
                      textAlign: TextAlign.center,
                      minLines: 15,
                      maxLines: 20,
                      keyboardType: TextInputType.multiline,
                      focusNode: _contentFocus,
                      textInputAction: TextInputAction.done,
                      decoration: InputDecoration(
                          border: InputBorder.none,
                          contentPadding: EdgeInsets.only(
                              left: 10, bottom: 10, top: 10, right: 10),
                          hintText: "Content",
                          hintStyle: TextStyle(fontSize: 22, letterSpacing: 2)),
                      style: TextStyle(
                        fontSize: 22,
                        fontFamily: 'NanumPenScript',
                      ),
                      onChanged: (value){
                        setState(() {
                          if(value.isNotEmpty){
                            contentCheck = true;
                          }else{
                            contentCheck = false;
                          }
                        });
                      },
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width,
                      height: 2,
                      color: Colors.grey,
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    titleCheck&&contentCheck ? InkWell(
                      child: Text(
                        'Done',
                        style: TextStyle(
                            fontSize: 25, fontWeight: FontWeight.w300),
                      ),
                      onTap: () {
                        Map<String, dynamic> data = {
                          "user_id": "YONGKI",
                          'date': todayData,
                          'title': _titleCotroller.text,
                          'content': _contentController.text,
                          'image': args['image'],
                        };
                        userdata.addText(data);
                       Navigator.pushReplacementNamed(context, '/menu');
                        // Navigator.of(context)
                        //   .pushReplacementNamed('/start');
                      },
                    ): Text(
                      'Done',
                      style: TextStyle(
                          fontSize: 25, fontWeight: FontWeight.w300,color: Colors.grey),
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width,
                      height: 2,
                      color: Colors.grey,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  _fieldFocusChange(
      BuildContext context, FocusNode currentFocus, FocusNode nextFocus) {
    currentFocus.unfocus();
    FocusScope.of(context).requestFocus(nextFocus);
  }
}
