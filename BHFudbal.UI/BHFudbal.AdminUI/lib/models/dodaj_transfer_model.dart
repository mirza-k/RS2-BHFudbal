import 'package:flutter/material.dart';

class DodajTransferModel {
  ///  State fields for stateful widgets in this page.

  final unfocusNode = FocusNode();
  // State field(s) for DropDown widget.
  String? ligaId;
  TextEditingController? ligaIdController;
  // State field(s) for DropDown widget.
  String? klubId;
  TextEditingController? klubIdController;
  // State field(s) for DropDown widget.
  String? fudbalerId;
  TextEditingController? fudbalerIdController;
  // State field(s) for DropDown widget.
  String? ligaTargetId;
  TextEditingController? ligaTargetIdController;
  // State field(s) for DropDown widget.
  String? klubTargetId;
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
        (ligaId != null && ligaId!.isNotEmpty) &&
        (klubId != null && klubId!.isNotEmpty) &&
        (fudbalerId != null && fudbalerId!.isNotEmpty) &&
        (ligaTargetId != null && ligaTargetId!.isNotEmpty) &&
        (klubTargetId != null && klubTargetId!.isNotEmpty);
  }

  void dispose() {
    unfocusNode.dispose();
  }

  /// Action blocks are added here.

  /// Additional helper methods are added here.
}
