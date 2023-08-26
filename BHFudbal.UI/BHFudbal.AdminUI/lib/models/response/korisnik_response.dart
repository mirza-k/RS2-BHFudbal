class KorisnikResponse {
  String? ime;
  String? prezime;
  String? username;
  String? grad;

  KorisnikResponse({this.ime, this.prezime, this.username, this.grad});

  factory KorisnikResponse.fromJson(Map<String, dynamic> json) {
    return KorisnikResponse(
        ime: json['ime'] as String,
        prezime: json['prezime'] as String,
        username: json['username'] as String,
        grad: json['grad'] as String);
  }
}
