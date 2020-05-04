import 'dart:io';
import 'package:find_officer_lra/Screens/HomeScreen.dart';
import 'package:find_officer_lra/input/image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:location/location.dart';
import 'package:http/http.dart' as http;


class Send extends StatefulWidget {
  final String officerId;
  final String type;
  final String image;
  Send({Key key, this.officerId, this.type, this.image}) : super(key: key);
  @override
  _SendState createState() => _SendState();
}

class _SendState extends State<Send> {

  String selectItem;
  String number;
  String fullName;
  String email;
  String content;
  String latitude;
  String longitude;

  Future<void> _getLocation() async {
    final locData = await Location().getLocation();
    //print(locData.latitude);
    setState(() {
      latitude = locData.latitude.toString();
      longitude = locData.longitude.toString();
    });
  }
  //var date = new DateFormat("dd-MM-yyyy").format(now);
//  _getImage (File image){
//
//  }


  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.red,
        title: Text('${widget.officerId} |  ${widget.type} '),
      ),
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Form(
          //key: _formKeyValue,
          autovalidate: true,
          child: ListView(
            children: <Widget>[
              Container(
                height: 400,
                decoration: BoxDecoration(
                    image: DecorationImage(
                        image: NetworkImage('https://www.lra.findofficer.com/static/' + widget.image),
                        fit: BoxFit.fill
                    )
                ),
              ),
              Padding(
                padding: EdgeInsets.all(30.0),
                child: Column(
                  children: <Widget>[
                     Container(
                      padding: EdgeInsets.all(5),
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10),
                          boxShadow: [
                            BoxShadow(
                                color: Color.fromRGBO(143, 148, 251, .2),
                                blurRadius: 20.0,
                                offset: Offset(0, 10)
                            )
                          ]
                      ),
                      child: Column(
                        children: <Widget>[
                          Container(
                            padding: EdgeInsets.all(8.0),
                            decoration: BoxDecoration(
                                border: Border(bottom: BorderSide(color: Colors.grey[100]))
                            ),
                            child: TextField(
                              onChanged: (value){
                                fullName = value;
                                _getLocation();
                              },
                              decoration: InputDecoration(
                                  border: InputBorder.none,
                                  hintText: "Enter Your Name",
                                  hintStyle: TextStyle(color: Colors.grey[400])
                              ),
                            ),
                          ),
                          Container(
                            padding: EdgeInsets.all(8.0),
                            decoration: BoxDecoration(
                                border: Border(bottom: BorderSide(color: Colors.grey[100]))
                            ),
                            child: TextField(keyboardType: TextInputType.number,
                              onChanged: (value){
                                number = value;
                              },
                              decoration: InputDecoration(
                                  border: InputBorder.none,
                                  hintText: "Enter Phone Number",
                                  hintStyle: TextStyle(color: Colors.grey[400])
                              ),
                            ),
                          ),
                          Container(
                            padding: EdgeInsets.all(8.0),
                            decoration: BoxDecoration(
                                border: Border(bottom: BorderSide(color: Colors.grey[100]))
                            ),
                            child: TextField(keyboardType: TextInputType.emailAddress,
                              onChanged: (value){
                                email = value;
                              },
                              decoration: InputDecoration(
                                  border: InputBorder.none,
                                  hintText: "Enter Email",
                                  hintStyle: TextStyle(color: Colors.grey[400])
                              ),
                            ),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: <Widget>[
                              Icon(Icons.near_me, size: 25.0, color: Colors.black,),
                              DropdownButton<String>(
                                items: <String>[
                                  'Bomi',
                                  'Bong',
                                  'Gbarpolu',
                                  'Grand Bassa',
                                  'Grand Cape Mount',
                                  'Grand Gedeh',
                                  'Grand Kru',
                                  'Lofa',
                                  'Margibi',
                                  'Maryland',
                                  'Montserrado',
                                  'Nimba',
                                  'Rivercess',
                                  'River Gee',
                                  'Sinoe'
                                ].map((String value) {
                                  return new DropdownMenuItem<String>(
                                    value: value,
                                    child: new Text(value),
                                  );
                                }).toList(),
                                onChanged: (value) {
                                  setState(() {
                                    selectItem = value;
                                  });
                                },
                                value: selectItem,
                                isExpanded: false,
                                hint: Text('Select County',
                                  style: TextStyle(color: Colors.black),
                                ),
                              )
                           ],
                          ),
                          Container(
                            padding: EdgeInsets.all(8.0),
                            decoration: BoxDecoration(
                                border: Border(bottom: BorderSide(color: Colors.grey[100]))
                            ),
                            child: ImageInput(),
                          ),
                          Container(
                            padding: EdgeInsets.all(8.0),
                            child: TextField(
                              onChanged: (value){
                                content = value;
                              },
                              keyboardType: TextInputType.multiline,
                              maxLines: 5,
                              decoration: InputDecoration(
                                  border: InputBorder.none,
                                  hintText: "Message Please",
                                  hintStyle: TextStyle(color: Colors.grey[400])
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                    SizedBox(height: 30,),
                    Container(

                      child: Center(
                        child: FlatButton(
                          onPressed: () async {
                            _getLocation();
                            //print(_imageFile);
                            if(fullName == null || content == null || selectItem == null){
                              Fluttertoast.showToast(
                                  msg: " Please enter required fields",
                                  toastLength: Toast.LENGTH_SHORT,
                                  gravity: ToastGravity.CENTER,
                                  timeInSecForIos: 1,
                                  backgroundColor: Colors.green,
                                  textColor: Colors.white,
                                  fontSize: 16.0
                              );
                            }else {

                            var url = 'https://www.lra.findofficer.com/api/comment';
                            var response = await http.post(url,
                                body: {
                                  'officerId': widget.officerId,
                                  'type': widget.type,
                                  'agency': 'LRA',
                                  'fullName': fullName,
                                  'number': number,
                                  'email': email,
                                  'content': content,
                                  'county': selectItem,
                                  'latitude': latitude,
                                  'longitude': longitude,
                                });
                            print(widget.type);
                            print('Response status: ${response.statusCode}');

                            //final result = await CommentService.addComment(comment);

                            //final err = result.error ? (result.errMessage ?? 'Error occured') : 'Success';

                              Fluttertoast.showToast(
                                  msg: "${widget
                                      .type} send Successfully ",
                                  toastLength: Toast.LENGTH_SHORT,
                                  gravity: ToastGravity.CENTER,
                                  timeInSecForIos: 1,
                                  backgroundColor: Colors.red,
                                  textColor: Colors.white,
                                  fontSize: 16.0
                              );
                              Navigator.push(
                                context,
                                MaterialPageRoute(builder: (context) =>
                                    HomeScreen()),
                              );
                            }
                          },
                          child: Text('Send'),
                          padding: EdgeInsets.only(left:20.0, right: 20.0, top: 10.0, bottom: 10.0),
                          color: Colors.red,
                          textColor: Colors.white,
                        ),
                      ),
                    ),
                    Center(
                      child: Container(
                        margin: EdgeInsets.only(bottom: 0.0, top: 50),
                        child: Text('Powered By: RoviaGate Technology LLC'),
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}