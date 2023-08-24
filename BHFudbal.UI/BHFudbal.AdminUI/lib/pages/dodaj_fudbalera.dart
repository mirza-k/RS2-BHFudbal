import 'package:flutter/material.dart';
import "../models/dodaj_fudbalera_model.dart";

class DodajFudbaleraWidget extends StatefulWidget {
  const DodajFudbaleraWidget({Key? key}) : super(key: key);

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

  String? nameValidator(BuildContext context, String? value) {
    if (value == null || value.isEmpty) {
      return 'Unesite vrijednost!';
    }

    if (value.length < 5) {
      return 'Najmanje 5 slova!';
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

  @override
  void initState() {
    super.initState();
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

    imeValid = _model.imeValidator!(context, _model.ime!.text) == null;
    prezimeValid =
        _model.prezimeValidator!(context, _model.prezime!.text) == null;
    visinaValid = _model.visinaValidator!(context, _model.visina!.text) == null;
    tezinaValid = _model.tezinaValidator!(context, _model.tezina!.text) == null;
    jacaNogaValid =
        _model.jacaNogaValidator!(context, _model.jacaNoga!.text) == null;
  }

  @override
  void dispose() {
    _model.dispose();

    super.dispose();
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
                  Navigator.pop(context);
                },
                child: Icon(
                  Icons.chevron_left,
                  color: Theme.of(context).scaffoldBackgroundColor,
                  size: 40,
                ),
              ),
              Text(
                'Dodaj fudbalera',
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
                                    _model.datePicked = DateTime(
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
                              _model.datePicked?.toString() ?? 'Date Time',
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
                                  Icon(
                                    Icons.image_outlined,
                                    color: Theme.of(context).primaryColor,
                                    size: 80,
                                  ),
                                  Text(
                                    'Upload sliku fudbalera',
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Padding(
                            padding:
                                EdgeInsetsDirectional.fromSTEB(0, 20, 0, 0),
                            child: Text(
                              'Klub',
                              style: Theme.of(context).textTheme.bodyText1,
                            ),
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
                            padding: EdgeInsets.symmetric(horizontal: 16),
                            child: DropdownButton<String>(
                              isExpanded: true,
                              value: _model.klubId,
                              onChanged: (val) =>
                                  setState(() => _model.klubId = val!),
                              items: ['Option 1']
                                  .map((val) => DropdownMenuItem(
                                      value: val, child: Text(val)))
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
                                        jacaNogaValid)
                                    ? null
                                    : print('Button pressed ...');
                              },
                              child: Text(
                                'Dodaj',
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
                                        jacaNogaValid)
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
