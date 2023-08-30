import 'dart:typed_data';

import 'package:bhfudbal_admin/models/response/klub_response.dart';
import 'package:flutter/material.dart';

class DodajFudbaleraModel {
  final unfocusNode = FocusNode();
  // State field(s) for TextField widget.
  TextEditingController? ime;
  String? Function(BuildContext, String?)? imeValidator;
  // State field(s) for TextField widget.
  TextEditingController? prezime;
  String? Function(BuildContext, String?)? prezimeValidator;
  DateTime? datumRodjenja;
  // State field(s) for TextField widget.
  TextEditingController? visina;
  String? Function(BuildContext, String?)? visinaValidator;
  // State field(s) for TextField widget.
  TextEditingController? tezina;
  String? Function(BuildContext, String?)? tezinaValidator;
  // State field(s) for DropDown widget.
  TextEditingController? jacaNoga;
  String? Function(BuildContext, String?)? jacaNogaValidator;
  // State field(s) for DropDown widget.
  KlubResponse? klub;
  TextEditingController? klubIdController;

  Uint8List? slika;
  // State field(s) for DropDown widget.
  void initState(BuildContext context) {}

  bool areTextFieldsValid(bool imeValid, bool prezimeValid, bool visinaValid,
      bool tezinaValid, bool jacaNogaValid, base64Image, bool uredi) {
    return imeValid &&
        prezimeValid &&
        visinaValid &&
        tezinaValid &&
        jacaNogaValid &&
        datumRodjenja != null &&
        base64Image != null &&
        (uredi == true || (klub != null && klub!.naziv!.isNotEmpty));
  }

  void dispose() {
    unfocusNode.dispose();
    ime?.dispose();
    prezime?.dispose();
    visina?.dispose();
    tezina?.dispose();
    jacaNoga?.dispose();
  }
}
