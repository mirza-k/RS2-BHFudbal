class UpdateToPremiumKorisnik {
  String? username;
  String? password;

  UpdateToPremiumKorisnik({this.username, this.password});

  Map<String, dynamic> toJson(UpdateToPremiumKorisnik instance) =>
      <String, dynamic>{
        'username': instance.username,
        'password': instance.password
      };
}