class MatchFormaResponse {
  final String klub;
  final List<String> forma;

  MatchFormaResponse({
    required this.klub,
    required this.forma,
  });

  factory MatchFormaResponse.fromJson(Map<String, dynamic> json) {
    return MatchFormaResponse(
      klub: json['klub'],
      forma: List<String>.from(json['forma']),
    );
  }
}
