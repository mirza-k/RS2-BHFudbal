// ignore_for_file: unused_local_variable
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../models/response/liga_response.dart';
import '../models/search_results.dart';
import '../utils/auth_utils.dart';

class LigaProvider with ChangeNotifier {
  static String? _baseUrl;
  static String endpoint = "Liga";
  LigaProvider() {
    _baseUrl = const String.fromEnvironment("baseUrl",
        defaultValue: "http://10.0.2.2:5001/");
  }

  Future<SearchResult<LigaResponse>> get() async {
    var url = "$_baseUrl$endpoint";
    var uri = Uri.parse(url);
    var headers = createHeaders();
    var response = await http.get(uri, headers: headers);
    if (isValidResponse(response)) {
      var data = jsonDecode(response.body);
      var result = SearchResult<LigaResponse>();
      for (var item in data) {
        result.result.add(LigaResponse.fromJson(item));
      }
      return result;
    } else {
      throw new Exception("Unexpected error");
    }
  }

  
  // Future<SearchResult<LigaResponse>> getBySezonaId(int? sezonaId) async {
  //   var url = "$_baseUrl$endpoint?SezonaId=$sezonaId";
  //   var uri = Uri.parse(url);
  //   var headers = createHeaders();
  //   var response = await http.get(uri, headers: headers);
  //   if (isValidResponse(response)) {
  //     var data = jsonDecode(response.body);
  //     var result = SearchResult<LigaResponse>();
  //     for (var item in data) {
  //       result.result.add(LigaResponse.fromJson(item));
  //     }
  //     return result;
  //   } else {
  //     throw new Exception("Unexpected error");
  //   }
  // }

}