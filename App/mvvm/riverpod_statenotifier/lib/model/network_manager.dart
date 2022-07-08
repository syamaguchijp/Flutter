import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'api_response.dart';
import 'package:mvvm/logging.dart';

class NetworkManager {

  Future<ApiResponse?> startApi(String userName) async {

    Logging.d("");

    final queryParameters = {
      'userName': userName
    };
    try {
      final response = await http.get(
          Uri.https('httpbin.org', '/get', queryParameters));
      Logging.d(response.body);
      final parsed = json.decode(response.body);
      ApiResponse apiResponse = ApiResponse.fromJson(parsed);
      return apiResponse;

    } on SocketException catch (e) {
      Logging.d(e.toString());
      return null;

    } on Exception catch (e) {
      // statusCodeが200以外
      Logging.d(e.toString());
      return null;

    } catch (e) {
      Logging.d(e.toString());
      return null;
    }
  }
}