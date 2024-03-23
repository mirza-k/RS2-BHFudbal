// ignore_for_file: use_build_context_synchronously

import 'package:bhfudbal_admin/models/request/transfer_request.dart';
import 'package:bhfudbal_admin/models/response/transfer_response.dart';
import 'package:bhfudbal_admin/providers/sezona_provider.dart';
import 'package:bhfudbal_admin/providers/transfer_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/dodaj_transfer_model.dart';
import '../models/response/fudbaler_response.dart';
import '../models/response/klub_response.dart';
import '../models/response/liga_response.dart';
import '../providers/fudbaler_provider.dart';
import '../providers/klub_provider.dart';
import '../providers/liga_provider.dart';

class DodajTransferWidget extends StatefulWidget {
  const DodajTransferWidget({Key? key}) : super(key: key);

  @override
  _DodajTransferWidgetState createState() => _DodajTransferWidgetState();
}

class _DodajTransferWidgetState extends State<DodajTransferWidget> {
  late DodajTransferModel _model;
  static const globalErrorMessage = "Nevalidno polje!";
  String cijenaError = "";
  String godineUgovoraError = "";
  String ligaPrimaryError = "";
  String klubPrimaryError = "";
  String fudbalerValidError = "";
  String ligaSecondaryError = "";
  String klubSecondaryError = "";
  final scaffoldKey = GlobalKey<ScaffoldState>();
  late LigaProvider _ligaProvider;
  late KlubProvider _klubProvider;
  late FudbalerProvider _fudbalerProvider;
  late TransferProvider _transferProvider;
  late SezonaProvider _sezonaProvider;
  List<LigaResponse> ligaResults = [];
  List<FudbalerResponse> fudbalerResults = [];
  List<KlubResponse> klubResults = [];
  List<KlubResponse> klubTargetResults = [];
  List<LigaResponse> ligaTargetResults = [];

  late bool ligaPrimaryValid = true;
  late bool klubPrimaryValid = true;
  late bool fudbalerValid = true;

  late bool cijenaValid = true;
  late bool godineUgovoraValid = true;

  late bool ligaSecondaryValid = true;
  late bool klubSecondaryValid = true;

  void doValidation() {
    setState(() {
      ligaPrimaryValid = _model.liga != null;
      ligaPrimaryError = globalErrorMessage;

      klubPrimaryValid = _model.klub != null;
      klubPrimaryError = globalErrorMessage;

      fudbalerValid = _model.fudbaler != null;
      fudbalerValidError = globalErrorMessage;

      cijenaValid = _model.cijenaController!.text.isNotEmpty;
      cijenaError = globalErrorMessage;

      godineUgovoraValid = _model.godineUgovoraController!.text.isNotEmpty;
      godineUgovoraError = globalErrorMessage;

      ligaSecondaryValid = _model.ligaTarget != null;
      ligaSecondaryError = globalErrorMessage;

      klubSecondaryValid = _model.klubTarget != null;
      klubSecondaryError = globalErrorMessage;
    });
  }

  Future<void> _fetchLige() async {
    _ligaProvider = context.read<LigaProvider>();
    var result = await _ligaProvider.get(true);
    setState(() {
      ligaResults = result.result;
      ligaTargetResults = result.result;
    });
  }

  Future<void> _fetchKlubovi(bool klubTarget) async {
    _klubProvider = context.read<KlubProvider>();
    int? ligaId;
    if (klubTarget) {
      if (_model.ligaTarget != null && _model.ligaTarget!.ligaId1 != 0) {
        ligaId = _model.ligaTarget!.ligaId1;
      }
    } else {
      if (_model.liga != null && _model.liga!.ligaId1 != 0) {
        ligaId = _model.liga!.ligaId1;
      }
    }

    if (ligaId == null || ligaId == 0) return;

    var result = await _klubProvider.get(ligaId);
    setState(() {
      if (klubTarget) {
        _model.klubTarget = null;
        klubTargetResults = result.result;
      } else {
        _model.klub = null;
        klubResults = result.result;
      }
    });
  }

  void clearForm() {
    setState(() {
      _model.cijenaController!.text = "";
      cijenaValid = true;
      _model.klubTarget = null;
      _model.klub = null;
      _model.godineUgovoraController!.text = "";
      godineUgovoraValid = true;
      _model.fudbaler = null;
      _model.klub = null;
      _model.liga = null;
      _model.ligaTarget = null;
      fudbalerResults = [];
      klubResults = [];
      klubTargetResults = [];
    });
  }

  Future<void> _fetchFudbaleri() async {
    _fudbalerProvider = context.read<FudbalerProvider>();
    if (_model.klub != null) {
      var klubId = _model.klub!.klubId;
      if (klubId != null && klubId != 0) {
        var result = await _fudbalerProvider.get(klubId);
        setState(() {
          _model.fudbaler = null;
          fudbalerResults = result.result;
        });
      }
    }
  }

