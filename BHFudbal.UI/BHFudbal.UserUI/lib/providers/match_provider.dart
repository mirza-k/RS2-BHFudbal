// ignore_for_file: unused_local_variable
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/models/response/match_details_response.dart';
import 'package:flutter_application_1/models/response/match_forma_response.dart';
import 'package:flutter_application_1/models/response/match_strijelci_response.dart';
import 'package:flutter_application_1/models/response/tabela_response.dart';
import 'package:http/http.dart' as http;
import '../models/response/matches_by_klub_response.dart';
import '../models/response/utakmica_response.dart';
import '../models/search_results.dart';
import '../utils/auth_utils.dart';

class MatchProvider with ChangeNotifier {
  static String? _baseUrl;
  static String endpoint = "Match";
  MatchProvider() {
    _baseUrl = const String.fromEnvironment("baseUrl",
        defaultValue: "http://10.0.2.2:5001/");
  }

  Future<int> GetMaxBrojKola(int ligaId) async {
    if (ligaId > 0) {
      var url = "$_baseUrl$endpoint/MaxBrojKola/$ligaId";
      var uri = Uri.parse(url);
      var headers = createHeaders();
      var response = await http.get(uri, headers: headers);
      if (isValidResponse(response)) {
        var result = jsonDecode(response.body);
        return result;
      } else {
        throw Exception("Unexpected error");
      }
    }
    return 0;
  }

  Future<SearchResult<UtakmiceResponse>> get(int? ligaId, int? kolo) async {
    var url = "$_baseUrl$endpoint?LigaId=$ligaId&RedniBrojKola=$kolo";
    var uri = Uri.parse(url);
    var headers = createHeaders();
    var response = await http.get(uri, headers: headers);
    if (isValidResponse(response)) {
      var data = jsonDecode(response.body);
      var result = SearchResult<UtakmiceResponse>();
      for (var item in data) {
        result.result.add(UtakmiceResponse.fromJson(item));
      }
      return result;
    } else {
      throw Exception("Unexpected error");
    }
  }

  Future<MatchDetailsResponse> getDetails(int? matchId) async {
    var url = "$_baseUrl$endpoint/Details/$matchId";
    var uri = Uri.parse(url);
    var headers = createHeaders();
    var response = await http.get(uri, headers: headers);
    if (isValidResponse(response)) {
      var data = jsonDecode(response.body);
      var result = MatchDetailsResponse();
      result = MatchDetailsResponse.fromJson(data);
      return result;
    } else {
      throw Exception("Unexpected error");
    }
  }

  Future<SearchResult<TabelaResponse>> getTabela(int? ligaId) async {
    var url = "$_baseUrl$endpoint/Tabela/$ligaId";
    var uri = Uri.parse(url);
    var headers = createHeaders();
    var response = await http.get(uri, headers: headers);
    if (isValidResponse(response)) {
      var data = jsonDecode(response.body);
      var result = SearchResult<TabelaResponse>();
      for (var item in data) {
        result.result.add(TabelaResponse.fromJson(item));
      }
      return result;
    } else {
      throw Exception("Unexpected error");
    }
  }

  Future<SearchResult<MatchStrijelciResponse>> getStrijelci(int? ligaId) async {
    var url = "$_baseUrl$endpoint/Strijelci/$ligaId";
    var uri = Uri.parse(url);
    var headers = createHeaders();
    var response = await http.get(uri, headers: headers);
    if (isValidResponse(response)) {
      var data = jsonDecode(response.body);
      var result = SearchResult<MatchStrijelciResponse>();
      for (var item in data) {
        result.result.add(MatchStrijelciResponse.fromJson(item));
      }
      return result;
    } else {
      throw Exception("Unexpected error");
    }
  }

  Future<SearchResult<MatchFormaResponse>> getForma(int? ligaId) async {
    var url = "$_baseUrl$endpoint/Forma/$ligaId";
    var uri = Uri.parse(url);
    var headers = createHeaders();
    var response = await http.get(uri, headers: headers);
    if (isValidResponse(response)) {
      var data = jsonDecode(response.body);
      var result = SearchResult<MatchFormaResponse>();
      for (var item in data) {
        result.result.add(MatchFormaResponse.fromJson(item));
      }
      return result;
    } else {
      throw Exception("Unexpected error");
    }
  }

  Future<MatchesByKlubResponse> getAllMatchesByKlubId(int? klubId) async {
    var url = "$_baseUrl$endpoint/All/$klubId";
    var uri = Uri.parse(url);
    var headers = createHeaders();
    var response = await http.get(uri, headers: headers);
    if (isValidResponse(response)) {
      var data = jsonDecode(response.body);
      var result = MatchesByKlubResponse(rezultati: []);
      result = MatchesByKlubResponse.fromJson(data);
      return result;
    } else {
      throw Exception("Unexpected error");
    }
  }

  Future<MatchesByKlubResponse> getByKlubAndSezona(
      int? klubId, int? sezonaId) async {
    var url =
        "$_baseUrl$endpoint/AllBySezona?KlubId=$klubId&sezonaId=$sezonaId";
    var uri = Uri.parse(url);
    var headers = createHeaders();
    var response = await http.get(uri, headers: headers);
    if (isValidResponse(response)) {
      var data = jsonDecode(response.body);
      var result = MatchesByKlubResponse(rezultati: []);
      result = MatchesByKlubResponse.fromJson(data);
      return result;
    } else {
      throw Exception("Unexpected error");
    }
  }
}
