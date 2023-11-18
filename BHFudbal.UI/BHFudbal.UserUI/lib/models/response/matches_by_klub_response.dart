class MatchesByKlubResponse {
  int? brojDatihGolova;
  int? brojPrimljenihGolova;
  List<String> rezultati = [];

  MatchesByKlubResponse({
    this.brojDatihGolova,
    this.brojPrimljenihGolova,
    required this.rezultati,
  });

  factory MatchesByKlubResponse.fromJson(Map<String, dynamic> json) {
    final List<dynamic> rezultatiList = json['rezultati'];
    final List<String> rezultati = List<String>.from(rezultatiList);
    return MatchesByKlubResponse(
      brojDatihGolova: json['brojDatihGolova'],
      brojPrimljenihGolova: json['brojPrimljenihGolova'],
      rezultati: rezultati,
    );
  }
}
