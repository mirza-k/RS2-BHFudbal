// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, sort_child_properties_last
import 'package:bhfudbal_admin/models/response/transfer_response.dart';
import 'package:bhfudbal_admin/pages/dodaj_transfer.dart';
import 'package:bhfudbal_admin/providers/transfer_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/prikaz_transfera_model.dart';
import '../models/response/sezona_response.dart';
import '../providers/sezona_provider.dart';
import 'login.dart';

class PrikazTransferaWidget extends StatefulWidget {
  const PrikazTransferaWidget({Key? key}) : super(key: key);

  @override
  _PrikazTransferaWidgetState createState() => _PrikazTransferaWidgetState();
}

class _PrikazTransferaWidgetState extends State<PrikazTransferaWidget> {
  late PrikazTransferaModel _model;
  late TransferProvider _transferProvider;
  late SezonaProvider _sezonaProvider;
  List<SezonaResponse> sezonaResults = [];
  List<TransferResponse> transferResults = [];
  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _model = PrikazTransferaModel();
    _fetchSezone();
  }

  Future<void> _navigateToChildPage() async {
    final result = await Navigator.push(context,
        MaterialPageRoute(builder: (context) => DodajTransferWidget()));

    if (result == true) {
      _fetchTransferi();
    }
  }

  Future<void> _fetchSezone() async {
    _sezonaProvider = context.read<SezonaProvider>();
    var result = await _sezonaProvider.get();
    setState(() {
      sezonaResults = result.result;
    });
  }

  Future<void> _fetchTransferi() async {
    if (_model.dropDownValue != null) {
      var sezonaId = _model.dropDownValue!.sezonaId;
      if (sezonaId != null && sezonaId > 0) {
        _transferProvider = context.read<TransferProvider>();
        var result = await _transferProvider.get(sezonaId);
        setState(() {
          transferResults = result.result;
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
            'Prikaz transfera',
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
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SizedBox(
                      width: 200,
                      child: Padding(
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
                          child: DropdownButton<SezonaResponse>(
                            isExpanded: true,
                            value: _model.dropDownValue,
                            onChanged: (val) =>
                                setState(() => _model.dropDownValue = val!),
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
                      ),
                    ),
                    SizedBox(width: 16),
                    ElevatedButton(
                      onPressed: () {
                        _fetchTransferi();
                      },
                      child: Text('Prikazi',
                          style: TextStyle(
                            fontFamily: 'Readex Pro',
                            color: Colors.white,
                          )),
                      style: ElevatedButton.styleFrom(
                        primary: Theme.of(context)
                            .primaryColor, // Replace with your desired button color
                        textStyle: TextStyle(
                          fontFamily: 'Readex Pro',
                          color: Colors
                              .white, // Replace with your desired text color
                        ),
                        elevation: 3,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 10),
                      child: ElevatedButton(
                        onPressed: () => _navigateToChildPage(),
                        child: Text(
                          'Dodaj transfer',
                          style: TextStyle(
                            fontFamily: 'Readex Pro',
                            color: Colors.white,
                          ),
                        ),
                        style: ElevatedButton.styleFrom(
                          primary: Theme.of(context)
                              .primaryColor, // Replace with your desired button color
                          elevation: 3,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 20),
                Expanded(
                  child: SingleChildScrollView(
                    child: DataTable(
                      columns: [
                        DataColumn(
                          label: Text(
                            'Fudbaler',
                            style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                                color: Colors.white),
                          ),
                        ),
                        DataColumn(
                          label: Text(
                            'Cijena',
                            style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                                color: Colors.white),
                          ),
                        ),
                        DataColumn(
                          label: Text(
                            'Godine ugovora',
                            style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                                color: Colors.white),
                          ),
                        ),
                        DataColumn(
                          label: Text(
                            'Stari klub',
                            style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                                color: Colors.white),
                          ),
                        ),
                        DataColumn(
                          label: Text(
                            'Novi klub',
                            style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                                color: Colors.white),
                          ),
                        ),
                      ],
                      rows: transferResults.map((data) {
                        return DataRow(cells: [
                          DataCell(Text(data.imeFudbalera ?? "")),
                          DataCell(Text(data.cijena.toString())),
                          DataCell(Text(data.brojGodinaUgovora.toString())),
                          DataCell(Text(data.stariKlub ?? "")),
                          DataCell(Text(data.nazivKluba ?? "")),
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
                ),
                SizedBox(height: 20),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class DataItem {
  final String column1;
  final String column2;
  final String column3;
  final String column4;
  final String column5;

  DataItem({
    required this.column1,
    required this.column2,
    required this.column3,
    required this.column4,
    required this.column5,
  });
}
