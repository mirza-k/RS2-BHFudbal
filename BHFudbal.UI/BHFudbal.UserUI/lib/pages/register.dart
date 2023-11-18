// ignore_for_file: prefer_const_constructors, use_build_context_synchronously
import 'package:flutter/material.dart';
import 'package:flutter_application_1/models/request/register_request.dart';
import 'package:flutter_application_1/providers/auth_provider.dart';
import 'package:provider/provider.dart';

class Register extends StatefulWidget {
  const Register({super.key});

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passController = TextEditingController();
  TextEditingController imeController = TextEditingController();
  TextEditingController prezimeController = TextEditingController();
  late AuthProvider _authProvider;

  final _formfield = GlobalKey<FormState>();
  bool passToggle = true;

  void register(String email, String pass, String ime, String prezime) async {
    try {
      _authProvider = context.read<AuthProvider>();
      var register = RegisterRequest(
          ime: ime,
          prezime: prezime,
          username: email,
          password: pass,
          datumRodjenja: DateTime.now());
      var request = RegisterRequest().toJson(register);
      var response = await _authProvider.register(request);
      if (response) {
        showDialog(
            context: context,
            builder: (BuildContext context) => AlertDialog(
                  title: const Text("Registracija uspjesna!"),
                  actions: [
                    TextButton(
                        onPressed: () =>
                            Navigator.of(context).pushNamed('/login'),
                        child: const Text("OK"))
                  ],
                ));
      } else {
        showDialog(
            context: context,
            builder: (BuildContext context) => AlertDialog(
                  title: Text("Error"),
                  content: Text("Došlo je do greške! Molimo pokušajte ponovo."),
                  actions: [
                    TextButton(
                        onPressed: () => Navigator.pop(context),
                        child: Text("OK"))
                  ],
                ));
      }
    } catch (e) {
      showDialog(
          context: context,
          builder: (BuildContext context) => AlertDialog(
                title: Text("Error"),
                content: Text(e.toString()),
                actions: [
                  TextButton(
                      onPressed: () => Navigator.pop(context),
                      child: Text("OK"))
                ],
              ));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Form(
        key: _formfield,
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Center(
                child: Text(
                  "BH Fudbal",
                  style: TextStyle(fontSize: 30.0, fontWeight: FontWeight.bold),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 30.0),
              ),
              Container(
                width: 320,
                height: 60,
                child: TextFormField(
                  controller: imeController,
                  keyboardType: TextInputType.text,
                  decoration: const InputDecoration(
                      labelText: "Ime",
                      border: OutlineInputBorder(),
                      prefixIcon: Icon(Icons.email)),
                  validator: (value) {
                    if (value!.isEmpty) return "Unesite Vaše ime";
                    if (imeController.text.length < 5)
                      return "Ime mora biti duže od 5 slova";
                  },
                ),
              ),
              SizedBox(height: 10),
              Container(
                width: 320,
                height: 60,
                child: TextFormField(
                  controller: prezimeController,
                  keyboardType: TextInputType.text,
                  decoration: const InputDecoration(
                      labelText: "Prezime",
                      border: OutlineInputBorder(),
                      prefixIcon: Icon(Icons.email)),
                  validator: (value) {
                    if (value!.isEmpty) return "Unesite Vaše prezime";
                    if (prezimeController.text.length < 5)
                      return "Prezime mora biti duže od 5 slova";
                  },
                ),
              ),
              SizedBox(height: 10),
              Container(
                width: 320,
                height: 60,
                child: TextFormField(
                  controller: emailController,
                  keyboardType: TextInputType.emailAddress,
                  decoration: const InputDecoration(
                      labelText: "Email",
                      border: OutlineInputBorder(),
                      prefixIcon: Icon(Icons.email)),
                  validator: (value) {
                    if (value!.isEmpty) return "Unesite Vaš email";
                    bool emailValid = RegExp(
                            r'^(([^<>()\[\]\\.,;:\s@"]+(\.[^<>()\[\]\\.,;:\s@"]+)*)|(".+"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$')
                        .hasMatch(value);
                    if (!emailValid) return "Unesite validan email";
                  },
                ),
              ),
              SizedBox(height: 10),
              Container(
                width: 320,
                height: 60,
                child: TextFormField(
                  controller: passController,
                  keyboardType: TextInputType.visiblePassword,
                  obscureText: passToggle,
                  decoration: InputDecoration(
                      labelText: "Password ",
                      border: OutlineInputBorder(),
                      prefixIcon: Icon(Icons.lock),
                      suffix: InkWell(
                        child: Icon(passToggle
                            ? Icons.visibility
                            : Icons.visibility_off),
                        onTap: () {
                          setState(() {
                            passToggle = !passToggle;
                          });
                        },
                      )),
                  validator: (value) {
                    if (value!.isEmpty) return "Unesite Vaš password";
                    bool passValid = RegExp(
                            r"^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[@$!%*?&])[A-Za-z\d@$!%*?&]{8,}$")
                        .hasMatch(value);
                    if (!passValid) {
                      return "Password mora sadržavati 8 karaktera, jedno veliko slovo, jedno malo slovo, jedan broj i jedan specijalni znak";
                    }
                  },
                ),
              ),
              const SizedBox(
                height: 30,
              ),
              InkWell(
                onTap: () {
                  if (_formfield.currentState!.validate()) {
                    register(emailController.text, passController.text,
                        imeController.text, prezimeController.text);
                  }
                },
                child: Container(
                  height: 50,
                  decoration: BoxDecoration(
                    color: Colors.green,
                    borderRadius: BorderRadius.circular(5),
                  ),
                  child: Center(
                    child: Text("Registruj se",
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                            fontWeight: FontWeight.bold)),
                  ),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Već imaš akaunt?",
                    style: TextStyle(fontSize: 16),
                  ),
                  TextButton(
                      onPressed: () {
                        Navigator.of(context).pushNamed('/login');
                      },
                      child: Text(
                        "Uloguj se",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 18),
                      ))
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
