class FudbalerRequest {
  String? ime;
  String? prezime;
  String? visina;
  String? tezina;
  DateTime? datumRodjenja;
  int? klubId;
  String? jacaNoga;
  String? slika;

  FudbalerRequest(
      {this.ime,
      this.prezime,
      this.visina,
      this.tezina,
      this.datumRodjenja,
      this.klubId,
      this.jacaNoga,
      this.slika});

  Map<String, dynamic> toJson(FudbalerRequest instance) => <String, dynamic>{
        'ime': instance.ime,
        'prezime': instance.prezime,
        'visina': instance.visina,
        'težina': instance.tezina,
        'datumRodjenja': instance.datumRodjenja!.toIso8601String(),
        'klubId': instance.klubId,
        'jačaNoga': instance.jacaNoga,
        'slika': instance.slika
      };
}
