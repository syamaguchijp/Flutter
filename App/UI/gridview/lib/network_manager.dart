import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:gridview/row_data.dart';

class NetworkManager {

  Future<List<RowData>> fetchQiitaApi() async {
    final queryParameters = {
      'param1': 'one',
      'param2': 'two',
    };
    final response = await http.get(
        Uri.https('qiita.com', '/api/v2/items', queryParameters));
    print(response.body);
    if (response.statusCode == 200) {
      final parsed = json.decode(response.body).cast<Map<String, dynamic>>();
      List<RowData> list = parsed.map<RowData>((json) => RowData.fromJson(json)).toList();
      print(list);
      return list;
    } else {
      throw Exception('Failed to load');
    }
  }
}