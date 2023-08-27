class KlubRequest {
  String? naziv;
  int? godinaOsnivanja;
  String? nadimak;
  int? gradId;
  int? ligaId;
  String? grb;

  KlubRequest(
      {this.naziv,
      this.nadimak,
      this.godinaOsnivanja,
      this.gradId,
      this.ligaId,
      this.grb});

  Map<String, dynamic> toJson(KlubRequest instance) => <String, dynamic>{
        'naziv': instance.naziv,
        'godinaOsnivanja': instance.godinaOsnivanja,
        'nadimak': instance.nadimak,
        'gradId': instance.gradId,
        'ligaId': instance.ligaId,
        'grb': instance.grb
      };
}