  void saveData() async {
    _transferProvider = context.read<TransferProvider>();
    var transfer = TransferRequest(
        cijena: int.tryParse(_model.cijenaController!.text),
        klubId: _model.klubTarget!.klubId,
        stariKlubId: _model.klub!.klubId,
        brojGodinaUgovora: int.tryParse(_model.godineUgovoraController!.text),
        fudbalerId: _model.fudbaler!.fudbalerId);
    var request = TransferRequest().toJson(transfer);
    var errorMessage = await isTransferRequestValid(transfer);
    if (errorMessage.isEmpty) {
      var response = await _transferProvider.post(request);
      if (response) {
        await _fetchFudbaleri();
        clearForm();
        showDialog(
            context: context,
            builder: (BuildContext context) => AlertDialog(
                  title: const Text("Uspjesno izvrsen transfer!"),
                  actions: [
                    TextButton(
                        onPressed: () => Navigator.pop(context),
                        child: const Text("OK"))
                  ],
                ));
      }
    } else {
      showDialog(
          context: context,
          builder: (BuildContext context) => AlertDialog(
                title: Text("Error"),
                content: Text(errorMessage),
                actions: [
                  TextButton(
                      onPressed: () => Navigator.pop(context),
                      child: Text("OK"))
                ],
              ));
    }
  }

