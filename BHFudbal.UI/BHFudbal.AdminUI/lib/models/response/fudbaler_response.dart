import 'package:bhfudbal_admin/models/response/klub_response.dart';

class FudbalerResponse {
  int? fudbalerId;
  String? ime;
  String? prezime;
  String? visina;
  String? tezina;
  String? datumRodjenja;
  int? gradId;
  int? klubId;
  String? klub;
  String? jacaNoga;
  int? drzavaId;
  String? drzava;
  String? slika;

  FudbalerResponse(
      {this.fudbalerId,
      this.ime,
      this.prezime,
      this.visina,
      this.tezina,
      this.datumRodjenja,
      this.gradId,
      this.klubId,
      this.klub,
      this.jacaNoga,
      this.drzavaId,
      this.drzava,
      this.slika});

  factory FudbalerResponse.fromJson(Map<String, dynamic> json) {
    return FudbalerResponse(
        fudbalerId: json["fudbalerId"] as int,
        ime: json["ime"] as String,
        prezime: json["prezime"] as String,
        visina: json["visina"] as String,
        tezina: json["težina"] as String,
        datumRodjenja: json["datumRodjenja"] as String,
        gradId: json["grad"] as int,
        klubId: json["klubId"] as int,
        klub: json["klub"] as String,
        jacaNoga: json["jačaNoga"] as String,
        drzavaId: json["drzavaId"] as int,
        drzava: json["drzava"] as String,
        slika: json["slika"] as String);
  }
}
