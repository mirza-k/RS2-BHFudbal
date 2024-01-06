// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables
import 'package:bhfudbal_admin/models/response/grad_response.dart';
import 'package:bhfudbal_admin/models/response/klub_response.dart';
import 'package:bhfudbal_admin/models/response/liga_response.dart';
import 'package:bhfudbal_admin/pages/dodaj_grad.dart';
import 'package:bhfudbal_admin/pages/dodaj_klub.dart';
import 'package:bhfudbal_admin/providers/grad_provider.dart';
import 'package:bhfudbal_admin/providers/klub_provider.dart';
import 'package:bhfudbal_admin/providers/liga_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/prikaz_klubova_model.dart';

class PrikazGradWidget extends StatefulWidget {
  const PrikazGradWidget({Key? key}) : super(key: key);

  @override
  _PrikazGradWidgetState createState() => _PrikazGradWidgetState();
}

class _PrikazGradWidgetState extends State<PrikazGradWidget> {
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
  }

  Future<void> _fetchGradovi() async {
    _gradProvider = context.read<GradProvider>();
    var result = await _gradProvider.get();
    setState(() {
      gradResults = result.result;
    });
  }

  Future<void> _navigateToChildPage(int? klubId) async {
    final result = await Navigator.push(
        context, MaterialPageRoute(builder: (context) => DodajGradWidget()));

    if (result == true) {
      _fetchGradovi();
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
            'Prikaz Gradova',
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
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    ElevatedButton(
                      onPressed: () async {
                        await _fetchGradovi();
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
                Padding(
                  padding: const EdgeInsets.only(top: 10),
                  child: Row(
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
                            )
                          ],
                          rows: gradResults.map((data) {
                            return DataRow(
                                cells: [DataCell(Text(data.naziv ?? ""))]);
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
                            'Dodaj grad',
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

  DataTableRecord({
    required this.column1,
  });
}
