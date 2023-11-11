// ignore_for_file: use_build_context_synchronously
import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';
import 'package:bhfudbal_admin/models/request/fudbaler_request.dart';
import 'package:bhfudbal_admin/providers/fudbaler_provider.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import "../models/dodaj_fudbalera_model.dart";
import '../models/response/fudbaler_response.dart';
import '../models/response/klub_response.dart';
import '../providers/klub_provider.dart';

class DodajFudbaleraWidget extends StatefulWidget {
  DodajFudbaleraWidget(this.fudbalerId, {Key? key}) : super(key: key);
  int? fudbalerId;
  @override
  _DodajFudbaleraWidgetState createState() => _DodajFudbaleraWidgetState();
}

class _DodajFudbaleraWidgetState extends State<DodajFudbaleraWidget> {
  late DodajFudbaleraModel _model;
  final scaffoldKey = GlobalKey<ScaffoldState>();
  late bool imeValid;
  late bool prezimeValid;
  late bool visinaValid;
  late bool tezinaValid;
  late bool jacaNogaValid;
  String imeError = "";
  String prezimeError = "";
  String visinaError = "";
  String tezinaError = "";
  String jacaNogaError = "";

  late KlubProvider _klubProvider;
  List<KlubResponse> klubResults = [];

  late FudbalerProvider _fudbalerProvider;

  Future<void> _fetchKlubovi() async {
    _klubProvider = context.read<KlubProvider>();
    var result = await _klubProvider.getAll();
    setState(() {
      klubResults = result.result;
    });
  }

  String? nameValidator(BuildContext context, String? value) {
    if (value == null || value.isEmpty) {
      return 'Unesite vrijednost!';
    }

    if (value.length < 2) {
      return 'Najmanje 2 slova!';
    }

    return null;
  }

  String? visinaValidator(BuildContext context, String? value) {
    if (value == null || value.isEmpty) {
      return 'Unesite vrijednost!';
    }

    if (value.length != 3) {
      return 'Samo 3 cifre!';
    }

    if (int.tryParse(value) == null) {
      return 'Samo brojevi!';
    }

    return null; // Return null when the value is valid
  }

  String? tezinaValidator(BuildContext context, String? value) {
    if (value == null || value.isEmpty) {
      return 'Unesite vrijednost!';
    }

    if (value.length < 2 || value.length > 3) {
      return 'Izmedju 2-3 cifre!';
    }

    if (int.tryParse(value) == null) {
      return 'Samo brojevi!';
    }

    return null; // Return null when the value is valid
  }

  void saveData() async {
    _fudbalerProvider = context.read<FudbalerProvider>();
    var klub = FudbalerRequest(
        ime: _model.ime!.text,
        prezime: _model.prezime!.text,
        visina: _model.visina!.text,
        tezina: _model.tezina!.text,
        datumRodjenja: _model.datumRodjenja,
        klubId: _model.klub != null ? _model.klub!.klubId : null,
        jacaNoga: _model.jacaNoga!.text,
        slika: _base64Image);
    if (widget.fudbalerId == null) {
      var request = FudbalerRequest().toJson(klub);
      var response = await _fudbalerProvider.post(request);
      if (response) {
        showDialog(
            context: context,
            builder: (BuildContext context) => AlertDialog(
                  title: const Text("Uspjesno dodan fudbaler!"),
                  actions: [
                    TextButton(
                        onPressed: () => Navigator.pop(context),
                        child: const Text("OK"))
                  ],
                ));
      }
    } else {
      klub.klubId = 0;
      var request = FudbalerRequest().toJson(klub);
      var response = await _fudbalerProvider.put(request, widget.fudbalerId);
      if (response) {
        showDialog(
            context: context,
            builder: (BuildContext context) => AlertDialog(
                  title: const Text("Uspjesno uredjen fudbaler!"),
                  actions: [
                    TextButton(
                        onPressed: () => Navigator.pop(context),
                        child: const Text("OK"))
                  ],
                ));
      }
    }
  }

