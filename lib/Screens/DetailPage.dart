import 'package:find_officer_lra/models/officer.dart';
import 'package:find_officer_lra/service/OfficerService.dart';
import 'package:flutter/material.dart';
//import 'package:get_it/get_it.dart';
import 'Send.dart';
class DetailPage extends StatefulWidget {
  final String officerId;
  DetailPage({this.officerId});

  @override
  _DetailPageState createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {

  String id;
  String agency;
  String firstName;
  String lastName;
  String department;
  String position;
  String offImage;
  String status;

  String errMessage;
  Officer off;

  bool _officerInfo = false;
  bool _isLoading = false;
  @override
  void initState() {
    super.initState();
    setState(() {
      _isLoading = true;
    });
     OfficerService.getOfficer(widget.officerId).then((res){
       setState(() {
         _isLoading = false;
       });
      if(res.error){
        errMessage = res.errMessage ?? 'an error occure';
      }
      off = res.data;
      if(off != null){
        setState(() {
          _officerInfo = true;
          id = off.id;
          firstName = off.firstName;
          lastName = off.lastName;
          position = off.position;
          offImage = off.image;
          department = off.department;
          status = off.status;
        });
      }
    });
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.red.shade900,
        title: Text(widget.officerId),
      ),
      body: SafeArea(
        child: _isLoading ? Center(child: CircularProgressIndicator(),) : Container(
          child: _officerInfo ? ListView(
            children: <Widget>[
              Container(
                height: 300,
                margin: EdgeInsets.only(left: 30.0, right: 30.0),
                decoration: BoxDecoration(
                    image: DecorationImage(
                        image: NetworkImage('https://www.lra.findofficer.com/static/' + offImage),
                        fit: BoxFit.fill
                    )
                ),
              ),
              Padding(
                padding: EdgeInsets.all(20.0),
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
                            child: ListTile(
                              leading: Text('Name : '),
                              title: (
                                  Text(firstName + ' '+lastName,
                                    textAlign: TextAlign.end,
                              )
                              ),
                            )
                          ),
                          Container(
                              padding: EdgeInsets.all(8.0),
                              decoration: BoxDecoration(
                                  border: Border(bottom: BorderSide(color: Colors.grey[100]))
                              ),
                              child: ListTile(
                                leading: Text('Position : '),
                                title: (
                                    Text(position,
                                      textAlign: TextAlign.end,
                                    )
                                ),
                              )
                          ),
                          Container(
                              padding: EdgeInsets.all(8.0),
                              decoration: BoxDecoration(
                                  border: Border(bottom: BorderSide(color: Colors.grey[100]))
                              ),
                              child: ListTile(
                                leading: Text('Dept : '),
                                title: (
                                    Text(department,
                                      textAlign: TextAlign.end,
                                    )
                                ),
                              )
                          ),
                          Container(

                              padding: EdgeInsets.all(8.0),
                              decoration: BoxDecoration(
                                  border: Border(bottom: BorderSide(color: Colors.grey[100]))
                              ),
                              child: ListTile(
                                leading: Text('Status : '),
                                title: (
                                    Text(status.toUpperCase(),
                                      textAlign: TextAlign.end,
                                    )
                                ),
                              )
                          ),

                        ],
                      ),
                    ),
                    SizedBox(height: 15,),
                    Container(

                      child: Row(

                        children: <Widget>[
                          FlatButton(
                            color: Colors.red,
                            child: Text("Complain", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),),
                            onPressed: (){

                                Navigator.push(
                                  context,
                                  MaterialPageRoute(builder: (context) => Send(officerId: id, type: 'Complain', image: offImage)),
                                );
                            },

                          ),

                          SizedBox(width: 50.0),

                          FlatButton(
                            color: Colors.green,
                            child: Text("Applaud", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),),
                            onPressed: (){

                              Navigator.push(
                                context,
                                MaterialPageRoute(builder: (context) => Send(officerId: id, type: 'Applaud', image: offImage)),
                              );
                            },
                          ),
                        ],
                      )
                    ),
                  ],
                ),
              )
            ],
          ) : Center(child: Text('No Result found'),),
        ),
      ),
    );
  }
}