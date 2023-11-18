class TransferRequest {
  int? cijena;
  int? klubId;
  int? stariKlubId;
  int? fudbalerId;
  int? brojGodinaUgovora;

  TransferRequest(
      {this.cijena,
      this.klubId,
      this.stariKlubId,
      this.fudbalerId,
      this.brojGodinaUgovora});

  Map<String, dynamic> toJson(TransferRequest instance) => <String, dynamic>{
        'cijena': instance.cijena,
        'klubId': instance.klubId,
        'stariKlubId': instance.stariKlubId,
        'fudbalerId': instance.fudbalerId,
        'brojGodinaUgovora': instance.brojGodinaUgovora
      };
}
