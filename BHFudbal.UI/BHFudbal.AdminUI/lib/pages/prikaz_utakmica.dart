// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors, sort_child_properties_last, library_private_types_in_public_api
import 'package:bhfudbal_admin/models/response/sezona_response.dart';
import 'package:bhfudbal_admin/models/response/utakmice_response.dart';
import 'package:bhfudbal_admin/providers/sezona_provider.dart';
import 'package:bhfudbal_admin/providers/utakmice_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/prikaz_utamica_model.dart';
import '../models/response/liga_response.dart';
import '../providers/liga_provider.dart';

class PrikazUtakmicaWidget extends StatefulWidget {
  const PrikazUtakmicaWidget({Key? key}) : super(key: key);

  @override
  _PrikazUtakmicaWidgetState createState() => _PrikazUtakmicaWidgetState();
}

class _PrikazUtakmicaWidgetState extends State<PrikazUtakmicaWidget> {
  late PrikazUtakmicaModel _model;
  late LigaProvider _ligaProvider;
  late SezonaProvider _sezonaProvider;
  late UtakmiceProvider _utakmiceProvider;

  List<LigaResponse> ligaResults = [];
  List<SezonaResponse> sezonaResults = [];
  List<UtakmiceResponse> utakmiceResults = [];

  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _model = PrikazUtakmicaModel();
    _fetchSezone();
  }

  @override
  void dispose() {
    _model.dispose();

    super.dispose();
  }

  Future<void> _fetchLige() async {
    _ligaProvider = context.read<LigaProvider>();
    if (_model.sezonaId != null) {
      var sezonaId = _model.sezonaId!.sezonaId;
      if (sezonaId != null && sezonaId != 0) {
        var result =
            await _ligaProvider.getBySezonaId(_model.sezonaId!.sezonaId);
        setState(() {
          ligaResults = result.result;
        });
      }
    }
  }

  Future<void> _fetchSezone() async {
    _sezonaProvider = context.read<SezonaProvider>();
    var result = await _sezonaProvider.get();
    setState(() {
      sezonaResults = result.result;
    });
  }

  Future<void> _fetchUtakmice() async {
    _utakmiceProvider = context.read<UtakmiceProvider>();
    if (_model.ligaId != null) {
      var ligaId = _model.ligaId!.ligaId1;
      if (ligaId != null && ligaId != 0) {
        var result = await _utakmiceProvider.get(ligaId);
        setState(() {
          utakmiceResults = result.result;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).requestFocus(_model.unfocusNode),
      child: Scaffold(
        key: scaffoldKey,
        backgroundColor: Theme.of(context).secondaryHeaderColor,
        appBar: AppBar(
          backgroundColor: Theme.of(context).primaryColor,
          automaticallyImplyLeading: false,
          title: Text(
            'Prikaz utakmica',
            style: TextStyle(
              fontFamily: 'Outfit',
              color: Colors.white,
              fontSize: 22,
            ),
          ),
          actions: [],
          centerTitle: false,
          elevation: 2,
        ),
        body: SafeArea(
          top: true,
          child: Padding(
            padding: EdgeInsets.all(20),
            child: Column(
              mainAxisSize: MainAxisSize.max,
              children: [
                Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Container(
                          width: 300,
                          height: 50,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(8),
                            border: Border.all(
                              color: Colors.grey,
                              width: 2,
                            ),
                          ),
                          padding: EdgeInsets.symmetric(horizontal: 16),
                          child: DropdownButton<SezonaResponse>(
                            isExpanded: true,
                            value: _model.sezonaId,
                            onChanged: (val) {
                              setState(() => _model.sezonaId = val!);
                              _model.ligaId = null;
                              _fetchLige();
                            },
                            items: sezonaResults
                                .map((val) => DropdownMenuItem(
                                    value: val, child: Text(val.naziv ?? "")))
                                .toList(),
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                            ),
                            hint: Text(
                              'Izaberi sezonu',
                              style: TextStyle(
                                fontSize: 14,
                                color: Colors
                                    .black, // Replace with your desired text color
                              ),
                            ),
                            icon: Icon(
                              Icons.keyboard_arrow_down_rounded,
                              color: Colors.grey,
                              size: 24,
                            ),
                            underline: SizedBox(),
                          ),
                        ),
                        SizedBox(width: 20),
                        Container(
                          width: 300,
                          height: 50,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(8),
                            border: Border.all(
                              color: Colors.grey,
                              width: 2,
                            ),
                          ),
                          padding: EdgeInsets.symmetric(horizontal: 16),
                          child: DropdownButton<LigaResponse>(
                            value: _model.ligaId,
                            isExpanded: true,
                            icon: Icon(
                              Icons.keyboard_arrow_down_rounded,
                              color: Colors.grey,
                              size: 24,
                            ),
                            hint: const Text(
                              "Izaberi ligu",
                              style: TextStyle(
                                fontSize: 14,
                                color: Colors
                                    .black, // Replace with your desired text color
                              ),
                            ),
                            onChanged: (val) =>
                                setState(() => _model.ligaId = val!),
                            items: ligaResults
                                .map((val) => DropdownMenuItem(
                                    value: val, child: Text(val.naziv ?? "")))
                                .toList(),
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                            ),
                            underline: SizedBox(),
                          ),
                        ),
                      ],
                    ),
                    ElevatedButton(
                      onPressed: () {
                        _fetchUtakmice();
                      },
                      child: Text(
                        'Prikazi',
                        style: TextStyle(
                          fontFamily: 'Readex Pro',
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Theme.of(context)
                            .primaryColor, // Replace with your desired button color.
                        elevation: 3,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                        padding: EdgeInsets.symmetric(horizontal: 24),
                      ),
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    DataTable(
                      columns: [
                        DataColumn(
                          label: Text(
                            'Rezultati',
                            style: TextStyle(fontSize: 16, color: Colors.white),
                          ),
                        ),
                        // DataColumn(
                        //   label: Text(
                        //     'Rezultat',
                        //     style: TextStyle(
                        //         fontSize: 16,
                        //         fontWeight: FontWeight.bold,
                        //         color: Colors.white),
                        //   ),
                        // ),
                        // DataColumn(
                        //   label: Text(
                        //     'Gost',
                        //     style: TextStyle(
                        //         fontSize: 16,
                        //         fontWeight: FontWeight.bold,
                        //         color: Colors.white),
                        //   ),
                        // ),
                      ],
                      rows: utakmiceResults.map((data) {
                        return DataRow(cells: [
                          DataCell(Text(data.prikaz ?? "")),
                          // DataCell(Text(data.column2)),
                          // DataCell(Text(data.column3)),
                        ]);
                      }).toList(),
                      headingRowColor: MaterialStateProperty.all(
                        Theme.of(context).primaryColor,
                      ),
                      headingRowHeight: 56,
                      dataRowColor: MaterialStateProperty.all(
                        Colors.white,
                      ),
                      dataRowHeight: 56,
                      border: TableBorder(
                        borderRadius: BorderRadius.circular(0),
                      ),
                      dividerThickness: 1,
                      showBottomBorder: true,
                    )
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class DataTableRecord {
  final String column1;
  final String column2;
  final String column3;

  DataTableRecord(
      {required this.column1, required this.column2, required this.column3});
}
