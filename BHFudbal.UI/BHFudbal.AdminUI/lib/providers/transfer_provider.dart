// ignore_for_file: unused_local_variable
import 'dart:convert';
import 'package:bhfudbal_admin/models/response/transfer_response.dart';
import 'package:bhfudbal_admin/models/search_results.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';

class TransferProvider with ChangeNotifier {
  static String? _baseUrl;
  static String endpoint = "Transfer";
  TransferProvider() {
    _baseUrl = const String.fromEnvironment("baseUrl",
        defaultValue: "https://localhost:44344/");
  }

  Future<SearchResult<TransferResponse>> get(int? sezonaId) async {
    var url = "$_baseUrl$endpoint";
    if (sezonaId != null && sezonaId > 0) {
      url += "/?SezonaId=$sezonaId";
    }
    var uri = Uri.parse(url);
    var headers = createHeaders();
    var response = await http.get(uri, headers: headers);
    if (isValidResponse(response)) {
      var data = jsonDecode(response.body);
      var result = SearchResult<TransferResponse>();
      for (var item in data) {
        result.result.add(TransferResponse.fromJson(item));
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
    // String username = Authorization.username ?? "";
    // String pass = Authorization.password ?? "";
    String username = "mirza";
    String pass = "mirza";
    String basicAuth = "Basic ${base64Encode(utf8.encode('$username:$pass'))}";

    var headers = {
      "accept": "text/plain",
      "Content-Type": "application/json",
      "Authorization": basicAuth
    };

    return headers;
  }
}