  Future<void> _initialize() async {
    _model = DodajFudbaleraModel();
    _model.ime ??= TextEditingController();
    _model.prezime ??= TextEditingController();
    _model.visina ??= TextEditingController();
    _model.tezina ??= TextEditingController();
    _model.jacaNoga ??= TextEditingController();
    _model.tezina ??= TextEditingController();
    _model.imeValidator = nameValidator;
    _model.prezimeValidator = nameValidator;
    _model.visinaValidator = visinaValidator;
    _model.tezinaValidator = tezinaValidator;
    _model.jacaNogaValidator = nameValidator;

    await Future.wait([_fetchKlubovi()]);

    appendValidation();
  }

  void appendValidation() {
    imeValid = _model.imeValidator!(context, _model.ime!.text) == null;
    prezimeValid =
        _model.prezimeValidator!(context, _model.prezime!.text) == null;
    visinaValid = _model.visinaValidator!(context, _model.visina!.text) == null;
    tezinaValid = _model.tezinaValidator!(context, _model.tezina!.text) == null;
    jacaNogaValid =
        _model.jacaNogaValidator!(context, _model.jacaNoga!.text) == null;
  }

  @override
  void initState() {
    super.initState();
    _initialize();
    appendValidation();
    if (widget.fudbalerId != null && widget.fudbalerId != 0) {
      _loadData(widget.fudbalerId);
    }
  }

  Future<void> _loadData(int? fudbalerId) async {
    _fudbalerProvider = context.read<FudbalerProvider>();
    var response = await _fudbalerProvider.getById(fudbalerId);
    var fudbaler = response;
    _loadModel(fudbaler);
  }

