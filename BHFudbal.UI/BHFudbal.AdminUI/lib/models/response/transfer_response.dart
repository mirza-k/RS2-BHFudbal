class TransferResponse {
  String? imeFudbalera;
  int? cijena;
  int? brojGodinaUgovora;
  String? nazivKluba;
  String? stariKlub;

  TransferResponse(
      {this.imeFudbalera,
      this.cijena,
      this.stariKlub,
      this.brojGodinaUgovora,
      this.nazivKluba});

  factory TransferResponse.fromJson(Map<String, dynamic> json) {
    return TransferResponse(
        imeFudbalera: json["imeFudbalera"] as String,
        nazivKluba: json["nazivKluba"] as String,
        stariKlub: json["stariKlub"] as String,
        cijena: json["cijena"] as int,
        brojGodinaUgovora: json["brojGodinaUgovora"] as int);
  }
}
