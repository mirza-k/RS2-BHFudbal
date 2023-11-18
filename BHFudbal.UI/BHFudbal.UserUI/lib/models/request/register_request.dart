class RegisterRequest {
  String? username;
  String? password;
  String? ime;
  String? prezime;
  DateTime? datumRodjenja;

  RegisterRequest(
      {this.ime, this.prezime, this.username, this.password, this.datumRodjenja});

  Map<String, dynamic> toJson(RegisterRequest instance) => <String, dynamic>{
        'username': instance.username,
        'password': instance.password,
        'ime': instance.ime,
        'prezime': instance.prezime,
        'datumRodjenja': instance.datumRodjenja!.toIso8601String(),
      };
}
