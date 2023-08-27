class GradResponse {
  int? gradId;
  String? naziv;

  GradResponse({this.gradId, this.naziv});

  factory GradResponse.fromJson(Map<String, dynamic> json) {
    return GradResponse(
        gradId: json['gradId'] as int, naziv: json['naziv'] as String);
  }
}
