// ignore_for_file: prefer_const_constructors
import 'package:flutter/material.dart';
import '../models/prikaz_korisnika_model.dart';

class PrikazKorisnikaWidget extends StatefulWidget {
  const PrikazKorisnikaWidget({Key? key}) : super(key: key);

  @override
  _PrikazKorisnikaWidgetState createState() => _PrikazKorisnikaWidgetState();
}

class _PrikazKorisnikaWidgetState extends State<PrikazKorisnikaWidget> {
  late PrikazKorisnikaModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _model = PrikazKorisnikaModel();

    _model.textController ??= TextEditingController();
  }

  @override
  void dispose() {
    _model.dispose();

    super.dispose();
  }

  // Mock data for yourDataList
  List<DataTableRecord> yourDataList = [
    DataTableRecord(
      column1: 'Club 1',
      column2: 'City 1',
      column3: '1990',
      column4: 'League 1',
      column5: 'Nickname 1',
    ),
    DataTableRecord(
      column1: 'Club 2',
      column2: 'City 2',
      column3: '1985',
      column4: 'League 2',
      column5: 'Nickname 2',
    ),
    DataTableRecord(
      column1: 'Club 3',
      column2: 'City 3',
      column3: '2000',
      column4: 'League 3',
      column5: 'Nickname 3',
    ),
    // Add more mock data as needed
  ];

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
            'Prikaz korisnika',
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
                    Padding(
                      padding: EdgeInsets.only(bottom: 20),
                      child: Container(
                        width: 300,
                        height: 50,
                        padding: EdgeInsets.symmetric(horizontal: 16),
                        child: TextFormField(
                          controller: _model.textController,
                          autofocus: true,
                          obscureText: false,
                          decoration: InputDecoration(
                            labelText: 'Unesi korisnika',
                            labelStyle: TextStyle(color: Colors.black),
                            hintStyle: TextStyle(color: Colors.black),
                            enabledBorder: UnderlineInputBorder(
                              borderSide: BorderSide(
                                color: Colors.blue, // Change to desired color
                                width: 2,
                              ),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(
                                color: Colors.blue, // Change to desired color
                                width: 2,
                              ),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            errorBorder: UnderlineInputBorder(
                              borderSide: BorderSide(
                                color: Colors.red, // Change to desired color
                                width: 2,
                              ),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            focusedErrorBorder: UnderlineInputBorder(
                              borderSide: BorderSide(
                                color: Colors.red, // Change to desired color
                                width: 2,
                              ),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            filled: true,
                            fillColor: Colors.white,
                          ),
                          style: TextStyle(fontSize: 16),
                          validator: (value) {
                            // Replace _model.textControllerValidator logic here
                            if (value == null || value.isEmpty) {
                              return 'Field cannot be empty';
                            }
                            return null;
                          },
                        ),
                      ),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        print('Button pressed ...');
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
                        columns: const [
                          DataColumn(
                            label: Text(
                              'Ime',
                              style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white),
                            ),
                          ),
                          DataColumn(
                            label: Text(
                              'Prezime',
                              style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white),
                            ),
                          ),
                          DataColumn(
                            label: Text(
                              'Username',
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
                        ],
                        rows: yourDataList.map((data) {
                          return DataRow(cells: [
                            DataCell(Text(data.column1)),
                            DataCell(Text(data.column2)),
                            DataCell(Text(data.column3)),
                            DataCell(Text(data.column4)),
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
