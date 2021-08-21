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
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          color: Colors.black,
          width: MediaQuery.of(context).size.height * 1,
          height: MediaQuery.of(context).size.height * 1,
          child: Padding(
            padding: const EdgeInsets.all(4.0),
            child: Container(
              color: Colors.white,
              width: MediaQuery.of(context).size.height * 1,
              height: MediaQuery.of(context).size.height * 1,
              child: Stack(
                children: [
                  Column(
                    children: [
                      SizedBox(height: 25,),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          IconButton(
                            icon: Icon(
                              Icons.people,
                              color: Colors.black45,
                              size: 30,
                            ),
                            onPressed: () {
                              Navigator.of(context).pushReplacementNamed('/people');
                            },
                          ),
                        ],
                      ),
                    ],
                  ),
                  Column(
                    children: [
                      SizedBox(height: 25,),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          IconButton(
                            icon: Icon(
                              Icons.assignment_ind_sharp,
                              size: 30,
                              color: Colors.black45,
                            ),
                            onPressed: () {
                              Navigator.of(context).pushReplacementNamed('/changeSex');
                            },
                          ),
                        ],
                      ),
                    ],
                  ),
                  Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Text(
                          'One day',
                          style: TextStyle(
                              fontSize: 50, fontWeight: FontWeight.w200),
                        ),
                        Text(
                          'Diary',
                          style: TextStyle(
                              fontSize: 60, fontWeight: FontWeight.w100),
                        ),
                        SizedBox(
                          height: 80,
                        ),
                        InkWell(
                          child: Text(
                            'Start',
                            style: TextStyle(
                                fontSize: 30, fontWeight: FontWeight.w300),
                          ),
                          onTap: () {
                            userdata.
                            serverCall('KIM');
                            Navigator.of(context).pushReplacementNamed('/menu');
                          },
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
