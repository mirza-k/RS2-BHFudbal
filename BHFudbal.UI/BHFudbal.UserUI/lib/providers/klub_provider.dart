// ignore_for_file: unused_local_variable
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../models/response/klub_response.dart';
import '../models/search_results.dart';
import '../utils/auth_utils.dart';

class KlubProvider with ChangeNotifier {
  static String? _baseUrl;
  static String endpoint = "Klub";
  KlubProvider() {
    _baseUrl = const String.fromEnvironment("baseUrl",
        defaultValue: "http://10.0.2.2:5001/");
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
      throw Exception("Unexpected error");
    }
  }

  Future<SearchResult<KlubResponse>> getByNaziv(String naziv) async {
    var url = "$_baseUrl$endpoint?Naziv=$naziv";
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
      throw Exception("Unexpected error");
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
      throw Exception("Unexpected error");
    }
  }
}
