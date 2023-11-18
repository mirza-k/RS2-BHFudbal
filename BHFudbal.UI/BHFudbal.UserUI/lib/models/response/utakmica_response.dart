class UtakmiceResponse {
  int? matchId;
  String? prikaz;

  UtakmiceResponse({this.prikaz, this.matchId});

  factory UtakmiceResponse.fromJson(Map<String, dynamic> json) {
    return UtakmiceResponse(
        prikaz: json["prikaz"] as String, matchId: json["matchId"] as int);
  }
}
