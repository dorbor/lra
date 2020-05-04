import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';

class InsertComment {
  String id;
  String agency;
  String type;
  String fullName;
  String number;
  String email;
  String content;
  String county;
  var latitude;
  var longitude;

  InsertComment({
    @required this.id,
    this.agency,
    this.type,
    this.fullName,
    this.number,
    this.email,
    @required this.content,
    this.county,
    this.latitude,
    this.longitude,
  });

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'agency': agency,
     'type': type,
      'fullName': fullName,
     'number': number,
     'email': email,
     'content': content,
      'county': county,
     'latitude': latitude,
     'longitude': longitude
    };
  }
}