  Future<String> isTransferRequestValid(TransferRequest transfer) async {
    if (transfer.brojGodinaUgovora == 0)
      return "Broj godina ugovora mora biti veći od 0!";

    if (transfer.cijena == 0) return "Cijena mora biti veća od 0!";

    if (transfer.klubId == transfer.stariKlubId)
      return "Nemoguće napraviti transfer između dva ista kluba!";

    _sezonaProvider = context.read<SezonaProvider>();
    var sezone = await _sezonaProvider.get();
    var aktivnaSezona = sezone.result.firstWhere((x) => x.aktivna != null
        ? x.aktivna == true
            ? true
            : false
        : false);
    var transferi = await _transferProvider.get(aktivnaSezona.sezonaId);
    var alreadyTrasferedThisSeason = transferi.result.firstWhere(
        (x) => x.fudbalerId == transfer.fudbalerId,
        orElse: () => TransferResponse(
            imeFudbalera: "",
            cijena: 0,
            stariKlub: "",
            brojGodinaUgovora: 0,
            nazivKluba: ""));
    if (alreadyTrasferedThisSeason.imeFudbalera!.isNotEmpty)
      return "Fudbaler vec izvrsio transfer ove sezone!";

    return "";
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

  String? onlyNumbers(BuildContext context, String? value) {
    if (value == null || value.isEmpty) {
      return 'Unesite vrijednost!';
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

    _fetchLige();
  }

  void appendCijenaValidation() {
    _model.cijenaControllerValidator = onlyNumbers;
    cijenaValid = _model.cijenaControllerValidator!(
            context, _model.cijenaController!.text) ==
        null;
  }

  void appendGodineUgovoraValidation() {
    _model.godineUgovoraControllerValidator = onlyNumbers;
    godineUgovoraValid = _model.godineUgovoraControllerValidator!(
            context, _model.godineUgovoraController!.text) ==
        null;
  }

  void appendValidation() {
    _model.cijenaControllerValidator = onlyNumbers;
    cijenaValid = _model.cijenaControllerValidator!(
            context, _model.cijenaController!.text) ==
        null;

    _model.godineUgovoraControllerValidator = onlyNumbers;
    godineUgovoraValid = _model.godineUgovoraControllerValidator!(
            context, _model.godineUgovoraController!.text) ==
        null;
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
                  Navigator.pop(context, true);
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
                                color: !ligaPrimaryValid
                                    ? Colors.red
                                    : Theme.of(context).primaryColor,
                                width: 2,
                              ),
                            ),
                            padding: EdgeInsets.symmetric(horizontal: 16),
                            child: DropdownButton<LigaResponse>(
                              isExpanded: true,
                              value: _model.liga,
                              onChanged: (val) {
                                setState(() {
                                  _model.liga = val!;
                                  ligaPrimaryValid = true;
                                });
                                _model.fudbaler = null;
                                _fetchKlubovi(false);
                              },
                              items: ligaResults
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
                              underline: SizedBox(),
                            ),
                          ),
                          if (!ligaPrimaryValid)
                            Text(
                              ligaPrimaryError,
                              style: TextStyle(color: Colors.red, fontSize: 13),
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
                                color: klubPrimaryValid
                                    ? Theme.of(context).primaryColor
                                    : Colors.red,
                                width: 2,
                              ),
                            ),
                            padding: EdgeInsets.symmetric(horizontal: 16),
                            child: DropdownButton<KlubResponse>(
                              isExpanded: true,
                              value: _model.klub,
                              onChanged: (val) {
                                setState(() {
                                  klubPrimaryValid = true;
                                  _model.klub = val!;
                                });
                                _fetchFudbaleri();
                              },
                              items: klubResults
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
                              underline: SizedBox(),
                            ),
                          ),
                          if (!klubPrimaryValid)
                            Text(
                              klubPrimaryError,
                              style: TextStyle(color: Colors.red, fontSize: 13),
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
                                color: fudbalerValid
                                    ? Theme.of(context).primaryColor
                                    : Colors.red,
                                width: 2,
                              ),
                            ),
                            padding: EdgeInsets.symmetric(horizontal: 16),
                            child: DropdownButton<FudbalerResponse>(
                              isExpanded: true,
                              value: _model.fudbaler,
                              onChanged: (val) => setState(() {
                                _model.fudbaler = val!;
                                fudbalerValid = true;
                              }),
                              items: fudbalerResults
                                  .map((val) => DropdownMenuItem(
                                      value: val,
                                      child: Text(
                                          '${val.ime ?? ""} ${val.prezime ?? ""}')))
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
                          if (!fudbalerValid)
                            Text(
                              fudbalerValidError,
                              style: TextStyle(color: Colors.red, fontSize: 13),
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
                                  color: cijenaValid
                                      ? Theme.of(context).primaryColor
                                      : Colors.red,
                                  width: 2,
                                ),
                                borderRadius: BorderRadius.circular(8),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: cijenaValid
                                      ? Theme.of(context).primaryColor
                                      : Colors.red,
                                  width: 2,
                                ),
                                borderRadius: BorderRadius.circular(8),
                              ),
                              errorBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: Colors.red,
                                  width: 2,
                                ),
                                borderRadius: BorderRadius.circular(8),
                              ),
                              focusedErrorBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: Colors.red,
                                  width: 2,
                                ),
                                borderRadius: BorderRadius.circular(8),
                              ),
                              filled: true,
                              fillColor: Theme.of(context).backgroundColor,
                              errorText: !cijenaValid ? cijenaError : null,
                            ),
                            style: Theme.of(context).textTheme.bodyText1,
                            onChanged: (value) {
                              appendCijenaValidation();
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
                                  color: godineUgovoraValid
                                      ? Theme.of(context).primaryColor
                                      : Colors.red,
                                  width: 2,
                                ),
                                borderRadius: BorderRadius.circular(8),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: godineUgovoraValid
                                      ? Theme.of(context).primaryColor
                                      : Colors.red,
                                  width: 2,
                                ),
                                borderRadius: BorderRadius.circular(8),
                              ),
                              errorBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: Colors.red,
                                  width: 2,
                                ),
                                borderRadius: BorderRadius.circular(8),
                              ),
                              focusedErrorBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: Colors.red,
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
                              appendGodineUgovoraValidation();
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
                                color: ligaSecondaryValid
                                    ? Theme.of(context).primaryColor
                                    : Colors.red,
                                width: 2,
                              ),
                            ),
                            padding: EdgeInsets.symmetric(horizontal: 16),
                            child: DropdownButton<LigaResponse>(
                              isExpanded: true,
                              value: _model.ligaTarget,
                              onChanged: (val) {
                                setState(() {
                                  ligaSecondaryValid = true;
                                  _model.ligaTarget = val!;
                                });
                                _fetchKlubovi(true);
                              },
                              items: ligaTargetResults
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
                              underline: SizedBox(),
                            ),
                          ),
                          if (!ligaSecondaryValid)
                            Text(
                              ligaSecondaryError,
                              style: TextStyle(color: Colors.red, fontSize: 13),
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
                                color: klubSecondaryValid
                                    ? Theme.of(context).primaryColor
                                    : Colors.red,
                                width: 2,
                              ),
                            ),
                            padding: EdgeInsets.symmetric(horizontal: 16),
                            child: DropdownButton<KlubResponse>(
                              isExpanded: true,
                              value: _model.klubTarget,
                              onChanged: (val) => setState(() {
                                klubSecondaryValid = true;
                                _model.klubTarget = val!;
                              }),
                              items: klubTargetResults
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
                              underline: SizedBox(),
                            ),
                          ),
                          if (!klubSecondaryValid)
                            Text(
                              klubSecondaryError,
                              style: TextStyle(color: Colors.red, fontSize: 13),
                            ),
                          Padding(
                            padding:
                                EdgeInsetsDirectional.fromSTEB(0, 30, 0, 0),
                            child: ElevatedButton(
                              onPressed: () {
                                doValidation();
                                appendValidation();

                                !_model.areTextFieldsValid(
                                        cijenaValid, godineUgovoraValid)
                                    ? null
                                    : saveData();
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
                                backgroundColor: Theme.of(context).primaryColor,
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
