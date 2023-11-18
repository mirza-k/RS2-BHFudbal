class PremiumReport {
  List<FinancijskiRezultati>? financijskiRezultati;
  List<KlubGoloviReport>? klubGoloviReport;
  List<KlubFudbalerSezonaReport>? klubFudbalerSezonaReport;

  PremiumReport({
    this.financijskiRezultati,
    this.klubGoloviReport,
    this.klubFudbalerSezonaReport,
  });

  factory PremiumReport.fromJson(Map<String, dynamic> json) => PremiumReport(
        financijskiRezultati: List<FinancijskiRezultati>.from(
            json["financijskiRezultati"]
                .map((x) => FinancijskiRezultati.fromJson(x))),
        klubGoloviReport: List<KlubGoloviReport>.from(
            json["klubGoloviReport"].map((x) => KlubGoloviReport.fromJson(x))),
        klubFudbalerSezonaReport: List<KlubFudbalerSezonaReport>.from(
            json["klubFudbalerSezonaReport"]
                .map((x) => KlubFudbalerSezonaReport.fromJson(x))),
      );
}

class FinancijskiRezultati {
  String? nazivKluba;
  String? finansije;
  String? brojProdatihIgraca;
  String? brojKupljenihIgraca;

  FinancijskiRezultati({
    this.nazivKluba,
    this.finansije,
    this.brojProdatihIgraca,
    this.brojKupljenihIgraca,
  });

  factory FinancijskiRezultati.fromJson(Map<String, dynamic> json) =>
      FinancijskiRezultati(
        nazivKluba: json["nazivKluba"],
        finansije: json["finansije"],
        brojProdatihIgraca: json["brojProdatihIgraca"],
        brojKupljenihIgraca: json["brojKupljenihIgraca"],
      );
}

class KlubGoloviReport {
  String? naziv;
  String? brojGolovaKuci;
  String? brojGolovaUGostima;

  KlubGoloviReport({
    this.naziv,
    this.brojGolovaKuci,
    this.brojGolovaUGostima,
  });

  factory KlubGoloviReport.fromJson(Map<String, dynamic> json) =>
      KlubGoloviReport(
        naziv: json["naziv"],
        brojGolovaKuci: json["brojGolovaKuci"],
        brojGolovaUGostima: json["brojGolovaUGostima"],
      );
}

class KlubFudbalerSezonaReport {
  String? nazivKluba;
  List<FudbalerReport>? fudbalerReport;

  KlubFudbalerSezonaReport({
    this.nazivKluba,
    this.fudbalerReport,
  });

  factory KlubFudbalerSezonaReport.fromJson(Map<String, dynamic> json) =>
      KlubFudbalerSezonaReport(
        nazivKluba: json["nazivKluba"],
        fudbalerReport: List<FudbalerReport>.from(
            json["fudbalerReport"].map((x) => FudbalerReport.fromJson(x))),
      );
}

class FudbalerReport {
  String? imeFudbalera;
  String? brojGolova;
  String? brojZutih;
  String? brojCrvenih;

  FudbalerReport({
    this.imeFudbalera,
    this.brojGolova,
    this.brojZutih,
    this.brojCrvenih,
  });

  factory FudbalerReport.fromJson(Map<String, dynamic> json) => FudbalerReport(
        imeFudbalera: json["imeFudbalera"],
        brojGolova: json["brojGolova"],
        brojZutih: json["brojZutih"],
        brojCrvenih: json["brojCrvenih"],
      );
}
