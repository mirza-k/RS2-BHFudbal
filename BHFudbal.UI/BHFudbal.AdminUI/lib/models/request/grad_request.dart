class GradRequest {
  String? naziv;

  GradRequest({this.naziv});

  Map<String, dynamic> toJson(GradRequest instance) =>
      <String, dynamic>{'naziv': instance.naziv};
}