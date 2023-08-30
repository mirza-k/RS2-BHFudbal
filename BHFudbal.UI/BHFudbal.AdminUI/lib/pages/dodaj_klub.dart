// ignore_for_file: sort_child_properties_last, use_build_context_synchronously, prefer_const_constructors
import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';
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

class DodajKlubWidget extends StatefulWidget {
  const DodajKlubWidget(this.klubId, this.ligeParam, this.gradParam, {Key? key})
      : super(key: key);
  final int? klubId;
  final List<LigaResponse>? ligeParam;
  final List<GradResponse>? gradParam;
  @override
  _DodajKlubWidgetState createState() => _DodajKlubWidgetState();
}

class _DodajKlubWidgetState extends State<DodajKlubWidget> {
  late DodajKlubModel _model;
  late bool nazivKlubaValid = false;
  late bool nadimakKlubaValid = false;
  late bool osnivanjeKlubaValid = false;
  late KlubProvider _klubProvider;
  late LigaProvider _ligaProvider;
  late GradProvider _gradProvider;
  String? nazivKlubaError;
  String? nadimakKlubaError;
  String? osnivanjeKlubaError;
  List<LigaResponse> ligaResults = [];
  List<GradResponse> gradResults = [];
  final scaffoldKey = GlobalKey<ScaffoldState>();

  Future<void> _fetchLige() async {
    if (widget.ligeParam != null) {
      ligaResults = widget.ligeParam ?? [];
    } else {
      _ligaProvider = context.read<LigaProvider>();
      var result = await _ligaProvider.get();
      setState(() {
        ligaResults = result.result;
      });
    }
  }

