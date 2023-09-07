// ignore_for_file: sort_child_properties_last, prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:bhfudbal_admin/models/response/liga_response.dart';
import 'package:bhfudbal_admin/pages/dodaj_fudbalera.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import '../models/prikaz_fudbalera_model.dart';
import '../models/response/fudbaler_response.dart';
import '../models/response/klub_response.dart';
import '../providers/fudbaler_provider.dart';
import '../providers/klub_provider.dart';
import '../providers/liga_provider.dart';

class PrikazFudbaleraWidget extends StatefulWidget {
  const PrikazFudbaleraWidget({Key? key}) : super(key: key);

  @override
  _PrikazFudbaleraWidgetState createState() => _PrikazFudbaleraWidgetState();
}

class _PrikazFudbaleraWidgetState extends State<PrikazFudbaleraWidget> {
  late PrikazFudbaleraModel _model;
  late LigaProvider _ligaProvider;
  late KlubProvider _klubProvider;
  late FudbalerProvider _fudbalerProvider;
  List<KlubResponse> klubResults = [];
  List<LigaResponse> ligaResults = [];
  List<FudbalerResponse> fudbalerResults = [];

  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _model = PrikazFudbaleraModel();
    _fetchLige();
  }

  @override
  void dispose() {
    _model.dispose();

    super.dispose();
  }

  Future<void> _fetchLige() async {
    _ligaProvider = context.read<LigaProvider>();
    var result = await _ligaProvider.get();
    setState(() {
      ligaResults = result.result;
    });
  }

  Future<void> _fetchKlubovi() async {
    _klubProvider = context.read<KlubProvider>();
    if (_model.ligaId != null) {
      var ligaId = _model.ligaId!.ligaId1;
      if (ligaId != null && ligaId > 0) {
        var result = await _klubProvider.get(ligaId);
        setState(() {
          _model.klubId = null;
          klubResults = result.result;
        });
      }
    }
  }

  Future<void> _fetchFudbaleri() async {
    _fudbalerProvider = context.read<FudbalerProvider>();
    if (_model.klubId != null) {
      var klubId = _model.klubId!.klubId;
      if (klubId != null && klubId != 0) {
        var result = await _fudbalerProvider.get(klubId);
        setState(() {
          fudbalerResults = result.result;
        });
      }
    }
  }

  Future<void> _navigateToChildPage(int? fudbalerId) async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) => fudbalerId != null
              ? DodajFudbaleraWidget(fudbalerId)
              : DodajFudbaleraWidget(null)),
    );

    if (result == true) {
      _fetchFudbaleri();
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
            'Prikaz fudbalera',
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
          child: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Padding(
              padding: EdgeInsets.all(20),
              child: Column(
                mainAxisSize: MainAxisSize.min,
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
                              onChanged: (val) {
                                setState(() => _model.ligaId = val!);
                                _fetchKlubovi();
                              },
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
                            child: DropdownButton<KlubResponse>(
                              isExpanded: true,
                              value: _model.klubId,
                              hint: const Text(
                                "Izaberi klub",
                                style: TextStyle(
                                  fontSize: 14,
                                  color: Colors
                                      .black, // Replace with your desired text color
                                ),
                              ),
                              onChanged: (val) =>
                                  setState(() => _model.klubId = val!),
                              items: klubResults
                                  .map((val) => DropdownMenuItem(
                                      value: val, child: Text(val.naziv ?? "")))
                                  .toList(),
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: Colors.black,
                              ),
                              icon: Icon(
                                Icons.keyboard_arrow_down_rounded,
                                color: Colors.grey,
                                size: 24,
                              ),
                              underline: SizedBox(),
                            ),
                          ),
                        ],
                      ),
                      ElevatedButton(
                        onPressed: () {
                          _fetchFudbaleri();
                        },
                        child: Text(
                          'Prikazi',
                          style: TextStyle(
                            color: Colors.white,
                            fontFamily: 'Readex Pro',
                          ),
                        ),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Theme.of(context).primaryColor,
                          textStyle: TextStyle(
                            fontFamily: 'Readex Pro',
                            color: Colors.white,
                          ),
                          elevation: 3,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8)),
                          padding: EdgeInsets.symmetric(
                              horizontal: 24, vertical: 12),
                        ),
                      ),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 30),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        DataTable(
                          columns: [
                            DataColumn(
                                label: Text(
                              'Ime',
                              style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white),
                            )),
                            DataColumn(
                                label: Text(
                              'Prezime',
                              style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white),
                            )),
                            DataColumn(
                                label: Text(
                              'Visina',
                              style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white),
                            )),
                            DataColumn(
                                label: Text(
                              'Tezina',
                              style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white),
                            )),
                            DataColumn(
                                label: Text(
                              'Klub',
                              style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white),
                            )),
                            DataColumn(
                                label: Text(
                              'Datum rodjenja',
                              style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white),
                            )),
                            DataColumn(
                                label: Text(
                              'Jaca noga',
                              style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white),
                            )),
                            DataColumn(
                              label: Text(
                                '',
                                style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white),
                              ),
                            ),
                          ],
                          rows: fudbalerResults.map((item) {
                            return DataRow(cells: [
                              DataCell(Text(item.ime ?? "",
                                  style: TextStyle(fontSize: 14))),
                              DataCell(Text(item.prezime ?? "",
                                  style: TextStyle(fontSize: 14))),
                              DataCell(Text(item.visina ?? "",
                                  style: TextStyle(fontSize: 14))),
                              DataCell(Text(item.tezina ?? "",
                                  style: TextStyle(fontSize: 14))),
                              DataCell(Text(item.klub ?? "",
                                  style: TextStyle(fontSize: 14))),
                              DataCell(Text(
                                  DateFormat('yyyy-MM-dd').format(
                                      DateTime.parse(item.datumRodjenja ?? "")),
                                  style: TextStyle(fontSize: 14))),
                              DataCell(Text(item.jacaNoga ?? "",
                                  style: TextStyle(fontSize: 14))),
                              DataCell(TextButton(
                                onPressed: () {
                                  // Call the update function with the ID of the clicked row
                                  // _updateRow(data.id);
                                  _navigateToChildPage(item.fudbalerId);
                                },
                                child: Text('Uredi'),
                              )),
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
                        ),
                      ],
                    ),
                  ),
                  Flexible(
                    child: Padding(
                      padding: const EdgeInsets.only(top: 20),
                      child: Row(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.end,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          ElevatedButton(
                            onPressed: () {
                              _navigateToChildPage(null);
                            },
                            child: Text(
                              'Dodaj fudbalera',
                              style: TextStyle(
                                color: Colors.white,
                                fontFamily: 'Readex Pro',
                              ),
                            ),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Theme.of(context).primaryColor,
                              textStyle: TextStyle(
                                color: Colors.white,
                              ),
                              elevation: 3,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8)),
                              padding: EdgeInsets.symmetric(
                                  horizontal: 24, vertical: 12),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
