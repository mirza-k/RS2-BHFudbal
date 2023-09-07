import 'package:bhfudbal_admin/models/response/sezona_response.dart';
import 'package:flutter/material.dart';

class IzvjestajModel {
  ///  State fields for stateful widgets in this page.

  final unfocusNode = FocusNode();
  // State field(s) for DropDown widget.
  SezonaResponse? dropDownValue;
  TextEditingController? dropDownValueController;

  /// Initialization and disposal methods.

  void initState(BuildContext context) {}

  bool areTextFieldsValid() {
    return (dropDownValue != null && dropDownValue!.sezonaId != 0);
  }

  void dispose() {
    unfocusNode.dispose();
  }

  /// Action blocks are added here.

  /// Additional helper methods are added here.
}
