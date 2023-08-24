import 'package:flutter/material.dart';

class DodajFudbaleraModel {
  final unfocusNode = FocusNode();
  // State field(s) for TextField widget.
  TextEditingController? ime;
  String? Function(BuildContext, String?)? imeValidator;
  // State field(s) for TextField widget.
  TextEditingController? prezime;
  String? Function(BuildContext, String?)? prezimeValidator;
  DateTime? datePicked;
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
  String? klubId;
  TextEditingController? klubIdController;
  // State field(s) for DropDown widget.
  void initState(BuildContext context) {}

  bool areTextFieldsValid(bool imeValid, bool prezimeValid, bool visinaValid,
      bool tezinaValid, bool jacaNogaValid) {
    return imeValid &&
        prezimeValid &&
        visinaValid &&
        tezinaValid &&
        jacaNogaValid &&
        klubId != null &&
        klubId!.isNotEmpty;
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
