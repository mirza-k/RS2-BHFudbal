// ignore_for_file: unused_local_variable
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../models/response/sezona_response.dart';
import '../models/search_results.dart';
import '../utils/auth_utils.dart';

class SezonaProvider with ChangeNotifier {
  static String? _baseUrl;
  static String endpoint = "Sezona";
  SezonaProvider() {
    _baseUrl = const String.fromEnvironment("baseUrl",
        defaultValue: "http://10.0.2.2:5001/");
  }

  Future<SearchResult<SezonaResponse>> get() async {
    var url = "$_baseUrl$endpoint";
    var uri = Uri.parse(url);
    var headers = createHeaders();
    var response = await http.get(uri, headers: headers);
    if (isValidResponse(response)) {
      var data = jsonDecode(response.body);
      var result = SearchResult<SezonaResponse>();
      for (var item in data) {
        result.result.add(SezonaResponse.fromJson(item));
      }
      return result;
    } else {
      throw new Exception("Unexpected error");
    }
  }
}
