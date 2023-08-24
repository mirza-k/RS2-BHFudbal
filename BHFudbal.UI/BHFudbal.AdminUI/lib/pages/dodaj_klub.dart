// ignore_for_file: sort_child_properties_last

import 'package:flutter/material.dart';
import '../models/dodaj_klub_model.dart';

class DodajKlubWidget extends StatefulWidget {
  const DodajKlubWidget({Key? key}) : super(key: key);

  @override
  _DodajKlubWidgetState createState() => _DodajKlubWidgetState();
}

class _DodajKlubWidgetState extends State<DodajKlubWidget> {
  late DodajKlubModel _model;
  late bool nazivKlubaValid;
  late bool nadimakKlubaValid;
  late bool osnivanjeKlubaValid;
  String nazivKlubaError = "";
  String nadimakKlubaError = "";
  String osnivanjeKlubaError = "";
  final scaffoldKey = GlobalKey<ScaffoldState>();

  void _openImageUploadDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("Upload Grb"),
          content: const Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text("Upload your image here."),
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

    _model.textController1Validator = nameValidator;
    _model.textController2Validator = fourDigitValidator;
    _model.textController3Validator = nameValidator;

    nazivKlubaValid = _model.textController1Validator!(
            context, _model.textController1!.text) ==
        null;
    nadimakKlubaValid = _model.textController3Validator!(
            context, _model.textController3!.text) ==
        null;
    osnivanjeKlubaValid = _model.textController2Validator!(
            context, _model.textController2!.text) ==
        null;
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
                  Navigator.of(context).pop();
                },
                child: const Icon(
                  Icons.chevron_left,
                  color: Colors.white,
                  size: 40,
                ),
              ),
              const Padding(
                padding: EdgeInsetsDirectional.fromSTEB(30, 0, 0, 0),
                child: Text(
                  'Dodaj klub',
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
                              validator: (value) => _model
                                  .textController1Validator!(context, value),
                              onChanged: (value) {
                                setState(() {
                                  nazivKlubaError =
                                      _model.textController1Validator!(
                                              context, value) ??
                                          '';
                                  nazivKlubaValid = nazivKlubaError.isEmpty;
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
                                  .textController3Validator!(context, value),
                              onChanged: (value) {
                                setState(() {
                                  nadimakKlubaError =
                                      _model.textController3Validator!(
                                              context, value) ??
                                          '';
                                  nadimakKlubaValid = nadimakKlubaError.isEmpty;
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
                                  .textController2Validator!(context, value),
                              onChanged: (value) {
                                setState(() {
                                  osnivanjeKlubaError =
                                      _model.textController2Validator!(
                                              context, value) ??
                                          '';
                                  osnivanjeKlubaValid =
                                      osnivanjeKlubaError.isEmpty;
                                });
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      width: 200,
                      height: 300,
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
                            child: DropdownButton<String>(
                              isExpanded: true,
                              value: _model.dropDownValue1,
                              onChanged: (val) =>
                                  setState(() => _model.dropDownValue1 = val!),
                              items: ['Option 1']
                                  .map((val) => DropdownMenuItem(
                                      value: val, child: Text(val)))
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
                            padding: const EdgeInsetsDirectional.fromSTEB(
                                0, 30, 0, 0),
                            child: Text(
                              'Liga *',
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
                            padding: const EdgeInsets.symmetric(horizontal: 16),
                            child: DropdownButton<String>(
                              isExpanded: true,
                              value: _model.dropDownValue2,
                              onChanged: (val) =>
                                  setState(() => _model.dropDownValue2 = val!),
                              items: ['Option 1']
                                  .map((val) => DropdownMenuItem(
                                      value: val, child: Text(val)))
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
                                height: 100,
                                child: Column(
                                  mainAxisSize: MainAxisSize.max,
                                  children: [
                                    const Text("Grb *"),
                                    Icon(
                                      Icons.image_outlined,
                                      color: Theme.of(context).primaryColor,
                                      size: 80,
                                    ),
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
                      !_model.areTextFieldsValid(nazivKlubaValid,
                              nadimakKlubaValid, osnivanjeKlubaValid)
                          ? null
                          : print('Button pressed ...');
                    },
                    child: const Text(
                      'Dodaj',
                      style: TextStyle(
                        fontFamily: 'Readex Pro',
                        color: Colors.white,
                      ),
                    ),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: !_model.areTextFieldsValid(
                              nazivKlubaValid,
                              nadimakKlubaValid,
                              osnivanjeKlubaValid)
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
