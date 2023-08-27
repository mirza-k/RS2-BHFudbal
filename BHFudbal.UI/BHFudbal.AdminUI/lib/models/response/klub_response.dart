class KlubResponse {
  int? klubId;
  String? naziv;
  int? godinaOsnivanja;
  String? nadimak;
  String? grad;
  int? gradId;
  String? liga;
  int? ligaId;
  String? grb;
  String? stadion;

  KlubResponse(
      {this.klubId,
      this.naziv,
      this.godinaOsnivanja,
      this.nadimak,
      this.grad,
      this.gradId,
      this.liga,
      this.ligaId,
      this.grb,
      this.stadion});

  factory KlubResponse.fromJson(Map<String, dynamic> json) {
    return KlubResponse(
        klubId: json['klubId'] as int,
        naziv: json['naziv'] as String,
        godinaOsnivanja: json["godinaOsnivanja"] as int,
        nadimak: json['nadimak'] as String,
        grad: json['grad'] as String,
        gradId: json['gradId'] as int,
        liga: json['liga'] as String,
        ligaId: json['ligaId'] as int,
        grb: json['grb'] as String);
  }
}
