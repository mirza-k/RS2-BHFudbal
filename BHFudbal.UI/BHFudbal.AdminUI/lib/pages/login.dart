// ignore_for_file: prefer_const_constructors, library_private_types_in_public_api, sized_box_for_whitespace, prefer_const_literals_to_create_immutables

import 'package:bhfudbal_admin/pages/home.dart';
import 'package:bhfudbal_admin/providers/drzava_provider.dart';
import 'package:bhfudbal_admin/utils/util.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:bhfudbal_admin/providers/korisnik_provider.dart';
import '../models/login_model.dart';
import '../models/request/login_request.dart';
import '../providers/sezona_provider.dart';

class LoginWidget extends StatefulWidget {
  const LoginWidget({Key? key}) : super(key: key);

  @override
  _LoginWidgetState createState() => _LoginWidgetState();
}

class _LoginWidgetState extends State<LoginWidget> {
  late LoginModel _model;
  late DrzavaProvider _drzavaProvider;
  final scaffoldKey = GlobalKey<ScaffoldState>();

  String? customEmailValidator(BuildContext context, String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter an email address';
    }

    // Add more email validation rules if needed

    return null; // Return null when the email is valid
  }

  String? customPasswordValidator(BuildContext context, String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter an password';
    }

    // Add more email validation rules if needed

    return null; // Return null when the email is valid
  }

  @override
  void initState() {
    super.initState();
    _model = LoginModel();
    _model.initState(context);
    _model.emailAddressControllerValidator = customEmailValidator;
    _model.passwordControllerValidator = customPasswordValidator;
    _model.emailAddressController ??= TextEditingController();
    _model.passwordController ??= TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    _drzavaProvider = context.read<DrzavaProvider>();
    return GestureDetector(
      onTap: () => FocusScope.of(context).requestFocus(_model.unfocusNode),
      child: Scaffold(
        key: scaffoldKey,
        backgroundColor: Colors.white,
        body: SafeArea(
          top: true,
          child: Row(
            mainAxisSize: MainAxisSize.max,
            children: [
              Expanded(
                flex: 8,
                child: Container(
                  width: 100,
                  height: double.infinity,
                  decoration: BoxDecoration(
                    color: Colors.white,
                  ),
                  alignment: AlignmentDirectional(0, -1),
                  child: SingleChildScrollView(
                    child: Column(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          width: double.infinity,
                          height: 140,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.only(
                              bottomLeft: Radius.circular(16),
                              bottomRight: Radius.circular(16),
                              topLeft: Radius.circular(0),
                              topRight: Radius.circular(0),
                            ),
                          ),
                          alignment: AlignmentDirectional(-1, 0),
                          child: Padding(
                            padding:
                                EdgeInsetsDirectional.fromSTEB(32, 0, 0, 0),
                            child: Text(
                              'BH Fudbal Administrator',
                              style: TextStyle(
                                  fontFamily: 'Plus Jakarta Sans',
                                  color: Color(0xFF101213),
                                  fontSize: 36,
                                  fontWeight: FontWeight.w600),
                            ),
                          ),
                        ),
                        Align(
                          alignment: AlignmentDirectional(0, 0),
                          child: Padding(
                            padding:
                                EdgeInsetsDirectional.fromSTEB(32, 32, 32, 32),
                            child: Column(
                              mainAxisSize: MainAxisSize.max,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Dobrodošli nazad',
                                  style: TextStyle(
                                    fontFamily: 'Plus Jakarta Sans',
                                    color: Color(0xFF101213),
                                    fontSize: 36,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsetsDirectional.fromSTEB(
                                      0, 12, 0, 24),
                                  child: Text(
                                    'Započnimo tako što ćete popuniti obrazac ispod',
                                    style: TextStyle(
                                      fontFamily: 'Plus Jakarta Sans',
                                      color: Color(0xFF57636C),
                                      fontSize: 14,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsetsDirectional.fromSTEB(
                                      0, 0, 0, 16),
                                  child: Container(
                                    width: 370,
                                    child: TextFormField(
                                      controller: _model.emailAddressController,
                                      autofocus: true,
                                      autofillHints: [AutofillHints.email],
                                      obscureText: false,
                                      decoration: InputDecoration(
                                        labelText: 'Email',
                                        labelStyle: TextStyle(
                                          fontFamily: 'Plus Jakarta Sans',
                                          color: Color(0xFF57636C),
                                          fontSize: 14,
                                          fontWeight: FontWeight.w500,
                                        ),
                                        enabledBorder: OutlineInputBorder(
                                          borderSide: BorderSide(
                                            color: Color(0xFFF1F4F8),
                                            width: 2,
                                          ),
                                          borderRadius:
                                              BorderRadius.circular(12),
                                        ),
                                        focusedBorder: OutlineInputBorder(
                                          borderSide: BorderSide(
                                            color: Color(0xFF4B39EF),
                                            width: 2,
                                          ),
                                          borderRadius:
                                              BorderRadius.circular(12),
                                        ),
                                        errorBorder: OutlineInputBorder(
                                          borderSide: BorderSide(
                                            color: Color(0xFFE0E3E7),
                                            width: 2,
                                          ),
                                          borderRadius:
                                              BorderRadius.circular(12),
                                        ),
                                        focusedErrorBorder: OutlineInputBorder(
                                          borderSide: BorderSide(
                                            color: Color(0xFFE0E3E7),
                                            width: 2,
                                          ),
                                          borderRadius:
                                              BorderRadius.circular(12),
                                        ),
                                        filled: true,
                                        fillColor: Color(0xFFF1F4F8),
                                      ),
                                      style: TextStyle(
                                        fontFamily: 'Plus Jakarta Sans',
                                        color: Color(0xFF101213),
                                        fontSize: 14,
                                        fontWeight: FontWeight.w500,
                                      ),
                                      keyboardType: TextInputType.emailAddress,
                                      validator: (value) => _model
                                              .emailAddressControllerValidator!(
                                          context, value),
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsetsDirectional.fromSTEB(
                                      0, 0, 0, 16),
                                  child: Container(
                                    width: 370,
                                    child: TextFormField(
                                      controller: _model.passwordController,
                                      autofocus: true,
                                      autofillHints: [AutofillHints.password],
                                      obscureText: !_model.passwordVisibility,
                                      decoration: InputDecoration(
                                        labelText: 'Šifra',
                                        labelStyle: TextStyle(
                                          fontFamily: 'Plus Jakarta Sans',
                                          color: Color(0xFF57636C),
                                          fontSize: 14,
                                          fontWeight: FontWeight.w500,
                                        ),
                                        enabledBorder: OutlineInputBorder(
                                          borderSide: BorderSide(
                                            color: Color(0xFFF1F4F8),
                                            width: 2,
                                          ),
                                          borderRadius:
                                              BorderRadius.circular(12),
                                        ),
                                        focusedBorder: OutlineInputBorder(
                                          borderSide: BorderSide(
                                            color: Color(0xFF4B39EF),
                                            width: 2,
                                          ),
                                          borderRadius:
                                              BorderRadius.circular(12),
                                        ),
                                        errorBorder: OutlineInputBorder(
                                          borderSide: BorderSide(
                                            color: Color(0xFFE0E3E7),
                                            width: 2,
                                          ),
                                          borderRadius:
                                              BorderRadius.circular(12),
                                        ),
                                        focusedErrorBorder: OutlineInputBorder(
                                          borderSide: BorderSide(
                                            color: Color(0xFFE0E3E7),
                                            width: 2,
                                          ),
                                          borderRadius:
                                              BorderRadius.circular(12),
                                        ),
                                        filled: true,
                                        fillColor: Color(0xFFF1F4F8),
                                        suffixIcon: InkWell(
                                          onTap: () => setState(
                                            () => _model.passwordVisibility =
                                                !_model.passwordVisibility,
                                          ),
                                          focusNode:
                                              FocusNode(skipTraversal: true),
                                          child: Icon(
                                            _model.passwordVisibility
                                                ? Icons.visibility_outlined
                                                : Icons.visibility_off_outlined,
                                            color: Color(0xFF57636C),
                                            size: 24,
                                          ),
                                        ),
                                      ),
                                      style: TextStyle(
                                        fontFamily: 'Plus Jakarta Sans',
                                        color: Color(0xFF101213),
                                        fontSize: 14,
                                        fontWeight: FontWeight.w500,
                                      ),
                                      validator: (value) =>
                                          _model.passwordControllerValidator!(
                                              context, value),
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsetsDirectional.fromSTEB(
                                      0, 0, 0, 16),
                                  child: ElevatedButton(
                                    onPressed: () async {
                                      var username =
                                          _model.emailAddressController?.text;
                                      var password =
                                          _model.passwordController?.text;
                                      try {
                                        var _korisnikProvider =
                                            context.read<KorisnikProvider>();
                                        var login = LoginRequest(
                                            username: username,
                                            password: password,
                                            adminPage: true);
                                        var request =
                                            LoginRequest().toJson(login);
                                        var result = await _korisnikProvider
                                            .login(request);
                                        if (result > 0) {
                                          Authorization.username = username;
                                          Authorization.password = password;
                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      Home()));
                                        } else {
                                          showDialog(
                                              context: context,
                                              builder: (BuildContext context) =>
                                                  AlertDialog(
                                                    title: Text("Error"),
                                                    content: Text(
                                                        "Neispravan username ili password."),
                                                    actions: [
                                                      TextButton(
                                                          onPressed: () =>
                                                              Navigator.pop(
                                                                  context),
                                                          child: Text("OK"))
                                                    ],
                                                  ));
                                        }
                                      } on Exception catch (e) {
                                        showDialog(
                                            context: context,
                                            builder: (BuildContext context) =>
                                                AlertDialog(
                                                  title: Text("Error"),
                                                  content: Text(e.toString()),
                                                  actions: [
                                                    TextButton(
                                                        onPressed: () =>
                                                            Navigator.pop(
                                                                context),
                                                        child: Text("OK"))
                                                  ],
                                                ));
                                      }
                                    },
                                    style: ElevatedButton.styleFrom(
                                      primary: Color(0xFF4B39EF),
                                      onPrimary: Colors.white,
                                      elevation: 3,
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(12),
                                      ),
                                      minimumSize: Size(377, 44),
                                      padding: EdgeInsets.zero,
                                    ),
                                    child: Text(
                                      'Uloguj se',
                                      style: TextStyle(
                                        fontFamily: 'Plus Jakarta Sans',
                                        color: Colors.white,
                                        fontSize: 16,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsetsDirectional.fromSTEB(
                                      0, 50, 0, 16),
                                  child: ElevatedButton(
                                    onPressed: () async {
                                      var username =
                                          _model.emailAddressController?.text;
                                      var password =
                                          _model.passwordController?.text;

                                      // Authorization.username = username;
                                      // Authorization.password = password;
                                      try {
                                        showDialog(
                                            context: context,
                                            builder: (BuildContext context) =>
                                                AlertDialog(
                                                  title: Text("Napoemena!"),
                                                  content: Text(
                                                      "Prilikom klika, generisat ce se nova sezona sa odigranim utakmicama."),
                                                  actions: [
                                                    TextButton(
                                                        onPressed: () async {
                                                          print(
                                                              "Generisanje...");
                                                          var _sezonaProvider =
                                                              context.read<
                                                                  SezonaProvider>();
                                                          var rezultat =
                                                              await _sezonaProvider
                                                                  .GenerisiSezonu();
                                                          if (rezultat == "") {
                                                            Future.delayed(
                                                                Duration.zero,
                                                                () {
                                                              Navigator.pop(
                                                                  context);
                                                            });
                                                          } else {
                                                            showDialog(
                                                                context:
                                                                    context,
                                                                builder: (BuildContext
                                                                        context) =>
                                                                    AlertDialog(
                                                                      title: Text(
                                                                          "Error"),
                                                                      content: Text(
                                                                          rezultat),
                                                                      actions: [
                                                                        TextButton(
                                                                            onPressed: () =>
                                                                                Navigator.pop(context),
                                                                            child: Text("OK"))
                                                                      ],
                                                                    ));
                                                          }
                                                        },
                                                        child: Text("Generisi"))
                                                  ],
                                                ));
                                      } on Exception catch (e) {
                                        showDialog(
                                            context: context,
                                            builder: (BuildContext context) =>
                                                AlertDialog(
                                                  title: Text("Error"),
                                                  content: Text(e.toString()),
                                                  actions: [
                                                    TextButton(
                                                        onPressed: () =>
                                                            Navigator.pop(
                                                                context),
                                                        child: Text("OK"))
                                                  ],
                                                ));
                                      }
                                    },
                                    style: ElevatedButton.styleFrom(
                                      primary: Colors.green,
                                      onPrimary: Colors.white,
                                      elevation: 4,
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(15),
                                      ),
                                      minimumSize: Size(377, 54),
                                      padding: EdgeInsets.zero,
                                    ),
                                    child: Text(
                                      'Generisi sezonu',
                                      style: TextStyle(
                                        fontFamily: 'Plus Jakarta Sans',
                                        color: Colors.white,
                                        fontSize: 16,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
