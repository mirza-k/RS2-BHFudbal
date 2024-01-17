// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, must_be_immutable, use_build_context_synchronously
import 'package:flutter/material.dart';
import 'package:flutter_application_1/models/response/fudbaler_response.dart';
import 'package:flutter_application_1/providers/fudbaler_provider.dart';
import 'package:provider/provider.dart';

class NajslicnijiFudbaleri extends StatefulWidget {
  int fudbalerId;
  NajslicnijiFudbaleri({super.key, required this.fudbalerId});

  @override
  State<NajslicnijiFudbaleri> createState() => _NajslicnijiFudbaleriState();
}

class _NajslicnijiFudbaleriState extends State<NajslicnijiFudbaleri> {
  List<FudbalerResponse> slicniFudbaleriResults = [];

  Future<void> _fetchSlicneFudbalere() async {
    var fudbalerProvider = context.read<FudbalerProvider>();
    var response = await fudbalerProvider.getSlicneFudbalere(widget.fudbalerId);
    setState(() {
      slicniFudbaleriResults = response.result;
    });
  }

  @override
  void initState() {
    super.initState();
    _fetchSlicneFudbalere();
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Najslicniji fudbaleri"),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            children: [
              Table(
                border: TableBorder.all(),
                columnWidths: const {
                  0: FlexColumnWidth(1),
                  1: FlexColumnWidth(1),
                  2: FlexColumnWidth(1),
                  3: FlexColumnWidth(1)
                },
                children: [
                  TableRow(
                    decoration: BoxDecoration(
                      color: Colors.grey,
                    ),
                    children: [
                      TableCell(
                        child: Center(
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              'Fudbaler',
                              style: TextStyle(
                                  fontSize: 13, fontWeight: FontWeight.bold),
                            ),
                          ),
                        ),
                      ),
                      TableCell(
                        child: Center(
                          child: Padding(
                            padding: EdgeInsets.all(8.0),
                            child: Text(
                              "Broj godina",
                              style: TextStyle(
                                  fontSize: 13, fontWeight: FontWeight.bold),
                            ),
                          ),
                        ),
                      ),
                      TableCell(
                        child: Center(
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              "Drzava",
                              style: TextStyle(
                                  fontSize: 13, fontWeight: FontWeight.bold),
                            ),
                          ),
                        ),
                      ),
                      TableCell(
                        child: Center(
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              "Klub",
                              style: TextStyle(
                                  fontSize: 13, fontWeight: FontWeight.bold),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  ...slicniFudbaleriResults.map((item) {
                    return TableRow(children: [
                      TableCell(
                        child: Center(
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text("${item.ime} ${item.prezime}"),
                          ),
                        ),
                      ),
                      TableCell(
                        child: Center(
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text("${item.brojGodina}"),
                          ),
                        ),
                      ),
                      TableCell(
                        child: Center(
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text("${item.drzava}"),
                          ),
                        ),
                      ),
                      TableCell(
                        child: Center(
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text("${item.klub}"),
                          ),
                        ),
                      ),
                    ]);
                  }).toList(),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
