// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, sort_child_properties_last
import 'package:bhfudbal_admin/pages/dodaj_transfer.dart';
import 'package:flutter/material.dart';
import '../models/prikaz_transfera_model.dart';

class PrikazTransferaWidget extends StatefulWidget {
  const PrikazTransferaWidget({Key? key}) : super(key: key);

  @override
  _PrikazTransferaWidgetState createState() => _PrikazTransferaWidgetState();
}

class _PrikazTransferaWidgetState extends State<PrikazTransferaWidget> {
  late PrikazTransferaModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _model = PrikazTransferaModel();
  }

  @override
  void dispose() {
    _model.dispose();

    super.dispose();
  }

  List<DataItem> yourDataList = [
    DataItem(
      column1: 'Fudbaler 1',
      column2: '1000',
      column3: '2 godine',
      column4: 'Stari klub 1',
      column5: 'Novi klub 1',
    ),
    DataItem(
      column1: 'Fudbaler 2',
      column2: '1500',
      column3: '3 godine',
      column4: 'Stari klub 2',
      column5: 'Novi klub 2',
    ),
    DataItem(
      column1: 'Fudbaler 3',
      column2: '800',
      column3: '1 godina',
      column4: 'Stari klub 3',
      column5: 'Novi klub 3',
    ),
    // Add more data items as needed
  ];

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).requestFocus(_model.unfocusNode),
      child: Scaffold(
        key: scaffoldKey,
        backgroundColor: Theme.of(context).secondaryHeaderColor,
        appBar: AppBar(
          backgroundColor: Theme.of(context)
              .primaryColor, // Replace with your desired app bar color
          automaticallyImplyLeading: false,
          title: Text(
            'Transferi',
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
                          child: DropdownButton<String>(
                            isExpanded: true,
                            value: _model.dropDownValue,
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
                        print('Button pressed ...');
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
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => DodajTransferWidget()));
                        },
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
