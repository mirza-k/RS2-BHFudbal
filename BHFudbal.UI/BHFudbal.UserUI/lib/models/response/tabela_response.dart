class TabelaResponse {
  final String nazivKluba;
  final int brojBodova;
  final int brojOdigranihUtakmica;

  TabelaResponse(
      {required this.nazivKluba,
      required this.brojBodova,
      required this.brojOdigranihUtakmica});

  factory TabelaResponse.fromJson(Map<String, dynamic> json) {
    return TabelaResponse(
      nazivKluba: json['nazivKluba'],
      brojBodova: json['brojBodova'],
      brojOdigranihUtakmica: json['brojOdigranihUtakmica'],
    );
  }
}
