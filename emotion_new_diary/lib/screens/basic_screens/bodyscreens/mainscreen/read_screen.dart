import 'package:emotion_new_diary/api/api.dart';
import 'package:emotion_new_diary/model/style.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ReadScreen extends StatefulWidget {
  @override
  _ReadScreenState createState() => _ReadScreenState();
}

class _ReadScreenState extends State<ReadScreen> {
  Map<DateTime, List> _events = {};

  @override
  Widget build(BuildContext context) {
    Api api = Provider.of<Api>(context, listen: false);
    final styleModel = StyleModel(context);

    return FutureBuilder(
        future: api.fetchPost(),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.hasData) {
            api.inputData(snapshot.data);
            for (int a = 0; a < api.userAllData.length; a++) {
              _events[DateTime.parse(api.userAllData.keys.toList()[a])] =
                  api.userAllData.values.toList()[a];
              print(_events);
            }
            return Container();
          } else {
            return Container();
          }
        });
  }
}
