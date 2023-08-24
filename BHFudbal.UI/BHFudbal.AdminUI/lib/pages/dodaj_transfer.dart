import 'package:flutter/material.dart';
import '../models/dodaj_transfer_model.dart';

class DodajTransferWidget extends StatefulWidget {
  const DodajTransferWidget({Key? key}) : super(key: key);

  @override
  _DodajTransferWidgetState createState() => _DodajTransferWidgetState();
}

class _DodajTransferWidgetState extends State<DodajTransferWidget> {
  late DodajTransferModel _model;
  late bool cijenaValid;
  late bool godineUgovoraValid;
  String cijenaError = "";
  String godineUgovoraError = "";
  final scaffoldKey = GlobalKey<ScaffoldState>();

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
    _model = DodajTransferModel();
    _model.cijenaController = new TextEditingController();
    _model.godineUgovoraController = new TextEditingController();

    _model.cijenaControllerValidator = fourDigitValidator;
    cijenaValid = _model.cijenaControllerValidator!(
            context, _model.cijenaController!.text) ==
        null;

    _model.godineUgovoraControllerValidator = fourDigitValidator;
    godineUgovoraValid = _model.godineUgovoraControllerValidator!(
            context, _model.godineUgovoraController!.text) ==
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
      onTap: () => FocusScope.of(context).unfocus(),
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
                  color: Colors.white,
                  size: 40,
                ),
              ),
              Text(
                'Dodaj transfer',
                style: TextStyle(
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
          child: Padding(
            padding: EdgeInsets.all(20),
            child: Column(
              mainAxisSize: MainAxisSize.max,
              children: [
                Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      width: 200,
                      height: 400,
                      child: Column(
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          Text(
                            'Liga',
                            style: TextStyle(
                              fontFamily: 'Roboto',
                              fontSize: 14,
                              color: Colors.black,
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
                              value: _model.ligaId,
                              onChanged: (val) =>
                                  setState(() => _model.ligaId = val!),
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
                              underline: SizedBox(),
                            ),
                          ),
                          Padding(
                            padding:
                                EdgeInsetsDirectional.fromSTEB(0, 30, 0, 0),
                            child: Text(
                              'Klub',
                              style: TextStyle(
                                fontFamily: 'Roboto',
                                fontSize: 14,
                                color: Colors.black,
                              ),
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
                              underline: SizedBox(),
                            ),
                          ),
                          Padding(
                            padding:
                                EdgeInsetsDirectional.fromSTEB(0, 30, 0, 0),
                            child: Text(
                              'Fudbaler',
                              style: TextStyle(
                                fontFamily: 'Roboto',
                                fontSize: 14,
                                color: Colors.black,
                              ),
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
                              value: _model.fudbalerId,
                              onChanged: (val) =>
                                  setState(() => _model.fudbalerId = val!),
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
                              underline: SizedBox(),
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
                            'Cijena',
                            style: TextStyle(
                              fontFamily: 'Roboto',
                              fontSize: 14,
                              color: Colors.black,
                            ),
                          ),
                          TextFormField(
                            controller: _model.cijenaController,
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
                              errorText: !cijenaValid ? cijenaError : null,
                            ),
                            style: Theme.of(context).textTheme.bodyText1,
                            validator: (value) => _model
                                .cijenaControllerValidator!(context, value),
                            onChanged: (value) {
                              setState(() {
                                cijenaError = _model.cijenaControllerValidator!(
                                        context, value) ??
                                    '';
                                cijenaValid = cijenaError.isEmpty;
                              });
                            },
                          ),
                          Padding(
                            padding:
                                EdgeInsetsDirectional.fromSTEB(0, 30, 0, 0),
                            child: Text(
                              'Broj godina ugovora',
                              style: TextStyle(
                                fontFamily: 'Roboto',
                                fontSize: 14,
                                color: Colors.black,
                              ),
                            ),
                          ),
                          TextFormField(
                            controller: _model.godineUgovoraController,
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
                              errorText: !godineUgovoraValid
                                  ? godineUgovoraError
                                  : null,
                            ),
                            style: Theme.of(context).textTheme.bodyText1,
                            validator: (value) =>
                                _model.godineUgovoraControllerValidator!(
                                    context, value),
                            onChanged: (value) {
                              setState(() {
                                godineUgovoraError =
                                    _model.godineUgovoraControllerValidator!(
                                            context, value) ??
                                        '';
                                godineUgovoraValid = godineUgovoraError.isEmpty;
                              });
                            },
                          ),
                        ],
                      ),
                    ),
                    Container(
                      width: 100,
                      height: 100,
                      child: Icon(
                        Icons.repeat,
                        color: Colors.black,
                        size: 100,
                      ),
                    ),
                    Container(
                      width: 200,
                      height: 300,
                      child: Column(
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          Text(
                            'Liga',
                            style: TextStyle(
                              fontFamily: 'Roboto',
                              fontSize: 14,
                              color: Colors.black,
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
                              value: _model.ligaTargetId,
                              onChanged: (val) =>
                                  setState(() => _model.ligaTargetId = val!),
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
                              underline: SizedBox(),
                            ),
                          ),
                          Padding(
                            padding:
                                EdgeInsetsDirectional.fromSTEB(0, 30, 0, 0),
                            child: Text(
                              'Klub',
                              style: TextStyle(
                                fontFamily: 'Roboto',
                                fontSize: 14,
                                color: Colors.black,
                              ),
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
                              value: _model.klubTargetId,
                              onChanged: (val) =>
                                  setState(() => _model.klubTargetId = val!),
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
                              underline: SizedBox(),
                            ),
                          ),
                          Padding(
                            padding:
                                EdgeInsetsDirectional.fromSTEB(0, 30, 0, 0),
                            child: ElevatedButton(
                              onPressed: () {
                                !_model.areTextFieldsValid(
                                        cijenaValid, godineUgovoraValid)
                                    ? null
                                    : print('Button pressed ...');
                              },
                              child: Text(
                                'Završi',
                                style: TextStyle(
                                  fontFamily: 'Readex Pro',
                                  color: Colors.white,
                                ),
                              ),
                              style: ElevatedButton.styleFrom(
                                padding: EdgeInsets.symmetric(horizontal: 24),
                                elevation: 3,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                backgroundColor: !_model.areTextFieldsValid(
                                        cijenaValid, godineUgovoraValid)
                                    ? Colors.grey
                                    : Theme.of(context).primaryColor,
                                textStyle: TextStyle(
                                  fontFamily: 'Readex Pro',
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                        ],
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
