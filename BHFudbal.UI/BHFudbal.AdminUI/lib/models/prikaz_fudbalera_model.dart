import 'package:data_table_2/data_table_2.dart';
import 'package:flutter/material.dart';

class PrikazFudbaleraModel {
  ///  State fields for stateful widgets in this page.

  final unfocusNode = FocusNode();
  // State field(s) for DropDown widget.
  String? dropDownValue1;
  TextEditingController? dropDownValueController1;
  // State field(s) for DropDown widget.
  String? dropDownValue2;
  TextEditingController? dropDownValueController2;

  /// Initialization and disposal methods.

  void initState(BuildContext context) {
    dataTableShowLogs = false; // Disables noisy DataTable2 debug statements.
  }

  void dispose() {
    unfocusNode.dispose();
  }

  /// Action blocks are added here.

  /// Additional helper methods are added here.
}
