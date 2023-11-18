import 'package:bhfudbal_admin/models/response/liga_response.dart';
import 'package:bhfudbal_admin/models/response/sezona_response.dart';
import 'package:data_table_2/data_table_2.dart';
import 'package:flutter/material.dart';

class PrikazUtakmicaModel {
  final unfocusNode = FocusNode();
  LigaResponse? ligaId;
  SezonaResponse? sezonaId;
  void initState(BuildContext context) {
    dataTableShowLogs = false; // Disables noisy DataTable2 debug statements.
  }

  void dispose() {
    unfocusNode.dispose();
  }
}
