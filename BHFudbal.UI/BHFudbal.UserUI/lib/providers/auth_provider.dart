import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../utils/auth_utils.dart';

class AuthProvider with ChangeNotifier {
  static String? _baseUrl;
  static String endpoint = "Korisnik";
  AuthProvider() {
    _baseUrl = const String.fromEnvironment("baseUrl",
        defaultValue: 'http://10.0.2.2:5001/');
  }

  Future<bool> register(dynamic request) async {
    var url = "$_baseUrl$endpoint/Registracija";
    var uri = Uri.parse(url);
    var headers = createHeaders();
    var jsonRequest = jsonEncode(request);
    var response = await http.post(uri, headers: headers, body: jsonRequest);
    if (isValidResponse(response)) {
      var result = jsonDecode(response.body);
      return result;
    } else {
      throw new Exception("Unexpected error");
    }
  }

  Future<int> login(dynamic request) async {
    var url = "$_baseUrl$endpoint/login";
    var uri = Uri.parse(url);
    var headers = createHeaders();
    var jsonRequest = jsonEncode(request);
    var response = await http.post(uri, headers: headers, body: jsonRequest);
    if (isValidResponse(response)) {
      var result = jsonDecode(response.body);
      return result;
    } else {
      throw new Exception("Unexpected error");
    }
  }
}
