import 'package:flutter/material.dart';
import 'package:odd_app/models/provider.dart';
import 'package:provider/provider.dart';


class StartPage extends StatefulWidget {
  @override
  _StartPageState createState() => _StartPageState();
}

class _StartPageState extends State<StartPage> {
  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    Products userdata = Provider.of<Products>(context);
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      appBar: AppBar(
        toolbarHeight: 50,
        backgroundColor: Colors.white,
        elevation: 0.0,
        leading: IconButton(
          icon: Icon(Icons.people, color: Colors.grey, size: 25,),
          onPressed: () {
            Navigator.of(context).pushReplacementNamed('/people');
          },
        ),
        actions: <Widget> [
          IconButton(
            icon: Icon(
              Icons.cached,
              size: 30,
              color: Colors.grey,
            ),
            onPressed: () {
              Navigator.of(context).pushReplacementNamed('/changeSex');
            },
          ),
        ],
      ),
      body: Center(
        child: Column(
          children: <Widget>[
            SizedBox(height: screenHeight * 0.25),
            Text('One day', style: TextStyle(fontSize: 50, fontWeight: FontWeight.w200),),
            Text('Diary', style: TextStyle(fontSize: 60, fontWeight: FontWeight.w100),),
            SizedBox(height: 80,),
            InkWell(
              child: Text('Start',style: TextStyle(fontSize: 30,fontWeight: FontWeight.w300),),
              onTap: (){
                userdata.serverCall('YONGKI');
                Navigator.of(context).pushReplacementNamed('/menu');},
            ),
          ],
        ),
      ),
    );
  }
}
