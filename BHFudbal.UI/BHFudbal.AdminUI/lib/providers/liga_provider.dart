// ignore_for_file: unused_local_variable

import 'dart:convert';
import 'package:bhfudbal_admin/models/response/liga_response.dart';
import 'package:bhfudbal_admin/models/search_results.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';

import '../utils/util.dart';

class LigaProvider with ChangeNotifier {
  static String? _baseUrl;
  static String endpoint = "Liga";
  LigaProvider() {
    _baseUrl = const String.fromEnvironment("baseUrl",
        defaultValue: "http://localhost:5001/");
  }

  Future<SearchResult<LigaResponse>> get(bool samoAktivne) async {
    var url = "$_baseUrl$endpoint?SamoAktivne=$samoAktivne";
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

  
  Future<SearchResult<LigaResponse>> getBySezonaId(int? sezonaId) async {
    var url = "$_baseUrl$endpoint?SezonaId=$sezonaId";
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

  bool isValidResponse(Response response) {
    if (response.statusCode < 299) {
      return true;
    } else if (response.statusCode == 401) {
      throw new Exception("Unauthorized");
    } else {
      throw new Exception("Something bad happened please try again");
    }
  }

  Map<String, String> createHeaders() {
    String username = Authorization.username ?? "";
    String pass = Authorization.password ?? "";
    String basicAuth = "Basic ${base64Encode(utf8.encode('$username:$pass'))}";

    var headers = {
      "accept": "text/plain",
      "Content-Type": "application/json",
      "Authorization": basicAuth
    };

    return headers;
  }
}
