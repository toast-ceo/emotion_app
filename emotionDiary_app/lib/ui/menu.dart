import 'package:flutter/material.dart';
import 'package:odd_app/models/provider.dart';
import 'package:provider/provider.dart';


class MenuPage extends StatefulWidget {
  @override
  _MenuPageState createState() => _MenuPageState();
}

class _MenuPageState extends State<MenuPage> {
  @override
  Widget build(BuildContext context) {
    Products userdata = Provider.of<Products>(context, listen: false);

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
              print(userdata.fetchPost());
            Navigator.pushReplacementNamed(context, "/start");
            },
          ),
      ),
      body: FutureBuilder(
        future: userdata.fetchPost(),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          print("gd ${snapshot.hasData}");
          if (snapshot.hasData) {
            userdata.callInfomation(snapshot.data);
          return Padding(
              padding: EdgeInsets.fromLTRB(30, 0, 30, 30),
              child: snapshot.hasData ? Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  Container(
                    width: MediaQuery.of(context).size.width,
                    height: 2,
                    color: Colors.grey,
                  ),
                  SizedBox(height: 100),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Card(
                        elevation: 1,
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(12))),
                        child: InkWell(
                          child: Column(
                            children: [
                              Container(
                                height: 200,
                                width: 150,
                                alignment: Alignment.center,
                                decoration: BoxDecoration(
                                  image: DecorationImage(
                                    alignment: Alignment.center,
                                    image: AssetImage(
                                      "images/record.jpg",
                                    ),
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                              Container(child: Text("Record",style: TextStyle(fontSize: 25),),),
                            ],
                          ),
                          onTap: ()=> Navigator.of(context).pushReplacementNamed('/record'),
                        ),
                      ),
                      Card(
                        elevation: 1,
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(12))),
                        child: InkWell(
                          child: Column(
                            children: [
                              Container(
                                height: 200,
                                width: 150,
                                alignment: Alignment.center,
                                decoration: BoxDecoration(
                                  image: DecorationImage(
                                    alignment: Alignment.center,
                                    image: AssetImage(
                                      "images/remind.jpg",
                                    ),
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                              Container(child: Text("Remind",style: TextStyle(fontSize: 25),),),
                            ],
                          ),
                          onTap: ()=> Navigator.of(context).pushReplacementNamed('/remind'),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 100),
                  Container(
                    width: MediaQuery.of(context).size.width,
                    height: 2,
                    color: Colors.grey,
                  ),
                ],
              ) : Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  Container(
                    width: MediaQuery.of(context).size.width,
                    height: 2,
                    color: Colors.grey,
                  ),
                  SizedBox(height: 165),
                  InkWell(
                    child: Text('Record',style: TextStyle(fontSize: 40,fontWeight: FontWeight.w300),),
                    onTap: ()=> Navigator.of(context).pushReplacementNamed('/record'),
                  ),
                  SizedBox(height: 165),
                  Container(
                    width: MediaQuery.of(context).size.width,
                    height: 2,
                    color: Colors.grey,
                  ),
                ],
              ),
            );
          }else {
            return Center(child: CircularProgressIndicator());
          }
        },
      ),
    );
  }
}


/// bool a = false;
/// a ? card : card