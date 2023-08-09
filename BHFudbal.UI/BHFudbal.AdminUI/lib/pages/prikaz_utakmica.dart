// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors, sort_child_properties_last, library_private_types_in_public_api
import 'package:flutter/material.dart';
import '../models/prikaz_utamica_model.dart';

class PrikazUtakmicaWidget extends StatefulWidget {
  const PrikazUtakmicaWidget({Key? key}) : super(key: key);

  @override
  _PrikazUtakmicaWidgetState createState() => _PrikazUtakmicaWidgetState();
}

class _PrikazUtakmicaWidgetState extends State<PrikazUtakmicaWidget> {
  late PrikazUtakmicaModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _model = PrikazUtakmicaModel();
  }

  @override
  void dispose() {
    _model.dispose();

    super.dispose();
  }

  List<DataTableRecord> yourDataList = [
    DataTableRecord(
        column1: 'Sarajevo', column2: '2 - 2', column3: 'Zeljeznicar'),
    DataTableRecord(
        column1: 'Barcelona', column2: '3 - 1', column3: 'Real Madrid'),
    DataTableRecord(
        column1: 'Manchester City',
        column2: '0 - 0',
        column3: 'Manchester United'),
    DataTableRecord(
        column1: 'Bayern Munich',
        column2: '4 - 0',
        column3: 'Borussia Dortmund'),
    DataTableRecord(column1: 'Liverpool', column2: '1 - 2', column3: 'Chelsea'),
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
                            hint: Text(
                              'Izaberi kolo',
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
                      ],
                    ),
                    ElevatedButton(
                      onPressed: () {
                        print('Button pressed ...');
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
                Expanded(
                  child: DataTable(
                    columns: [
                      DataColumn(
                        label: Text(
                          'Domacin',
                          style: TextStyle(fontSize: 16, color: Colors.white),
                        ),
                      ),
                      DataColumn(
                        label: Text(
                          'Rezultat',
                          style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: Colors.white),
                        ),
                      ),
                      DataColumn(
                        label: Text(
                          'Gost',
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
