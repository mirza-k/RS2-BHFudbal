import 'dart:typed_data';

import 'package:bhfudbal_admin/models/response/grad_response.dart';
import 'package:bhfudbal_admin/models/response/liga_response.dart';
import 'package:flutter/material.dart';

class DodajKlubModel {
  final unfocusNode = FocusNode();
  TextEditingController? textController1;
  String? Function(BuildContext, String?)? textController1Validator;
  TextEditingController? textController2;
  String? Function(BuildContext, String?)? textController2Validator;
  TextEditingController? textController3;
  String? Function(BuildContext, String?)? textController3Validator;
  GradResponse? dropDownValue1;
  TextEditingController? dropDownValueController1;
  LigaResponse? dropDownValue2;
  TextEditingController? dropDownValueController2;
  Uint8List? grb;

  bool areTextFieldsValid(bool nazivKlubaValid, bool nadimakKlubaValid,
      bool osnivanjeKlubaValid, String? base64Image, bool uredi) {
    return nazivKlubaValid &&
        nadimakKlubaValid &&
        osnivanjeKlubaValid &&
        dropDownValue1 != null &&
        dropDownValue1!.naziv!.isNotEmpty &&
        base64Image != null &&
        (uredi == true ||
            (dropDownValue2 != null && dropDownValue2!.naziv!.isNotEmpty));
  }

  void initState(BuildContext context) {}
  void dispose() {
    unfocusNode.dispose();
    textController1?.dispose();
    textController2?.dispose();
    textController3?.dispose();
  }
}
