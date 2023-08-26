import 'package:bhfudbal_admin/models/response/klub_response.dart';
import 'package:bhfudbal_admin/models/response/liga_response.dart';
import 'package:data_table_2/data_table_2.dart';
import 'package:flutter/material.dart';

class PrikazFudbaleraModel {
  final unfocusNode = FocusNode();
  LigaResponse? ligaId;
  KlubResponse? klubId;
  String? r;

  void initState(BuildContext context) {
    dataTableShowLogs = false; // Disables noisy DataTable2 debug statements.
  }

  void dispose() {
    unfocusNode.dispose();
  }
}
