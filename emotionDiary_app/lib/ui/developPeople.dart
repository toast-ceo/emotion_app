import 'package:flutter/material.dart';

class DevelopPeople extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    List<Map<String, String>> developerInformation = [
      {'name': '이삭  ', 'role': 'Front-End','model':'happyBoy'},
      {'name': '김용기', 'role': 'Back-End','model':'moodBoy'},
      {'name': '신민철', 'role': 'Mentor','model':'unknownBoy'},
      {'name': '서수정', 'role': 'Designer','model':'happyGirl'},
    ];

    return Scaffold(
      backgroundColor: Colors.white,
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
              Navigator.pushReplacementNamed(context, "/start");
            },
          )),
      body: Center(
        child: Column(
          children: [
            Text("개발자 & 도움주신 이들", style: TextStyle(fontSize: 30,fontFamily: 'NanumPenScript'),),
            SizedBox(height: 20,),
            Container(
              width: MediaQuery.of(context).size.width*0.8,
              height: 2,
              color: Colors.grey[300],
            ),
            SizedBox(height: 10,),
            Container(
              height: MediaQuery.of(context).size.height*0.8,
              child: ListView.builder(
                itemCount: developerInformation.length,
                itemBuilder: (context, index){
                  return Container(
                    height: 150,
                    child: Column(
                      children: [
                        SizedBox(height: 10,),
                        Row(
                          children: [
                            SizedBox(width: 30,),
                            Container(width: 100,height: 100,
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                borderRadius:
                                BorderRadius.all(Radius.circular(16.0)),
                                image: DecorationImage(
                                  alignment: Alignment.center,
                                  image: AssetImage(
                                    "images/${developerInformation[index]['model']}.png",
                                  ),
                                  fit: BoxFit.cover,
                                ),
                              ),),
                            SizedBox(width: 20,),
                            Container(
                              width: 2,
                              height: 80,
                              color: Colors.grey[300],
                            ),
                            SizedBox(width: 20,),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text("Name : ${developerInformation[index]['name']}", style: TextStyle(fontSize: 25,fontFamily: 'NanumPenScript'),),
                                SizedBox(height: 8,),
                                Text("Role : ${developerInformation[index]['role']}", style: TextStyle(fontSize: 25,fontFamily: 'NanumPenScript'),),
                              ],
                            )
                          ],
                        ),
                        SizedBox(height: 10,),
                      ],
                    ),
                  );
                },
                  ),
            ),
          ],
        ),
        ),
      );
  }
}
