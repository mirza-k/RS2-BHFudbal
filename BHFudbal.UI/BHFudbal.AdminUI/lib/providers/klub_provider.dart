// ignore_for_file: unused_local_variable

import 'dart:convert';
import 'package:bhfudbal_admin/models/response/klub_response.dart';
import 'package:bhfudbal_admin/models/search_results.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';

import '../utils/util.dart';

class KlubProvider with ChangeNotifier {
  static String? _baseUrl;
  static String endpoint = "Klub";
  KlubProvider() {
    _baseUrl = const String.fromEnvironment("baseUrl",
        defaultValue: "https://localhost:44344/");
  }

  Future<SearchResult<KlubResponse>> get(int? ligaId) async {
    var url = "$_baseUrl$endpoint?LigaId=$ligaId";
    var uri = Uri.parse(url);
    var headers = createHeaders();
    var response = await http.get(uri, headers: headers);
    if (isValidResponse(response)) {
      var data = jsonDecode(response.body);
      var result = SearchResult<KlubResponse>();
      for (var item in data) {
        result.result.add(KlubResponse.fromJson(item));
      }
      return result;
    } else {
      throw new Exception("Unexpected error");
    }
  }

  Future<SearchResult<KlubResponse>> getAll() async {
    var url = "$_baseUrl$endpoint";
    var uri = Uri.parse(url);
    var headers = createHeaders();
    var response = await http.get(uri, headers: headers);
    if (isValidResponse(response)) {
      var data = jsonDecode(response.body);
      var result = SearchResult<KlubResponse>();
      for (var item in data) {
        result.result.add(KlubResponse.fromJson(item));
      }
      return result;
    } else {
      throw new Exception("Unexpected error");
    }
  }

  Future<KlubResponse> getById(int? klubId) async {
    var url = "$_baseUrl$endpoint?KlubId=$klubId";
    var uri = Uri.parse(url);
    var headers = createHeaders();
    var response = await http.get(uri, headers: headers);
    if (isValidResponse(response)) {
      var data = jsonDecode(response.body);
      var result = KlubResponse.fromJson(data[0]);
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

  Future<bool> post(dynamic request) async {
    var url = "$_baseUrl$endpoint";
    var uri = Uri.parse(url);
    var headers = createHeaders();
    var jsonRequest = jsonEncode(request);
    var response = await http.post(uri, headers: headers, body: jsonRequest);
    if (isValidResponse(response)) {
      return true;
    } else {
      throw new Exception("Unexpected error");
    }
  }

    Future<bool> put(dynamic request, int? klubId) async {
    var url = "$_baseUrl$endpoint/$klubId";
    var uri = Uri.parse(url);
    var headers = createHeaders();
    var jsonRequest = jsonEncode(request);
    var response = await http.put(uri, headers: headers, body: jsonRequest);
    if (isValidResponse(response)) {
      return true;
    } else {
      throw new Exception("Unexpected error");
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
