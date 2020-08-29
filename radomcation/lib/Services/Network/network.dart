import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:radomcation/Services/Network/Models/JSONRandom.dart';

Future<ApiResponse<JSONRandom>> getRandom(String url) async {
  http.Response response = await http.get(url);
  if(response.statusCode < 200 || response.statusCode >= 400) return ApiResponse<JSONRandom>(esit: false);
  else return ApiResponse<JSONRandom>(esit: true, data: JSONRandom.fromJson(jsonDecode(response.body)));
}

class ApiResponse<T> {
  T data;
  bool esit;

  ApiResponse({this.data, this.esit});
}