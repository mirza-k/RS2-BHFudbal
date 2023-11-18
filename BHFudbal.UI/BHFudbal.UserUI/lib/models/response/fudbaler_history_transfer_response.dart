class FudbalerHistoryTransferResponse {
  final int fudbalerId;
  final String imeFudbalera;
  final String stariKlub;
  final String noviKlub;
  final String cijena;
  final String ugovor;

  FudbalerHistoryTransferResponse({
    required this.fudbalerId,
    required this.imeFudbalera,
    required this.stariKlub,
    required this.noviKlub,
    required this.cijena,
    required this.ugovor,
  });

  factory FudbalerHistoryTransferResponse.fromJson(Map<String, dynamic> json) {
    return FudbalerHistoryTransferResponse(
      fudbalerId: json['fudbalerId'],
      imeFudbalera: json['imeFudbalera'],
      stariKlub: json['stariKlub'],
      noviKlub: json['noviKlub'],
      cijena: json['cijena'],
      ugovor: json['ugovor'],
    );
  }
}
