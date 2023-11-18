// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors
import 'package:flutter/material.dart';
import '../models/response/match_strijelci_response.dart';

class IgracAsistentTabela {
  final String column1;
  final String column2;
  final String column3;

  const IgracAsistentTabela({
    required this.column1,
    required this.column2,
    required this.column3,
  });
}

class IgracAsistentWidget extends StatefulWidget {
  List<MatchStrijelciResponse>? data;
  final String firstLabel;
  final String secondLabel;

  IgracAsistentWidget(
      {Key? key,
      required this.data,
      required this.firstLabel,
      required this.secondLabel})
      : super(key: key);

  @override
  State<IgracAsistentWidget> createState() => _IgracAsistentWidgetState();
}

class _IgracAsistentWidgetState extends State<IgracAsistentWidget> {
  int brojac = 0;
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
                    widget.firstLabel,
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
                    widget.secondLabel,
                    style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            ),
          ],
        ),
        if (widget.data != null)
          ...widget.data!.map((item) {
            return TableRow(
              children: [
                TableCell(
                  child: Center(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text((++brojac).toString()),
                    ),
                  ),
                ),
                TableCell(
                  child: Center(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(item.nazivFudbalera),
                    ),
                  ),
                ),
                TableCell(
                  child: Center(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(item.brojGolova.toString()),
                    ),
                  ),
                ),
              ],
            );
          }).toList(),
      ],
    );
  }
}
