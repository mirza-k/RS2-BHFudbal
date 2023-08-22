// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables
import 'package:bhfudbal_admin/pages/dodaj_klub.dart';
import 'package:flutter/material.dart';
import '../models/prikaz_klubova_model.dart';

class PrikazKlubovaWidget extends StatefulWidget {
  const PrikazKlubovaWidget({Key? key}) : super(key: key);

  @override
  _PrikazKlubovaWidgetState createState() => _PrikazKlubovaWidgetState();
}

class _PrikazKlubovaWidgetState extends State<PrikazKlubovaWidget> {
  late PrikazKlubovaModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _model = PrikazKlubovaModel();
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
            'Prikaz klubova',
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
                        ],
                        rows: yourDataList.map((data) {
                          return DataRow(cells: [
                            DataCell(Text(data.column1)),
                            DataCell(Text(data.column2)),
                            DataCell(Text(data.column3)),
                            DataCell(Text(data.column4)),
                            DataCell(Text(data.column5)),
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
                          onPressed: () async {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => DodajKlubWidget()));
                          },
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