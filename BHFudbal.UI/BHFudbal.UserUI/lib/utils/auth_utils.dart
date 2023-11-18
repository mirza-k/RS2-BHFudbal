import 'dart:convert';

import 'package:http/http.dart';

class Authorization {
  static String? username = "";
  static String? password = "";
  static int? id = 3;
}

bool isValidResponse(Response response) {
  if (response.statusCode < 299) {
    return true;
  } else if (response.statusCode == 401) {
    throw Exception("Unauthorized");
  } else {
    throw Exception("Something bad happened please try again");
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
