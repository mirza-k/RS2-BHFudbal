import 'package:bhfudbal_admin/models/response/fudbaler_response.dart';
import 'package:bhfudbal_admin/models/response/klub_response.dart';
import 'package:bhfudbal_admin/models/response/liga_response.dart';
import 'package:flutter/material.dart';

class DodajTransferModel {
  ///  State fields for stateful widgets in this page.

  final unfocusNode = FocusNode();
  // State field(s) for DropDown widget.
  LigaResponse? liga;
  TextEditingController? ligaIdController;
  // State field(s) for DropDown widget.
  KlubResponse? klub;
  TextEditingController? klubIdController;
  // State field(s) for DropDown widget.
  FudbalerResponse? fudbaler;
  TextEditingController? fudbalerIdController;
  // State field(s) for DropDown widget.
  LigaResponse? ligaTarget;
  TextEditingController? ligaTargetIdController;
  // State field(s) for DropDown widget.
  KlubResponse? klubTarget;
  TextEditingController? klubTargetIdController;
  // State field(s) for DropDown widget.
  TextEditingController? cijenaController;
  String? Function(BuildContext, String?)? cijenaControllerValidator;

  TextEditingController? godineUgovoraController;
  String? Function(BuildContext, String?)? godineUgovoraControllerValidator;

  void initState(BuildContext context) {}

  bool areTextFieldsValid(cijenaValid, godineUgovoraValid) {
    return cijenaValid &&
        godineUgovoraValid &&
        (liga != null && liga!.naziv!.isNotEmpty) &&
        (klub != null && klub!.klubId != 0) &&
        (fudbaler != null && fudbaler!.fudbalerId != 0) &&
        (ligaTarget != null && ligaTarget!.ligaId1 != 0) &&
        (klubTarget != null && klubTarget!.klubId != 0);
  }

  void dispose() {
    unfocusNode.dispose();
  }

  /// Action blocks are added here.

  /// Additional helper methods are added here.
}
