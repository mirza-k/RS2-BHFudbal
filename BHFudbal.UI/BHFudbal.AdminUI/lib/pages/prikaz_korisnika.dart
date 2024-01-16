// ignore_for_file: prefer_const_constructors
import 'package:bhfudbal_admin/providers/korisnik_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/prikaz_korisnika_model.dart';
import '../models/response/korisnik_response.dart';
import 'login.dart';

class PrikazKorisnikaWidget extends StatefulWidget {
  const PrikazKorisnikaWidget({Key? key}) : super(key: key);

  @override
  _PrikazKorisnikaWidgetState createState() => _PrikazKorisnikaWidgetState();
}

class _PrikazKorisnikaWidgetState extends State<PrikazKorisnikaWidget> {
  late PrikazKorisnikaModel _model;
  late KorisnikProvider _korisnikProvider;
  List<KorisnikResponse> korisnikResults = [];

  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _model = PrikazKorisnikaModel();

    _model.textController ??= TextEditingController();
  }

  Future<void> _fetchKorisnici() async {
    _korisnikProvider = context.read<KorisnikProvider>();
    String? ime;
    if (_model.textController != null &&
        _model.textController!.text.isNotEmpty) {
      ime = _model.textController!.text;
    }
    var result = await _korisnikProvider.get(ime);
    setState(() {
      korisnikResults = result.result;
    });
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
            'Prikaz korisnika',
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
        body: SingleChildScrollView(
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
                        _fetchKorisnici();
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
                        rows: korisnikResults.map((data) {
                          return DataRow(cells: [
                            DataCell(Text(data.ime ?? "")),
                            DataCell(Text(data.prezime ?? "")),
                            DataCell(Text(data.username ?? "")),
                            DataCell(Text(data.grad ?? "")),
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
