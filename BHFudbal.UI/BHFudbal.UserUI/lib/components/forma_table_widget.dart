// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors
import 'package:flutter/material.dart';
import '../models/response/match_forma_response.dart';

class FormaTabela {
  final String column1;
  final String column2;
  final List<String> column3;

  const FormaTabela({
    required this.column1,
    required this.column2,
    required this.column3,
  });
}

class FormaTabelaWidget extends StatefulWidget {
  int counter = 0;
  final List<MatchFormaResponse> data;
  FormaTabelaWidget({Key? key, required this.data}) : super(key: key);

  @override
  State<FormaTabelaWidget> createState() => _FormaTabelaWidgetState();
}

class _FormaTabelaWidgetState extends State<FormaTabelaWidget> {
  @override
  Widget build(BuildContext context) {
    return Table(
      border: TableBorder.all(),
      columnWidths: const {
        0: FlexColumnWidth(1),
        1: FlexColumnWidth(2),
        2: FlexColumnWidth(2),
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
                    '#',
                    style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            ),
            TableCell(
              child: Center(
                child: Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text(
                    "Klub",
                    style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            ),
            TableCell(
              child: Center(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    "Forma",
                    style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            ),
          ],
        ),
        ...widget.data.map((item) {
          return TableRow(children: [
            TableCell(
              child: Center(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text((++widget.counter).toString()),
                ),
              ),
            ),
            TableCell(
              child: Center(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(item.klub),
                ),
              ),
            ),
            TableCell(
                child: Center(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: item.forma.map((value) {
                      return Container(
                        width: 20,
                        height: 20,
                        decoration: BoxDecoration(
                          color: value == 'P'
                              ? Colors.green
                              : value == 'N'
                                  ? Colors.yellow
                                  : Colors.red,
                          borderRadius: BorderRadius.circular(5),
                        ),
                        child: Center(
                          child: Text(
                            value,
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                      );
                    }).toList()),
              ),
            ))
          ]);
        }).toList(),
      ],
    );
  }
}
