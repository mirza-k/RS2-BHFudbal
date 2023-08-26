class SezonaResponse {
  int? sezonaId;
  String? naziv;
  bool? aktivna;

  SezonaResponse({this.sezonaId, this.naziv, this.aktivna});

  factory SezonaResponse.fromJson(Map<String, dynamic> json) {
    return SezonaResponse(
        sezonaId: json["sezonaId"] as int,
        naziv: json["naziv"] as String,
        aktivna: json["aktivna"] as bool);
  }
}
