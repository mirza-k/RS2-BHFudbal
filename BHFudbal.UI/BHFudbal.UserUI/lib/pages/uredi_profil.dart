import 'package:flutter/material.dart';
import 'package:flutter_application_1/models/request/uredi_korisnika_request.dart';
import 'package:flutter_application_1/models/response/korisnik_response.dart';
import 'package:flutter_application_1/providers/korisnik_provider.dart';
import 'package:flutter_application_1/utils/auth_utils.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class UrediProfil extends StatefulWidget {
  @override
  UrediProfilState createState() => UrediProfilState();
}

class UrediProfilState extends State<UrediProfil> {
  TextEditingController _usernameController = TextEditingController();
  TextEditingController _imeController = TextEditingController();
  TextEditingController _prezimeController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool _isButtonEnabled = false;
  KorisnikResponse? result;

  Future<void> _fetchKorisnik() async {
    var korisnikProvider = context.read<KorisnikProvider>();
    var response = await korisnikProvider.getLoggedUser();
    setState(() {
      result = response;
      _usernameController.text = response.username ?? "";
      _imeController.text = response.ime ?? "";
      _prezimeController.text = response.prezime ?? "";
    });
  }

  @override
  void initState() {
    super.initState();
    _fetchKorisnik();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          padding: EdgeInsets.all(16.0),
          child: Form(
            key: _formKey,
            onChanged: () {
              setState(() {
                _isButtonEnabled = _formKey.currentState!.validate();
              });
            },
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  width: 250,
                  child: Text(
                    "Uredi profil",
                    style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                    textAlign: TextAlign.center,
                  ),
                ),
                SizedBox(height: 20.0),
                Container(
                  width: 250,
                  child: TextFormField(
                    controller: _imeController,
                    decoration: InputDecoration(labelText: 'Ime'),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Ime je obavezno polje';
                      }
                      return null;
                    },
                  ),
                ),
                Container(
                  width: 250,
                  child: TextFormField(
                    controller: _prezimeController,
                    decoration: InputDecoration(labelText: 'Prezime'),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Prezime je obavezno polje';
                      }
                      return null;
                    },
                  ),
                ),
                Container(
                  width: 250,
                  child: TextFormField(
                    controller: _usernameController,
                    decoration: InputDecoration(labelText: 'Username'),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Username je obavezno polje';
                      }
                      bool emailValid = RegExp(
                              r'^(([^<>()\[\]\\.,;:\s@"]+(\.[^<>()\[\]\\.,;:\s@"]+)*)|(".+"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$')
                          .hasMatch(value);
                      if (!emailValid) return "Unesite validan email";
                      return null;
                    },
                  ),
                ),
                SizedBox(height: 20.0),
                ElevatedButton(
                  onPressed: _isButtonEnabled ? _saveProfile : null,
                  child: const Text('Spasi'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _saveProfile() async {
    var request = UrediKorisnikaRequest(
      korisnikId: Authorization.id ?? 0,
      username: _usernameController.text,
      ime: _imeController.text,
      prezime: _prezimeController.text,
    );
    var korisnikProvider = context.read<KorisnikProvider>();
    var response = await korisnikProvider.urediKorisnika(request);
    showDialog(
        context: context,
        builder: (BuildContext context) => AlertDialog(
              title: Text(""),
              content: Text("Uspjesno ste uredili profil."),
              actions: [
                TextButton(
                    onPressed: () => Navigator.pop(context), child: Text("OK"))
              ],
            ));
  }

  @override
  void dispose() {
    _usernameController.dispose();
    _imeController.dispose();
    _prezimeController.dispose();
    super.dispose();
  }
}