  Future<void> _fetchGradovi() async {
    if (widget.gradParam != null) {
      gradResults = widget.gradParam ?? [];
    } else {
      _gradProvider = context.read<GradProvider>();
      var result = await _gradProvider.get();
      setState(() {
        gradResults = result.result;
      });
    }
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

  void _loadModel(KlubResponse model) {
    _model.textController1!.text = model.naziv ?? "";
    _model.textController2!.text = model.nadimak ?? "";
    _model.textController3!.text = model.godinaOsnivanja.toString();
    if (model.grb != null && model.grb!.isNotEmpty) {
      _model.grb = Uint8List.fromList(base64.decode(model.grb ?? ""));
      _base64Image = model.grb;
    }
    if (widget.gradParam != null && widget.gradParam!.isNotEmpty) {
      var grad = widget.gradParam!.firstWhere((x) => x.gradId == model.gradId);
      setState(() {
        _model.dropDownValue1 = grad;
      });
    }
    if (widget.ligeParam != null && widget.ligeParam!.isNotEmpty) {
      setState(() {
        _model.dropDownValue2 = null;
        _model.dropDownValue2 =
            widget.ligeParam!.firstWhere((x) => x.ligaId1 == model.ligaId);
      });
    }
    _appendValidation();
  }

  Future<void> _loadData(int? klubId) async {
    _klubProvider = context.read<KlubProvider>();
    var response = await _klubProvider.getById(klubId);
    var klub = response;
    _loadModel(klub);
  }

  @override
  void initState() {
    super.initState();
    _model = DodajKlubModel();
    _model.textController1 ??= TextEditingController();
    _model.textController2 ??= TextEditingController();
    _model.textController3 ??= TextEditingController();
    _fetchGradovi();
    _fetchLige();

    if (widget.klubId != null && widget.klubId != 0) {
      _loadData(widget.klubId);
    }

    _appendValidation();
  }

  void _appendValidation() {
    _model.textController1Validator = nameValidator;
    _model.textController2Validator = nameValidator;
    _model.textController3Validator = fourDigitValidator;
    nazivKlubaValid = _model.textController1Validator!(
            context, _model.textController1!.text) ==
        null;
    nadimakKlubaValid = _model.textController2Validator!(
            context, _model.textController2!.text) ==
        null;
    osnivanjeKlubaValid = _model.textController3Validator!(
            context, _model.textController3!.text) ==
        null;
  }

  @override
  void dispose() {
    _model.dispose();

    super.dispose();
  }

  void saveData() async {
    _klubProvider = context.read<KlubProvider>();
    var klub = KlubRequest(
        naziv: _model.textController1!.text,
        nadimak: _model.textController2!.text,
        godinaOsnivanja: int.parse(_model.textController3!.text),
        gradId: _model.dropDownValue1!.gradId,
        ligaId: _model.dropDownValue2!.ligaId1,
        grb: _base64Image);
    var request = KlubRequest().toJson(klub);

    if (widget.klubId == null) {
      var response = await _klubProvider.post(request);
      if (response) {
        showDialog(
            context: context,
            builder: (BuildContext context) => AlertDialog(
                  title: const Text("Uspjesno dodan klub!"),
                  actions: [
                    TextButton(
                        onPressed: () => Navigator.pop(context),
                        child: const Text("OK"))
                  ],
                ));
      }
    } else {
      var klubUpdateRequest = KlubUpdateRequest(
          naziv: _model.textController1!.text,
          nadimak: _model.textController2!.text,
          godinaOsnivanja: int.parse(_model.textController3!.text),
          gradId: _model.dropDownValue1!.gradId,
          grb: _base64Image);
      var request = klubUpdateRequest.toJson(klubUpdateRequest);
      var response = await _klubProvider.put(request, widget.klubId);
      if (response) {
        showDialog(
            context: context,
            builder: (BuildContext context) => AlertDialog(
                  title: const Text("Uspjesno ste uredili klub!"),
                  actions: [
                    TextButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: const Text("OK"))
                  ],
                ));
      }
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
                  widget.klubId != null ? 'Uredi klub' : "Dodaj klub",
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
                            'Naziv kluba *',
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
                          Padding(
                            padding: const EdgeInsetsDirectional.fromSTEB(
                                0, 30, 0, 0),
                            child: Text(
                              'Nadimak *',
                              style: Theme.of(context).textTheme.bodyText1,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsetsDirectional.fromSTEB(
                                8, 0, 8, 0),
                            child: TextFormField(
                              controller: _model.textController2,
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
                                errorText: !nadimakKlubaValid
                                    ? nadimakKlubaError
                                    : null,
                              ),
                              style: Theme.of(context).textTheme.bodyText1,
                              validator: (value) => _model
                                  .textController2Validator!(context, value),
                              onChanged: (value) {
                                setState(() {
                                  nadimakKlubaError =
                                      _model.textController2Validator!(
                                              context, value) ??
                                          '';
                                  nadimakKlubaValid =
                                      nadimakKlubaError!.isEmpty;
                                });
                              },
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsetsDirectional.fromSTEB(
                                0, 30, 0, 0),
                            child: Text(
                              'Godina osnivanja *',
                              style: Theme.of(context).textTheme.bodyText1,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsetsDirectional.fromSTEB(
                                8, 0, 8, 0),
                            child: TextFormField(
                              controller: _model.textController3,
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
                                errorText: !osnivanjeKlubaValid
                                    ? osnivanjeKlubaError
                                    : null,
                              ),
                              style: Theme.of(context).textTheme.bodyText1,
                              validator: (value) => _model
                                  .textController3Validator!(context, value),
                              onChanged: (value) {
                                setState(() {
                                  osnivanjeKlubaError =
                                      _model.textController3Validator!(
                                              context, value) ??
                                          '';
                                  osnivanjeKlubaValid =
                                      osnivanjeKlubaError!.isEmpty;
                                });
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      width: 200,
                      height: 400,
                      child: Column(
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          Text(
                            'Grad *',
                            textAlign: TextAlign.start,
                            style: Theme.of(context).textTheme.bodyText1,
                          ),
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
                            padding: const EdgeInsets.symmetric(horizontal: 16),
                            child: DropdownButton<GradResponse>(
                              isExpanded: true,
                              value: _model.dropDownValue1,
                              onChanged: (val) {
                                setState(() => _model.dropDownValue1 = val!);
                              },
                              items: gradResults
                                  .map((val) => DropdownMenuItem(
                                      value: val, child: Text(val.naziv ?? "")))
                                  .toList(),
                              style: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: Colors.black,
                              ),
                              icon: const Icon(
                                Icons.keyboard_arrow_down_rounded,
                                color: Colors.grey,
                                size: 24,
                              ),
                              underline: const SizedBox(),
                            ),
                          ),
                          if (widget.klubId == null)
                            Padding(
                              padding: const EdgeInsetsDirectional.fromSTEB(
                                  0, 30, 0, 0),
                              child: Text(
                                'Liga *',
                                style: Theme.of(context).textTheme.bodyText1,
                              ),
                            ),
                          if (widget.klubId == null)
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
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 16),
                              child: DropdownButton<LigaResponse>(
                                isExpanded: true,
                                value: _model.dropDownValue2,
                                onChanged: (val) => setState(
                                    () => _model.dropDownValue2 = val!),
                                items: ligaResults
                                    .map((val) => DropdownMenuItem(
                                        value: val,
                                        child: Text(val.naziv ?? "")))
                                    .toList(),
                                style: const TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black,
                                ),
                                icon: const Icon(
                                  Icons.keyboard_arrow_down_rounded,
                                  color: Colors.grey,
                                  size: 24,
                                ),
                                underline: const SizedBox(),
                              ),
                            ),
                          Padding(
                            padding: const EdgeInsets.only(top: 20),
                            child: GestureDetector(
                              onTap: _openImageUploadDialog,
                              child: Container(
                                width: 200,
                                height: 200,
                                child: Column(
                                  mainAxisSize: MainAxisSize.max,
                                  children: [
                                    const Text("Grb *"),
                                    if (_model.grb == null)
                                      Icon(
                                        Icons.image_outlined,
                                        color: Theme.of(context).primaryColor,
                                        size: 80,
                                      ),
                                    if (_model.grb != null)
                                      Image.memory(
                                        _model.grb ??
                                            Uint8List.fromList([10, 20, 30]),
                                        width: 150,
                                        height: 150,
                                      )
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsetsDirectional.fromSTEB(0, 20, 0, 0),
                  child: ElevatedButton(
                    onPressed: () {
                      !_model.areTextFieldsValid(
                              nazivKlubaValid,
                              nadimakKlubaValid,
                              osnivanjeKlubaValid,
                              _base64Image,
                              widget.klubId != null)
                          ? null
                          : saveData();
                    },
                    child: Text(
                      widget.klubId != null ? 'Uredi' : 'Dodaj',
                      style: TextStyle(
                        fontFamily: 'Readex Pro',
                        color: Colors.white,
                      ),
                    ),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: !_model.areTextFieldsValid(
                              nazivKlubaValid,
                              nadimakKlubaValid,
                              osnivanjeKlubaValid,
                              _base64Image,
                              widget.klubId != null)
                          ? Colors.grey
                          : Theme.of(context).primaryColor,
                      padding:
                          const EdgeInsetsDirectional.fromSTEB(24, 0, 24, 0),
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
        ),
      ),
    );
  }
}
