import 'dart:io';
import 'package:bhfudbal_admin/models/response/report_response.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/pdf.dart';
import 'package:provider/provider.dart';
import 'package:pdf/widgets.dart' as pw;
import '../models/izvjestaji_model.dart';
import '../models/response/sezona_response.dart';
import '../providers/sezona_provider.dart';
import '../providers/transfer_provider.dart';

class IzvjestajWidget extends StatefulWidget {
  const IzvjestajWidget({Key? key}) : super(key: key);

  @override
  _IzvjestajWidgetState createState() => _IzvjestajWidgetState();
}

class _IzvjestajWidgetState extends State<IzvjestajWidget> {
  late IzvjestajModel _model;
  late TransferProvider _transferProvider;
  List<ReportResponse> transferResults = [];
  late SezonaProvider _sezonaProvider;
  List<SezonaResponse> sezonaResults = [];
  final scaffoldKey = GlobalKey<ScaffoldState>();

  Future<void> _fetchSezone() async {
    _sezonaProvider = context.read<SezonaProvider>();
    var result = await _sezonaProvider.get();
    setState(() {
      sezonaResults = result.result;
    });
  }

  @override
  void initState() {
    super.initState();
    _model = IzvjestajModel();
    _fetchSezone();
  }

  pw.Widget buildTable(List<Map<String, dynamic>> dataset) {
    final headers = [
      'Naziv kluba',
      'Ukupno izvrsenih transfera',
      'Ukupno potrosenog novca'
    ];
    final List<pw.TableRow> rows = [];

    // Add table headers
    final headerRow = headers.map((header) {
      return pw.Container(
        alignment: pw.Alignment.center,
        child: pw.Text(header,
            style: pw.TextStyle(fontWeight: pw.FontWeight.bold)),
        padding: pw.EdgeInsets.all(5),
        margin: pw.EdgeInsets.all(2),
        decoration: pw.BoxDecoration(
          border: pw.Border.all(),
          color: PdfColors.grey300,
        ),
      );
    }).toList();

    rows.add(pw.TableRow(children: headerRow));

    // Add table rows based on the dataset
    for (var data in dataset) {
      final rowData = headers.map((header) {
        return pw.Container(
          alignment: pw.Alignment.center,
          child: pw.Text(data[header].toString()),
          padding: pw.EdgeInsets.all(5),
          margin: pw.EdgeInsets.all(2),
          decoration: pw.BoxDecoration(
            border: pw.Border.all(),
          ),
        );
      }).toList();
      rows.add(pw.TableRow(children: rowData));
    }

    return pw.Table(
      children: rows,
      border: pw.TableBorder.all(),
    );
  }

  Future<pw.Document?> generatePDF() async {
    if (_model.dropDownValue != null && _model.dropDownValue!.sezonaId != 0) {
      final pdf = pw.Document();
      _transferProvider = context.read<TransferProvider>();
      var result =
          await _transferProvider.getReport(_model.dropDownValue!.sezonaId);
      pdf.addPage(
        pw.Page(
          build: (pw.Context context) {
            return pw.Center(
              child: pw.Table.fromTextArray(
                headers: ['Klub', 'Broj transfera', 'Ukupno potroseno'],
                data: result.result.map((data) {
                  return [
                    data.imeKluba.toString(),
                    data.UkupnoIzvrsenihTransfera.toString(),
                    data.UkupnoPotrosenogNovca.toString(),
                  ];
                }).toList(),
                border: pw.TableBorder.all(),
                headerStyle: pw.TextStyle(fontWeight: pw.FontWeight.bold),
              ),
            );
          },
        ),
      );

      return pdf;
    } else {
      return null;
    }
  }

  Future<String> savePDF() async {
    final pdf = await generatePDF();
    if (pdf != null) {
      final tempDir = await getTemporaryDirectory();
      final pdfFilePath = '${tempDir.path}/report.pdf';
      final pdfFile = File('${tempDir.path}/report.pdf');
      await pdfFile.writeAsBytes(await pdf.save());

      return pdfFilePath;
    }
    return "";
  }

  void openPDFInDefaultViewer(String pdfFilePath) async {
    Process.run('cmd', ['/c', 'start', '', pdfFilePath]);
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).requestFocus(_model.unfocusNode),
      child: Scaffold(
        key: scaffoldKey,
        backgroundColor:
            Theme.of(context).secondaryHeaderColor, // Change to desired color
        appBar: AppBar(
          backgroundColor:
              Theme.of(context).primaryColor, // Change to desired color
          automaticallyImplyLeading: false,
          title: const Text(
            'Izvjestaj',
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
          child: Padding(
            padding: EdgeInsets.all(20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Column(
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
                    Padding(
                      padding: const EdgeInsets.only(top: 20),
                      child: ElevatedButton(
                        onPressed: () async {
                          if (_model.areTextFieldsValid()) {
                            final pdfFilePath = await savePDF();
                            if (pdfFilePath.isNotEmpty) {
                              openPDFInDefaultViewer(pdfFilePath);
                            }
                          }
                        },
                        style: ElevatedButton.styleFrom(
                          primary: !_model.areTextFieldsValid()
                              ? Colors.grey
                              : Theme.of(context).primaryColor,
                          onPrimary: Colors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                          padding:
                              EdgeInsets.symmetric(horizontal: 24, vertical: 8),
                        ),
                        child: const Text(
                          'Generisi PDF',
                          style: TextStyle(
                            fontFamily: 'Readex Pro',
                            fontSize: 16,
                          ),
                        ),
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
