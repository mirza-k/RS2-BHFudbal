class MatchDetailsResponse {
  int? matchId;
  String? rezultat;
  String? domaci;
  String? gosti;
  List<GolDetails>? golDetails;
  List<ZutiKartonDetails>? zutiKartonDetails;
  List<CrveniKartonDetails>? crveniKartonDetails;
  List<String>? postaveDomaci;
  List<String>? postaveGosti;
  String? domaciSlika;
  String? gostiSlika;

  MatchDetailsResponse(
      {this.matchId,
      this.rezultat,
      this.golDetails,
      this.zutiKartonDetails,
      this.crveniKartonDetails,
      this.postaveDomaci,
      this.postaveGosti,
      this.domaci,
      this.gosti,
      this.domaciSlika,
      this.gostiSlika});

  // Factory constructor to create a MatchDetailsResponse object from JSON data.
  factory MatchDetailsResponse.fromJson(Map<String, dynamic> json) {
    return MatchDetailsResponse(
      matchId: json['matchId'] as int?,
      rezultat: json['rezultat'] as String?,
      domaci: json['domaci'] as String?,
      gosti: json['gosti'] as String?,
      domaciSlika: json['domaciSlika'] as String?,
      gostiSlika: json['gostiSlika'] as String?,
      golDetails: (json['golDetails'] as List<dynamic>?)
          ?.map((dynamic e) => GolDetails.fromJson(e as Map<String, dynamic>))
          .toList(),
      zutiKartonDetails: (json['zutiKartonDetails'] as List<dynamic>?)
          ?.map((dynamic e) =>
              ZutiKartonDetails.fromJson(e as Map<String, dynamic>))
          .toList(),
      crveniKartonDetails: (json['crveniKartonDetails'] as List<dynamic>?)
          ?.map((dynamic e) =>
              CrveniKartonDetails.fromJson(e as Map<String, dynamic>))
          .toList(),
      postaveDomaci: (json['postaveDomaci'] as List<dynamic>?)
          ?.map((dynamic e) => e as String)
          .toList(),
      postaveGosti: (json['postaveGosti'] as List<dynamic>?)
          ?.map((dynamic e) => e as String)
          .toList(),
    );
  }
}

class GolDetails {
  String? imeFudbalera;
  int? minutaGola;
  int? klubId;
  bool? domacin;

  GolDetails({this.imeFudbalera, this.minutaGola, this.klubId, this.domacin});

  factory GolDetails.fromJson(Map<String, dynamic> json) {
    return GolDetails(
        imeFudbalera: json['imeFudbalera'] as String?,
        minutaGola: json['minutaGola'] as int?,
        klubId: json['klubId'] as int?,
        domacin: json['domacin'] as bool);
  }
}

class ZutiKartonDetails {
  String? imeFudbalera;
  int? minutaKartona;
  int? klubId;
  bool? domacin;

  ZutiKartonDetails(
      {this.imeFudbalera, this.minutaKartona, this.klubId, this.domacin});

  factory ZutiKartonDetails.fromJson(Map<String, dynamic> json) {
    return ZutiKartonDetails(
        imeFudbalera: json['imeFudbalera'] as String?,
        minutaKartona: json['minutaKartona'] as int?,
        klubId: json['klubId'] as int?,
        domacin: json['domacin'] as bool);
  }
}

class CrveniKartonDetails {
  String? imeFudbalera;
  int? minutaKartona;
  int? klubId;
  bool? domacin;

  CrveniKartonDetails(
      {this.imeFudbalera, this.minutaKartona, this.klubId, this.domacin});

  factory CrveniKartonDetails.fromJson(Map<String, dynamic> json) {
    return CrveniKartonDetails(
        imeFudbalera: json['imeFudbalera'] as String?,
        minutaKartona: json['minutaKartona'] as int?,
        klubId: json['klubId'] as int?,
        domacin: json['domacin'] as bool);
  }
}
