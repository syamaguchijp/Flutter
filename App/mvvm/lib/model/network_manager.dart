import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;

import 'api_response.dart';

class NetworkManager {

  Future<ApiResponse> startApi() async {
    final queryParameters = {
      'userName': 'one',
      'password': 'two',
    };
    final response = await http.get(
        Uri.https('httpbin.org', '/get', queryParameters));
    print(response.body);

    if (response.statusCode == 200) {
      final parsed = json.decode(response.body);
      ApiResponse apiResponse = ApiResponse.fromJson(parsed);
      return apiResponse;
    } else {
      throw Exception('Failed to load');
    }
  }
}