class MatchStrijelciResponse {
  final int brojGolova;
  final String nazivFudbalera;

  MatchStrijelciResponse({
    required this.brojGolova,
    required this.nazivFudbalera,
  });

  factory MatchStrijelciResponse.fromJson(Map<String, dynamic> json) {
    return MatchStrijelciResponse(
      brojGolova: json['brojGolova'],
      nazivFudbalera: json['nazivFudbalera'],
    );
  }
}
