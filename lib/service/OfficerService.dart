import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:find_officer_lra/models/apiResponse.dart';
import 'package:find_officer_lra/models/officer.dart';

class OfficerService {
  static const api = 'https://www.lra.findofficer.com/api/lra';

  static  Future<ApiResponse<Officer>> getOfficer(String id) async {
    return http.get(api + '/officers/' + id).then((data){
      if(data.statusCode == 200){
        //print(data.statusCode);
        final jsonData = json.decode(data.body);
        return ApiResponse<Officer>(data: Officer.fromJson(jsonData));
      }
      return ApiResponse<Officer>(error: true, errMessage: 'an error occured');
    }).catchError((_) => ApiResponse<Officer>(error: true, errMessage: 'an error occured'));
  }
}

