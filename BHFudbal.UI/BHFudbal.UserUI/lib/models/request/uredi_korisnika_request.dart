class UrediKorisnikaRequest {
  int korisnikId;
  String username;
  String ime;
  String prezime;

  UrediKorisnikaRequest({
    required this.korisnikId,
    required this.username,
    required this.ime,
    required this.prezime,
  });

  factory UrediKorisnikaRequest.fromJson(Map<String, dynamic> json) {
    return UrediKorisnikaRequest(
      korisnikId: json['KorisnikId'],
      username: json['Username'],
      ime: json['Ime'],
      prezime: json['Prezime'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['KorisnikId'] = this.korisnikId;
    data['Username'] = this.username;
    data['Ime'] = this.ime;
    data['Prezime'] = this.prezime;
    return data;
  }
}
