// ignore_for_file: unused_local_variable
import 'dart:convert';
import 'package:bhfudbal_admin/models/response/korisnik_response.dart';
import 'package:bhfudbal_admin/models/search_results.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';

import '../utils/util.dart';

class KorisnikProvider with ChangeNotifier {
  static String? _baseUrl;
  static String endpoint = "Korisnik";
  KorisnikProvider() {
    _baseUrl = const String.fromEnvironment("baseUrl",
        defaultValue: "https://localhost:44344/");
  }

  Future<SearchResult<KorisnikResponse>> get(String? ime) async {
    var url = "$_baseUrl$endpoint";
    if (ime != null && ime.isNotEmpty) {
      url += "/?Ime=$ime";
    }
    var uri = Uri.parse(url);
    var headers = createHeaders();
    var response = await http.get(uri, headers: headers);
    if (isValidResponse(response)) {
      var data = jsonDecode(response.body);
      var result = SearchResult<KorisnikResponse>();
      for (var item in data) {
        result.result.add(KorisnikResponse.fromJson(item));
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
