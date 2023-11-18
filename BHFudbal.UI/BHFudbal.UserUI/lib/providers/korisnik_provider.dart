// ignore_for_file: unused_local_variable
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/models/request/uredi_korisnika_request.dart';
import 'package:flutter_application_1/models/response/premium_report_response.dart';
import 'package:flutter_application_1/models/update_to_premium_korisnik.dart';
import 'package:http/http.dart' as http;
import '../models/response/korisnik_response.dart';
import '../utils/auth_utils.dart';

class KorisnikProvider with ChangeNotifier {
  static String? _baseUrl;
  static String endpoint = "Korisnik";
  KorisnikProvider() {
    _baseUrl = const String.fromEnvironment("baseUrl",
        defaultValue: "http://10.0.2.2:5001/");
  }

  Future<KorisnikResponse> getLoggedUser() async {
    var korisnikId = Authorization.id;
    var url = "$_baseUrl$endpoint/$korisnikId";
    var uri = Uri.parse(url);
    var headers = createHeaders();
    var response = await http.get(uri, headers: headers);
    if (isValidResponse(response)) {
      var data = jsonDecode(response.body);
      var result = KorisnikResponse.fromJson(data);
      return result;
    } else {
      throw Exception("Unexpected error");
    }
  }

  Future<int> urediKorisnika(UrediKorisnikaRequest request) async {
    var url = "$_baseUrl$endpoint/Uredi";
    var uri = Uri.parse(url);
    var headers = createHeaders();
    var jsonRequest = jsonEncode(request);
    var response = await http.post(uri, headers: headers, body: jsonRequest);
    if (isValidResponse(response)) {
      Authorization.username = request.username;
      return 1;
    } else
      return 0;
  }

  Future<int> isKorisnikPremium(dynamic request) async {
    var url = "$_baseUrl$endpoint/IsKorisnikPremium";
    var uri = Uri.parse(url);
    var headers = createHeaders();
    var jsonRequest = jsonEncode(request);
    var response = await http.post(uri, headers: headers, body: jsonRequest);
    if (isValidResponse(response)) {
      var result = jsonDecode(response.body);
      return result;
    } else
      return 0;
  }

  Future<int> updateToPremium(dynamic request) async {
    var url = "$_baseUrl$endpoint/UpdateToPremium";
    var uri = Uri.parse(url);
    var headers = createHeaders();
    var jsonRequest = jsonEncode(request);
    var response = await http.post(uri, headers: headers, body: jsonRequest);
    if (isValidResponse(response)) {
      var result = jsonDecode(response.body);
      return result;
    } else
      return 0;
  }

  Future<PremiumReport> getPremiumReport(int sezonaId) async {
    var url = "$_baseUrl$endpoint/Report/$sezonaId";
    var uri = Uri.parse(url);
    var headers = createHeaders();
    var response = await http.get(uri, headers: headers);
    if (isValidResponse(response)) {
      var data = jsonDecode(response.body);
      var result = PremiumReport.fromJson(data);
      return result;
    } else {
      throw Exception("Unexpected error");
    }
  }
}