  void _loadModel(FudbalerResponse model) {
    _model.ime!.text = model.ime ?? "";
    _model.prezime!.text = model.prezime ?? "";
    _model.visina!.text = model.visina ?? "";
    _model.tezina!.text = model.tezina ?? "";
    _model.jacaNoga!.text = model.jacaNoga ?? "";
    _model.datumRodjenja = DateTime.parse(model.datumRodjenja ?? "");
    if (model.slika != null && model.slika!.isNotEmpty) {
      _model.slika = Uint8List.fromList(base64.decode(model.slika ?? ""));
      _base64Image = model.slika;
    }
    if (klubResults.isNotEmpty) {
      var klub = klubResults.firstWhere((x) => x.klubId == model.klubId);
      setState(() {
        _model.klub = klub;
      });
    }
    appendValidation();
  }

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
                        _model.slika = Uint8List.fromList(
                            base64.decode(_base64Image ?? ""));
                      });
                      appendValidation();
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
                child: Icon(
                  Icons.chevron_left,
                  color: Theme.of(context).scaffoldBackgroundColor,
                  size: 40,
                ),
              ),
              Text(
                widget.fudbalerId == null
                    ? 'Dodaj fudbalera'
                    : 'Uredi fudbalera',
                style: Theme.of(context).textTheme.headline6!.copyWith(
                      fontFamily: 'Outfit',
                      color: Colors.white,
                      fontSize: 22,
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
          child: Column(
            mainAxisSize: MainAxisSize.max,
            children: [
              Padding(
                padding: EdgeInsetsDirectional.fromSTEB(0, 50, 0, 0),
                child: Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Container(
                      width: 200,
                      height: 600,
                      child: Column(
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          Text(
                            'Ime',
                            textAlign: TextAlign.start,
                            style: Theme.of(context).textTheme.bodyText1,
                          ),
                          Padding(
                            padding: EdgeInsetsDirectional.fromSTEB(8, 0, 8, 0),
                            child: TextFormField(
                              controller: _model.ime,
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
                                    color: Theme.of(context).dividerColor,
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
                                fillColor: Theme.of(context).cardColor,
                                errorText: !imeValid ? imeError : null,
                              ),
                              style: Theme.of(context).textTheme.bodyText1,
                              validator: (value) =>
                                  _model.imeValidator!(context, value),
                              onChanged: (value) {
                                setState(() {
                                  imeError =
                                      _model.imeValidator!(context, value) ??
                                          '';
                                  imeValid = imeError.isEmpty;
                                });
                              },
                            ),
                          ),
                          Padding(
                            padding:
                                EdgeInsetsDirectional.fromSTEB(0, 30, 0, 0),
                            child: Text(
                              'Prezime',
                              style: Theme.of(context).textTheme.bodyText1,
                            ),
                          ),
                          Padding(
                            padding: EdgeInsetsDirectional.fromSTEB(8, 0, 8, 0),
                            child: TextFormField(
                              controller: _model.prezime,
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
                                    color: Theme.of(context).dividerColor,
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
                                fillColor: Theme.of(context).cardColor,
                                errorText: !prezimeValid ? prezimeError : null,
                              ),
                              style: Theme.of(context).textTheme.bodyText1,
                              validator: (value) =>
                                  _model.prezimeValidator!(context, value),
                              onChanged: (value) {
                                setState(() {
                                  prezimeError = _model.prezimeValidator!(
                                          context, value) ??
                                      '';
                                  prezimeValid = prezimeError.isEmpty;
                                });
                              },
                            ),
                          ),
                          Padding(
                            padding:
                                EdgeInsetsDirectional.fromSTEB(0, 30, 0, 0),
                            child: ElevatedButton(
                              onPressed: () async {
                                final _datePickedDate = await showDatePicker(
                                  context: context,
                                  initialDate: DateTime.now(),
                                  firstDate: DateTime(1900),
                                  lastDate: DateTime.now(),
                                );

                                if (_datePickedDate != null) {
                                  setState(() {
                                    _model.datumRodjenja = DateTime(
                                      _datePickedDate.year,
                                      _datePickedDate.month,
                                      _datePickedDate.day,
                                    );
                                  });
                                }
                              },
                              child: Text(
                                'Datum rodjenja',
                                style: TextStyle(
                                  fontFamily: 'Readex Pro',
                                  color: Colors.white,
                                ),
                              ),
                              style: ElevatedButton.styleFrom(
                                padding: EdgeInsetsDirectional.fromSTEB(
                                    24, 0, 24, 0),
                                elevation: 3,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                primary: Theme.of(context).primaryColor,
                                textStyle: Theme.of(context)
                                    .textTheme
                                    .headline6!
                                    .copyWith(
                                      fontFamily: 'Readex Pro',
                                      color: Colors.white,
                                    ),
                              ),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsetsDirectional.fromSTEB(0, 5, 0, 0),
                            child: Text(
                              _model.datumRodjenja != null
                                  ? DateFormat('yyyy-MM-dd').format(
                                      _model.datumRodjenja ?? DateTime.now())
                                  : 'Izaberi datum',
                              style: TextStyle(
                                fontFamily: 'Readex Pro',
                                fontSize: 24,
                              ),
                            ),
                          ),
                          Padding(
                            padding:
                                EdgeInsetsDirectional.fromSTEB(0, 30, 0, 0),
                            child: Text(
                              'Visina',
                              style: Theme.of(context).textTheme.bodyText1,
                            ),
                          ),
                          Padding(
                            padding: EdgeInsetsDirectional.fromSTEB(8, 0, 8, 0),
                            child: TextFormField(
                              controller: _model.visina,
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
                                    color: Theme.of(context).dividerColor,
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
                                fillColor: Theme.of(context).cardColor,
                                errorText: !visinaValid ? visinaError : null,
                              ),
                              style: Theme.of(context).textTheme.bodyText1,
                              validator: (value) =>
                                  _model.visinaValidator!(context, value),
                              onChanged: (value) {
                                setState(() {
                                  visinaError =
                                      _model.visinaValidator!(context, value) ??
                                          '';
                                  visinaValid = visinaError.isEmpty;
                                });
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      width: 200,
                      height: 600,
                      child: Column(
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          Text(
                            'Tezina',
                            textAlign: TextAlign.start,
                            style: Theme.of(context).textTheme.bodyText1,
                          ),
                          TextFormField(
                            controller: _model.tezina,
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
                                  color: Theme.of(context).dividerColor,
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
                              fillColor: Theme.of(context).cardColor,
                              errorText: !tezinaValid ? tezinaError : null,
                            ),
                            style: Theme.of(context).textTheme.bodyText1,
                            validator: (value) =>
                                _model.tezinaValidator!(context, value),
                            onChanged: (value) {
                              setState(() {
                                tezinaError =
                                    _model.tezinaValidator!(context, value) ??
                                        '';
                                tezinaValid = tezinaError.isEmpty;
                              });
                            },
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 30.0),
                            child: Text(
                              'Jaca noga',
                              textAlign: TextAlign.start,
                              style: Theme.of(context).textTheme.bodyText1,
                            ),
                          ),
                          TextFormField(
                            controller: _model.jacaNoga,
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
                                  color: Theme.of(context).dividerColor,
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
                              fillColor: Theme.of(context).cardColor,
                              errorText: !jacaNogaValid ? jacaNogaError : null,
                            ),
                            style: Theme.of(context).textTheme.bodyText1,
                            validator: (value) =>
                                _model.jacaNogaValidator!(context, value),
                            onChanged: (value) {
                              setState(() {
                                jacaNogaError =
                                    _model.jacaNogaValidator!(context, value) ??
                                        '';
                                jacaNogaValid = jacaNogaError.isEmpty;
                              });
                            },
                          ),
                          Padding(
                            padding: EdgeInsets.only(top: 20),
                            child: Container(
                              width: 200,
                              height: 100,
                              child: Column(
                                mainAxisSize: MainAxisSize.max,
                                children: [
                                  InkWell(
                                    onTap: _openImageUploadDialog,
                                    child: _model.slika == null
                                        ? Icon(
                                            Icons.image_outlined,
                                            color:
                                                Theme.of(context).primaryColor,
                                            size: 80,
                                          )
                                        : Image.memory(
                                            _model.slika ??
                                                Uint8List.fromList(
                                                    [10, 20, 30]),
                                            width: 150,
                                            height: 100,
                                          ),
                                  ),
                                  if (_model.slika == null)
                                    Text(
                                      'Dodaj sliku fudbalera',
                                    ),
                                ],
                              ),
                            ),
                          ),
                          if (widget.fudbalerId == null)
                            Padding(
                              padding:
                                  EdgeInsetsDirectional.fromSTEB(0, 20, 0, 0),
                              child: Text(
                                'Klub',
                                style: Theme.of(context).textTheme.bodyText1,
                              ),
                            ),
                          if (widget.fudbalerId == null)
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
                              child: DropdownButton<KlubResponse>(
                                isExpanded: true,
                                value: _model.klub,
                                onChanged: (val) =>
                                    setState(() => _model.klub = val!),
                                items: klubResults
                                    .map((val) => DropdownMenuItem(
                                        value: val,
                                        child: Text(val.naziv ?? "")))
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
                          Padding(
                            padding:
                                EdgeInsetsDirectional.fromSTEB(0, 20, 0, 0),
                            child: ElevatedButton(
                              onPressed: () {
                                !_model.areTextFieldsValid(
                                        imeValid,
                                        prezimeValid,
                                        visinaValid,
                                        tezinaValid,
                                        jacaNogaValid,
                                        _base64Image,
                                        widget.fudbalerId != null)
                                    ? null
                                    : saveData();
                              },
                              child: Text(
                                widget.fudbalerId == null ? 'Dodaj' : 'Uredi',
                                style: TextStyle(
                                  fontFamily: 'Readex Pro',
                                  color: Colors.white,
                                ),
                              ),
                              style: ElevatedButton.styleFrom(
                                backgroundColor: !_model.areTextFieldsValid(
                                        imeValid,
                                        prezimeValid,
                                        visinaValid,
                                        tezinaValid,
                                        jacaNogaValid,
                                        _base64Image,
                                        widget.fudbalerId != null)
                                    ? Colors.grey
                                    : Theme.of(context).primaryColor,
                                padding: EdgeInsetsDirectional.fromSTEB(
                                    24, 0, 24, 0),
                                elevation: 3,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
