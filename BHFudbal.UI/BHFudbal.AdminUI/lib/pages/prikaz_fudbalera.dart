// ignore_for_file: sort_child_properties_last, prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:bhfudbal_admin/pages/dodaj_fudbalera.dart';
import 'package:flutter/material.dart';
import '../models/prikaz_fudbalera_model.dart';

class PrikazFudbaleraWidget extends StatefulWidget {
  const PrikazFudbaleraWidget({Key? key}) : super(key: key);

  @override
  _PrikazFudbaleraWidgetState createState() => _PrikazFudbaleraWidgetState();
}

class _PrikazFudbaleraWidgetState extends State<PrikazFudbaleraWidget> {
  late PrikazFudbaleraModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _model = PrikazFudbaleraModel();
  }

  @override
  void dispose() {
    _model.dispose();

    super.dispose();
  }

  List<DataTableRecord> dataTableRecordList = [
    DataTableRecord(
      column1: 'Value 1 Row 1',
      column2: 'Value 2 Row 1',
      column3: 'Value 3 Row 1',
      column4: 'Value 4 Row 1',
      column5: 'Value 5 Row 1',
      column6: 'Value 6 Row 1',
      column7: 'Value 7 Row 1',
    ),
    DataTableRecord(
      column1: 'Value 1 Row 2',
      column2: 'Value 2 Row 2',
      column3: 'Value 3 Row 2',
      column4: 'Value 4 Row 2',
      column5: 'Value 5 Row 2',
      column6: 'Value 6 Row 2',
      column7: 'Value 7 Row 2',
    ),
    DataTableRecord(
      column1: 'Value 1 Row 3',
      column2: 'Value 2 Row 3',
      column3: 'Value 3 Row 3',
      column4: 'Value 4 Row 3',
      column5: 'Value 5 Row 3',
      column6: 'Value 6 Row 3',
      column7: 'Value 7 Row 3',
    ),
    // Add more rows as needed
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
                          child: DropdownButton<String>(
                            value: _model.dropDownValue1,
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
                                setState(() => _model.dropDownValue1 = val!),
                            items: ['Option 1']
                                .map((val) => DropdownMenuItem(
                                    value: val, child: Text(val)))
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
                          child: DropdownButton<String>(
                            isExpanded: true,
                            value: _model.dropDownValue2,
                            hint: const Text(
                              "Izaberi klub",
                              style: TextStyle(
                                fontSize: 14,
                                color: Colors
                                    .black, // Replace with your desired text color
                              ),
                            ),
                            onChanged: (val) =>
                                setState(() => _model.dropDownValue2 = val!),
                            items: ['Option 1']
                                .map((val) => DropdownMenuItem(
                                    value: val, child: Text(val)))
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
                        print('Button pressed ...');
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
                        padding:
                            EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                      ),
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 30),
                  child: Row(
                    children: [
                      Expanded(
                        child: DataTable(
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
                          ],
                          rows: dataTableRecordList.map((dataTableRecord) {
                            return DataRow(cells: [
                              DataCell(Text('Edit Column 1',
                                  style: TextStyle(fontSize: 14))),
                              DataCell(Text('Edit Column 2',
                                  style: TextStyle(fontSize: 14))),
                              DataCell(Text('Edit Column 3',
                                  style: TextStyle(fontSize: 14))),
                              DataCell(Text('Edit Column 4',
                                  style: TextStyle(fontSize: 14))),
                              DataCell(Text('Edit Column 5',
                                  style: TextStyle(fontSize: 14))),
                              DataCell(Text('Edit Column 6',
                                  style: TextStyle(fontSize: 14))),
                              DataCell(Text('Edit Column 7',
                                  style: TextStyle(fontSize: 14))),
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
                          onPressed: () async {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        DodajFudbaleraWidget()));
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
    );
  }
}

class DataTableRecord {
  String column1;
  String column2;
  String column3;
  String column4;
  String column5;
  String column6;
  String column7;

  DataTableRecord({
    required this.column1,
    required this.column2,
    required this.column3,
    required this.column4,
    required this.column5,
    required this.column6,
    required this.column7,
  });
}
