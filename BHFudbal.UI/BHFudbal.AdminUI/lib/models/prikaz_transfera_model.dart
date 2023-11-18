import 'package:bhfudbal_admin/models/response/sezona_response.dart';
import 'package:data_table_2/data_table_2.dart';
import 'package:flutter/material.dart';

class PrikazTransferaModel {
  ///  State fields for stateful widgets in this page.

  final unfocusNode = FocusNode();
  // State field(s) for DropDown widget.
  SezonaResponse? dropDownValue;
  TextEditingController? dropDownValueController;

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
