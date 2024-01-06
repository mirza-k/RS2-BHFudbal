// ignore_for_file: sort_child_properties_last, use_build_context_synchronously, prefer_const_constructors
import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';
import 'package:bhfudbal_admin/models/request/grad_request.dart';
import 'package:bhfudbal_admin/models/request/klub_request.dart';
import 'package:bhfudbal_admin/models/response/grad_response.dart';
import 'package:bhfudbal_admin/models/response/klub_response.dart';
import 'package:bhfudbal_admin/providers/grad_provider.dart';
import 'package:bhfudbal_admin/providers/klub_provider.dart';
import 'package:bhfudbal_admin/providers/liga_provider.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/dodaj_klub_model.dart';
import '../models/response/liga_response.dart';

class DodajGradWidget extends StatefulWidget {
  const DodajGradWidget({Key? key}) : super(key: key);

  @override
  _DodajGradWidgetState createState() => _DodajGradWidgetState();
}

class _DodajGradWidgetState extends State<DodajGradWidget> {
  late DodajKlubModel _model;
  late bool nazivKlubaValid = false;
  late bool nadimakKlubaValid = false;
  late bool osnivanjeKlubaValid = false;
  late KlubProvider _klubProvider;
  late LigaProvider _ligaProvider;
  late GradProvider _gradProvider;
  late File image;
  late String path;
  String? nazivKlubaError;
  String? nadimakKlubaError;
  String? osnivanjeKlubaError;
  List<LigaResponse> ligaResults = [];
  List<GradResponse> gradResults = [];
  final scaffoldKey = GlobalKey<ScaffoldState>();

  File? _image;
  String? _base64Image;

  void _openImageUploadDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("Upload Grb"),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextButton(
                  onPressed: () async {
                    var result = await FilePicker.platform
                        .pickFiles(type: FileType.image);
                    if (result != null && result.files.single.path != null) {
                      _image = File(result.files.single.path!);
                      _base64Image = base64Encode(_image!.readAsBytesSync());
                      setState(() {
                        image = _image!;
                        path = result.files.single.path!;
                        _model.grb = Uint8List.fromList(
                            base64.decode(_base64Image ?? ""));
                      });
                      _appendValidation();
                    }
                  },
                  child: const Text("Upload")),
            ],
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                // Close the dialog
                Navigator.of(context).pop();
              },
              child: const Text("Close"),
            ),
          ],
        );
      },
    );
  }

  String? nameValidator(BuildContext context, String? value) {
    if (value == null || value.isEmpty) {
      return 'Unesite vrijednost!';
    }

    if (value.length < 5) {
      return 'Najmanje 5 slova!';
    }

    return null;
  }

  String? fourDigitValidator(BuildContext context, String? value) {
    if (value == null || value.isEmpty) {
      return 'Unesite vrijednost!';
    }

    if (value.length != 4) {
      return 'Samo 4 cifre!';
    }

    if (int.tryParse(value) == null) {
      return 'Samo brojevi!';
    }

    return null; // Return null when the value is valid
  }

  @override
  void initState() {
    super.initState();
    _model = DodajKlubModel();
    _model.textController1 ??= TextEditingController();
    _model.textController2 ??= TextEditingController();
    _model.textController3 ??= TextEditingController();

    _appendValidation();
  }

  void _appendValidation() {
    _model.textController1Validator = nameValidator;
  }

  void clearForm() {
    setState(() {
      _model.textController1!.text = "";
      _appendValidation();
    });
  }

  void saveData() async {
    _gradProvider = context.read<GradProvider>();
    var klub = GradRequest(naziv: _model.textController1!.text);
    var request = GradRequest().toJson(klub);
    var response = await _gradProvider.post(request);
    if (response) {
      clearForm();
      showDialog(
          context: context,
          builder: (BuildContext context) => AlertDialog(
                title: const Text("Uspjesno dodan grad!"),
                actions: [
                  TextButton(
                      onPressed: () => Navigator.pop(context),
                      child: const Text("OK"))
                ],
              ));
    }
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
          title: Row(
            mainAxisSize: MainAxisSize.max,
            children: [
              InkWell(
                splashColor: Colors.transparent,
                focusColor: Colors.transparent,
                hoverColor: Colors.transparent,
                highlightColor: Colors.transparent,
                onTap: () async {
                  Navigator.pop(context, true);
                },
                child: const Icon(
                  Icons.chevron_left,
                  color: Colors.white,
                  size: 40,
                ),
              ),
              Padding(
                padding: EdgeInsetsDirectional.fromSTEB(30, 0, 0, 0),
                child: Text(
                  "Dodaj Grad",
                  style: TextStyle(
                    fontFamily: 'Outfit',
                    color: Colors.white,
                    fontSize: 22,
                  ),
                ),
              ),
            ],
          ),
          actions: [],
          centerTitle: false,
          elevation: 2,
        ),
        body: SafeArea(
          top: true,
          child: Padding(
            padding: const EdgeInsetsDirectional.fromSTEB(0, 100, 0, 0),
            child: Column(
              mainAxisSize: MainAxisSize.max,
              children: [
                Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Container(
                      width: 200,
                      height: 400,
                      child: Column(
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          const Text(
                            'Naziv grada',
                            textAlign: TextAlign.start,
                          ),
                          Padding(
                            padding: const EdgeInsetsDirectional.fromSTEB(
                                8, 0, 8, 0),
                            child: TextFormField(
                              controller: _model.textController1,
                              autofocus: true,
                              obscureText: false,
                              decoration: InputDecoration(
                                labelStyle: Theme.of(context)
                                    .inputDecorationTheme
                                    .labelStyle,
                                hintStyle: Theme.of(context)
                                    .inputDecorationTheme
                                    .hintStyle,
                                enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color: Theme.of(context).primaryColor,
                                    width: 2,
                                  ),
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color: Theme.of(context).primaryColor,
                                    width: 2,
                                  ),
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                errorBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color: Theme.of(context).errorColor,
                                    width: 2,
                                  ),
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                focusedErrorBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color: Theme.of(context).errorColor,
                                    width: 2,
                                  ),
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                filled: true,
                                fillColor: Theme.of(context).backgroundColor,
                                errorText:
                                    !nazivKlubaValid ? nazivKlubaError : null,
                              ),
                              style: Theme.of(context).textTheme.bodyText1,
                              // validator: (value) => _model
                              //     .textController1Validator!(context, value),
                              onChanged: (value) {
                                setState(() {
                                  nazivKlubaError =
                                      _model.textController1Validator!(
                                              context, value) ??
                                          '';
                                  nazivKlubaValid = nazivKlubaError!.isEmpty;
                                });
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                ElevatedButton(
                  onPressed: () {
                    !nazivKlubaValid ? null : saveData();
                  },
                  child: Text(
                    'Dodaj',
                    style: TextStyle(
                      fontFamily: 'Readex Pro',
                      color: Colors.white,
                    ),
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: !nazivKlubaValid
                        ? Colors.grey
                        : Theme.of(context).primaryColor,
                    padding: const EdgeInsetsDirectional.fromSTEB(24, 0, 24, 0),
                    elevation: 3,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
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
