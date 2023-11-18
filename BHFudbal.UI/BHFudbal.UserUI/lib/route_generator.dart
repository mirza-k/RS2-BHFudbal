// ignore_for_file: prefer_const_constructors
import 'package:flutter/material.dart';
import 'package:flutter_application_1/pages/detalji_utakmice.dart';
import 'package:flutter_application_1/pages/home.dart';
import 'package:flutter_application_1/pages/igraci.dart';
import 'package:flutter_application_1/pages/login.dart';
import 'package:flutter_application_1/pages/payment.dart';
import 'package:flutter_application_1/pages/register.dart';

class RouteGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    final args = settings.arguments;

    switch (settings.name) {
      case '/register':
        return MaterialPageRoute(builder: (_) => Register());
      case '/login':
        return MaterialPageRoute(builder: (_) => Login());
      case '/payment':
        return MaterialPageRoute(builder: (_) => Payment());
      case '/home':
        return MaterialPageRoute(builder: (_) => Home());
      case '/detalji-utakmice':
        if (args is List<int>) {
          return MaterialPageRoute(builder: (_) => DetaljiUtakmice(args: args));
        }
        return _errorRoute();
      case '/historija-fudbalera':
        if (args is int) {
          return MaterialPageRoute(
              builder: (_) => HistorijaFudbalera(fudbalerId: args));
        }
        return _errorRoute();
      default:
        return _errorRoute();
    }
  }

  static Route<dynamic> _errorRoute() {
    return MaterialPageRoute(builder: (_) {
      return Scaffold(
        appBar: AppBar(
          title: Text('Error'),
        ),
        body: Center(
          child: Text('ERROR'),
        ),
      );
    });
  }
}
