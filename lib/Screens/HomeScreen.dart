import 'package:find_officer_lra/Screens/Send.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;


import 'DetailPage.dart';

void main() => runApp(HomeScreen());

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  String search;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
    
      body: SafeArea(
        child: Column(
          children: <Widget>[
            Expanded(
              flex: 3,
              child: Image(
                image: AssetImage('images/lraLogo.png'),
              ),
            ),
            Expanded(
              flex: 1,
              child: Container(
                margin: EdgeInsets.only(left: 20, right: 20, top: 0.0),
                color: Color(0xfff5f5f5),
                child: TextFormField(
                  keyboardType: TextInputType.number,
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 20.0,
                      fontFamily: 'SFUIDisplay'

                  ),
                onChanged: (value){
                    search = value;
                },
                  decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Officer ID',
                      prefixIcon: Icon(Icons.person_outline),
                      labelStyle: TextStyle(
                          fontSize: 20
                      )
                  ),

                ),

              ),
            ),
            Container(
              child: FlatButton(
                color: Colors.red.shade900,
                padding: EdgeInsets.only(left: 30, right: 30, top: 15, bottom: 15),
                child: Text('Search',
                  style: TextStyle(
                    fontSize: 25,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                textColor: Colors.white,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15)
                ),
                onPressed: (){

                  if(search == null){
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => DetailPage(officerId: '00000'),
                      ),
                    );
                  }else if (search.length < 5 || search.length > 5){
                    Fluttertoast.showToast(
                        msg: "Officer id Must be 5 digits",
                        toastLength: Toast.LENGTH_SHORT,
                        gravity: ToastGravity.CENTER,
                        timeInSecForIos: 1,
                        backgroundColor: Colors.red,
                        textColor: Colors.white,
                        fontSize: 16.0
                    );
                  }else if(search.length == 5){
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => DetailPage(officerId: search),
                      ),
                    );
                  }else{
                    //print(id);
                    print(search);
                    Fluttertoast.showToast(
                        msg: "Please look Carefully",
                        toastLength: Toast.LENGTH_SHORT,
                        gravity: ToastGravity.CENTER,
                        timeInSecForIos: 1,
                        backgroundColor: Colors.red,
                        textColor: Colors.white,
                        fontSize: 16.0
                    );
                  }
                },
              ),
            ),
            Expanded(
              flex: 1,
              child: Container(
                margin: EdgeInsets.only(bottom: 0.0, top: 50),

                child: Text('Powered By: RoviaGate Technology LLC'),
              ),
            )
          ],
        ),
      ),
    );
  }
}
