class UtakmiceResponse {
  String? prikaz;

  UtakmiceResponse({this.prikaz});

  factory UtakmiceResponse.fromJson(Map<String, dynamic> json) {
    return UtakmiceResponse(prikaz: json["prikaz"] as String);
  }
}
