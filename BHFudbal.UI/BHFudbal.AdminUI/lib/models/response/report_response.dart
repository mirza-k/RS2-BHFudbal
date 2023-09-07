class ReportResponse {
  String? imeKluba;
  int? UkupnoIzvrsenihTransfera;
  int? UkupnoPotrosenogNovca;

  ReportResponse(
      {this.imeKluba,
      this.UkupnoIzvrsenihTransfera,
      this.UkupnoPotrosenogNovca});

  factory ReportResponse.fromJson(Map<String, dynamic> json) {
    return ReportResponse(
        imeKluba: json["imeKluba"] as String,
        UkupnoIzvrsenihTransfera: json["ukupnoIzvrsenihTransfera"] as int,
        UkupnoPotrosenogNovca: json["ukupnoPotrosenogNovca"] as int);
  }
}
