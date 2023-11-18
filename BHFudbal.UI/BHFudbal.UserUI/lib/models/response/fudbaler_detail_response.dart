class FudbalerDetailResponse {
  final String imePrezime;
  final String klub;
  final String datumRodjenja;
  final String visina;
  final String tezina;
  final String jacaNoga;
  final List<FudbalerDetailsMatch> utakmice;

  FudbalerDetailResponse({
    required this.imePrezime,
    required this.klub,
    required this.datumRodjenja,
    required this.visina,
    required this.tezina,
    required this.jacaNoga,
    required this.utakmice,
  });

  factory FudbalerDetailResponse.fromJson(Map<String, dynamic> json) {
    List<dynamic> matchList = json['utakmice'];
    List<FudbalerDetailsMatch> matches = matchList.map((matchJson) {
      return FudbalerDetailsMatch.fromJson(matchJson);
    }).toList();

    return FudbalerDetailResponse(
      imePrezime: json['imePrezime'],
      klub: json['klub'],
      datumRodjenja: json['datumRodjenja'],
      visina: json['visina'],
      tezina: json['tezina'],
      jacaNoga: json['jacaNoga'],
      utakmice: matches,
    );
  }
}

class FudbalerDetailsMatch {
  final int matchId;
  final String rezultat;
  final int golovi;
  final int zutiKartoni;
  final int crveniKartoni;

  FudbalerDetailsMatch({
    required this.matchId,
    required this.rezultat,
    required this.golovi,
    required this.zutiKartoni,
    required this.crveniKartoni,
  });

  factory FudbalerDetailsMatch.fromJson(Map<String, dynamic> json) {
    return FudbalerDetailsMatch(
      matchId: json['matchId'],
      rezultat: json['rezultat'],
      golovi: json['golovi'],
      zutiKartoni: json['zutiKartoni'],
      crveniKartoni: json['crveniKartoni'],
    );
  }
}
