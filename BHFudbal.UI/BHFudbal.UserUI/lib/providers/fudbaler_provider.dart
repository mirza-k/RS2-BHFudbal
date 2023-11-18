// ignore_for_file: unused_local_variable
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/models/response/fudbaler_history_transfer_response.dart';
import 'package:http/http.dart' as http;
import '../models/response/fudbaler_detail_response.dart';
import '../models/response/fudbaler_response.dart';
import '../models/search_results.dart';
import '../utils/auth_utils.dart';

class FudbalerProvider with ChangeNotifier {
  static String? _baseUrl;
  static String endpoint = "Fudbaler";
  FudbalerProvider() {
    _baseUrl = const String.fromEnvironment("baseUrl",
        defaultValue: "http://10.0.2.2:5001/");
  }

  Future<SearchResult<FudbalerResponse>> get(int? klubId) async {
    var url = "$_baseUrl$endpoint?KlubId=$klubId";
    var uri = Uri.parse(url);
    var headers = createHeaders();
    var response = await http.get(uri, headers: headers);
    if (isValidResponse(response)) {
      var data = jsonDecode(response.body);
      var result = SearchResult<FudbalerResponse>();
      for (var item in data) {
        result.result.add(FudbalerResponse.fromJson(item));
      }
      return result;
    } else {
      throw Exception("Unexpected error");
    }
  }

  Future<FudbalerResponse> getById(int? fudbalerId) async {
    var url = "$_baseUrl$endpoint/$fudbalerId";
    var uri = Uri.parse(url);
    var headers = createHeaders();
    var response = await http.get(uri, headers: headers);
    if (isValidResponse(response)) {
      var data = jsonDecode(response.body);
      return FudbalerResponse.fromJson(data);
    } else {
      throw Exception("Unexpected error");
    }
  }

  Future<FudbalerDetailResponse> getDetails(int? fudbalerId) async {
    var url = "$_baseUrl$endpoint/details/$fudbalerId";
    var uri = Uri.parse(url);
    var headers = createHeaders();
    var response = await http.get(uri, headers: headers);
    if (isValidResponse(response)) {
      var data = jsonDecode(response.body);
      return FudbalerDetailResponse.fromJson(data);
    } else {
      throw Exception("Unexpected error");
    }
  }

  Future<SearchResult<FudbalerHistoryTransferResponse>>
      getFudbalerHistoryTransfer(int? fudbalerId) async {
    var url = "$_baseUrl$endpoint/transferhistory/$fudbalerId";
    var uri = Uri.parse(url);
    var headers = createHeaders();
    var response = await http.get(uri, headers: headers);
    if (isValidResponse(response)) {
      var data = jsonDecode(response.body);
      var result = SearchResult<FudbalerHistoryTransferResponse>();
      for (var item in data) {
        result.result.add(FudbalerHistoryTransferResponse.fromJson(item));
      }
      return result;
    } else {
      throw Exception("Unexpected error");
    }
  }

  Future<SearchResult<FudbalerResponse>> getSlicneFudbalere(
      int? fudbalerId) async {
    var url = "$_baseUrl$endpoint/recommended/$fudbalerId";
    var uri = Uri.parse(url);
    var headers = createHeaders();
    var response = await http.get(uri, headers: headers);
    if (isValidResponse(response)) {
      var data = jsonDecode(response.body);
      var result = SearchResult<FudbalerResponse>();
      for (var item in data) {
        result.result.add(FudbalerResponse.fromJson(item));
      }
      return result;
    } else {
      throw Exception("Unexpected error");
    }
  }

  Future<int> ocijeniFudbalera(dynamic request) async {
    var url = "$_baseUrl$endpoint/OmiljeniFudbaler";
    var uri = Uri.parse(url);
    var headers = createHeaders();
    var jsonRequest = jsonEncode(request);
    var response = await http.post(uri, headers: headers, body: jsonRequest);
    if (isValidResponse(response)) {
      return 1;
    } else
      return 0;
  }

  Future<int> getRating(int? fudbalerId, int? korisnikId) async {
    var url = "$_baseUrl$endpoint/getRating/$fudbalerId/$korisnikId";
    var uri = Uri.parse(url);
    var headers = createHeaders();
    var response = await http.get(uri, headers: headers);
    if (isValidResponse(response)) {
      var result = jsonDecode(response.body);
      return result;
    } else
      return 0;
  }
}
