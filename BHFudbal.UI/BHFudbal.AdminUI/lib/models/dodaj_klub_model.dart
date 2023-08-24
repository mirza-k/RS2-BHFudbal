import 'package:flutter/material.dart';

class DodajKlubModel {
  ///  State fields for stateful widgets in this page.

  final unfocusNode = FocusNode();
  // State field(s) for TextField widget.
  TextEditingController? textController1;
  String? Function(BuildContext, String?)? textController1Validator;
  // State field(s) for TextField widget.
  TextEditingController? textController2;
  String? Function(BuildContext, String?)? textController2Validator;
  // State field(s) for TextField widget.
  TextEditingController? textController3;
  String? Function(BuildContext, String?)? textController3Validator;
  // State field(s) for DropDown widget.
  String? dropDownValue1;
  TextEditingController? dropDownValueController1;
  // State field(s) for DropDown widget.
  String? dropDownValue2;
  TextEditingController? dropDownValueController2;

  bool areTextFieldsValid(
      bool nazivKlubaValid, bool nadimakKlubaValid, bool osnivanjeKlubaValid) {
    return nazivKlubaValid &&
        nadimakKlubaValid &&
        osnivanjeKlubaValid &&
        dropDownValue1 != null &&
        dropDownValue1!.isNotEmpty &&
        dropDownValue2 != null &&
        dropDownValue2!.isNotEmpty;
  }

  /// Initialization and disposal methods.

  void initState(BuildContext context) {}

  void dispose() {
    unfocusNode.dispose();
    textController1?.dispose();
    textController2?.dispose();
    textController3?.dispose();
  }

  /// Action blocks are added here.

  /// Additional helper methods are added here.
}
