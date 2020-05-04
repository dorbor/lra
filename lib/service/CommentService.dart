import 'dart:convert';
import 'package:find_officer_lra/models/InsertComment.dart';
import 'package:http/http.dart' as http;
import 'package:find_officer_lra/models/apiResponse.dart';


class CommentService {
  static const api = 'https://findofficer.herokuapp.com/api';


  static Future<ApiResponse<bool>> addComment(InsertComment item) async {
    return http.post(api + '/comment', body: json.encode(item.toJson())).then((data){
      if(data.statusCode == 201){
        return ApiResponse<bool>(data: true);
      }
      return ApiResponse<bool>(error: true, errMessage: 'an error occured');
    }).catchError((_) => ApiResponse<bool>(error: true, errMessage: 'an error occured'));
  }
}

