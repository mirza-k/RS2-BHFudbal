// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables
import 'package:bhfudbal_admin/models/response/grad_response.dart';
import 'package:bhfudbal_admin/models/response/klub_response.dart';
import 'package:bhfudbal_admin/models/response/liga_response.dart';
import 'package:bhfudbal_admin/pages/dodaj_klub.dart';
import 'package:bhfudbal_admin/pages/login.dart';
import 'package:bhfudbal_admin/providers/grad_provider.dart';
import 'package:bhfudbal_admin/providers/klub_provider.dart';
import 'package:bhfudbal_admin/providers/liga_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/prikaz_klubova_model.dart';

class PrikazKlubovaWidget extends StatefulWidget {
  const PrikazKlubovaWidget({Key? key}) : super(key: key);

  @override
  _PrikazKlubovaWidgetState createState() => _PrikazKlubovaWidgetState();
}

class _PrikazKlubovaWidgetState extends State<PrikazKlubovaWidget> {
  late PrikazKlubovaModel _model;
  late LigaProvider _ligaProvider;
  late KlubProvider _klubProvider;
  late GradProvider _gradProvider;

  List<LigaResponse> ligaResults = [];
  List<KlubResponse> klubResults = [];
  List<GradResponse> gradResults = [];

  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _model = PrikazKlubovaModel();
    _fetchLige();
    _fetchGradovi();
  }

  Future<void> _fetchLige() async {
    _ligaProvider = context.read<LigaProvider>();
    var result = await _ligaProvider.get(true);
    setState(() {
      ligaResults = result.result;
    });
  }

  Future<void> _fetchGradovi() async {
    _gradProvider = context.read<GradProvider>();
    var result = await _gradProvider.get();
    setState(() {
      gradResults = result.result;
    });
  }

  Future<void> _fetchKlubovi() async {
    _klubProvider = context.read<KlubProvider>();
    if (_model.dropDownValue != null) {
      var ligaId = _model.dropDownValue!.ligaId1;
      if (ligaId != null && ligaId > 0) {
        var result = await _klubProvider.get(ligaId);
        setState(() {
          klubResults = result.result;
        });
      }
    }
  }

  Future<void> _navigateToChildPage(int? klubId) async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) => klubId != null
              ? DodajKlubWidget(klubId, ligaResults, gradResults)
              : DodajKlubWidget(null, null, null)),
    );

    if (result == true) {
      _fetchKlubovi();
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
            'Prikaz klubova',
            style: TextStyle(
              fontFamily: 'Outfit',
              color: Colors.white,
              fontSize: 22,
            ),
          ),
          actions: [
            IconButton(
              icon: Icon(Icons.logout, color: Colors.white),
              onPressed: () {
                // Navigate to the logout page or perform logout logic
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) =>
                            LoginWidget())); // Replace '/logout' with your logout page route
              },
            ),
          ],
          centerTitle: false,
          elevation: 2,
        ),
        body: SafeArea(
          top: true,
          child: Padding(
            padding: EdgeInsets.all(20),
            child: Column(
              mainAxisSize: MainAxisSize.max,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Padding(
                      padding: EdgeInsets.only(bottom: 20),
                      child: Container(
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
                          isExpanded: true,
                          value: _model.dropDownValue,
                          hint: const Text(
                            "Izaberi ligu",
                            style: TextStyle(
                              fontSize: 14,
                              color: Colors
                                  .black, // Replace with your desired text color
                            ),
                          ),
                          onChanged: (val) =>
                              setState(() => _model.dropDownValue = val!),
                          items: ligaResults
                              .map((val) => DropdownMenuItem<LigaResponse>(
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
                    ),
                    ElevatedButton(
                      onPressed: () async {
                        await _fetchKlubovi();
                        print('Prikaz pressed ...');
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Theme.of(context).primaryColor,
                      ),
                      child: Text(
                        'Prikazi',
                        style: TextStyle(
                          fontFamily: 'Readex Pro',
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Expanded(
                      child: DataTable(
                        columns: [
                          DataColumn(
                            label: Text(
                              'Naziv',
                              style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white),
                            ),
                          ),
                          DataColumn(
                            label: Text(
                              'Grad',
                              style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white),
                            ),
                          ),
                          DataColumn(
                            label: Text(
                              'Godina osnivanja',
                              style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white),
                            ),
                          ),
                          DataColumn(
                            label: Text(
                              'Liga',
                              style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white),
                            ),
                          ),
                          DataColumn(
                            label: Text(
                              'Nadimak',
                              style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white),
                            ),
                          ),
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
                        rows: klubResults.map((data) {
                          return DataRow(cells: [
                            DataCell(Text(data.naziv ?? "")),
                            DataCell(Text(data.grad ?? "")),
                            DataCell(Text(data.godinaOsnivanja != null
                                ? data.godinaOsnivanja.toString()
                                : "")),
                            DataCell(Text(data.liga ?? "")),
                            DataCell(Text(data.nadimak ?? "")),
                            DataCell(TextButton(
                              onPressed: () {
                                // Call the update function with the ID of the clicked row
                                // _updateRow(data.id);
                                _navigateToChildPage(data.klubId);
                              },
                              child: Text('Update'),
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
                    ),
                  ],
                ),
                Flexible(
                  child: Padding(
                    padding: const EdgeInsets.only(top: 20),
                    child: Row(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        ElevatedButton(
                          onPressed: () => _navigateToChildPage(null),
                          style: ElevatedButton.styleFrom(
                            primary: Theme.of(context).primaryColor,
                          ),
                          child: Text(
                            'Dodaj klub',
                            style: TextStyle(
                              fontFamily: 'Readex Pro',
                              color: Colors.white,
                            ),
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
    );
  }
}

class DataTableRecord {
  String column1;
  String column2;
  String column3;
  String column4;
  String column5;

  DataTableRecord({
    required this.column1,
    required this.column2,
    required this.column3,
    required this.column4,
    required this.column5,
  });
}
