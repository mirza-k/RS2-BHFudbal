class LigaResponse {
  int? ligaId1;
  String? naziv;

  LigaResponse({
    required this.ligaId1,
    required this.naziv,
  });

  factory LigaResponse.fromJson(Map<String, dynamic> json) {
    return LigaResponse(
      ligaId1: json['ligaId1'] as int,
      naziv: json['naziv'] as String,
    );
  }
}
