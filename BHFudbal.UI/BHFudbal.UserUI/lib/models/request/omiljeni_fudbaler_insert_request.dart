class OmiljeniFudbalerInsertRequest {
  int? korisnikId;
  int? fudbalerId;
  int? rating;

  OmiljeniFudbalerInsertRequest({
    this.korisnikId,
    this.fudbalerId,
    this.rating,
  });

  Map<String, dynamic> toJson(OmiljeniFudbalerInsertRequest instance) => <String, dynamic>{
        'korisnikId': instance.korisnikId,
        'fudbalerId': instance.fudbalerId,
        'rating': instance.rating
      };
}
