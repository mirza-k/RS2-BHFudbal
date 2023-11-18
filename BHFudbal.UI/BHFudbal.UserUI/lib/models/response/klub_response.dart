class KlubResponse {
  int? klubId;
  String? naziv;

  KlubResponse({this.klubId, this.naziv});

  factory KlubResponse.fromJson(Map<String, dynamic> json) {
    return KlubResponse(
        klubId: json['klubId'] as int, naziv: json['naziv'] as String);
  }
}
