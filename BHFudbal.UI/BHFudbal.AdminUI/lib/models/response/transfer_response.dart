class TransferResponse {
  String? imeFudbalera;
  int? cijena;
  int? brojGodinaUgovora;
  String? nazivKluba;
  String? stariKlub;
  int? fudbalerId;

  TransferResponse(
      {this.imeFudbalera,
      this.cijena,
      this.stariKlub,
      this.brojGodinaUgovora,
      this.fudbalerId,
      this.nazivKluba});

  factory TransferResponse.fromJson(Map<String, dynamic> json) {
    return TransferResponse(
        imeFudbalera: json["imeFudbalera"] as String,
        nazivKluba: json["nazivKluba"] as String,
        stariKlub: json["stariKlub"] as String,
        cijena: json["cijena"] as int,
        fudbalerId: json["fudbalerId"] as int,
        brojGodinaUgovora: json["brojGodinaUgovora"] as int);
  }
}
