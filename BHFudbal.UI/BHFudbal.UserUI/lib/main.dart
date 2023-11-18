import 'package:flutter/material.dart';
import 'package:flutter_application_1/providers/auth_provider.dart';
import 'package:flutter_application_1/providers/fudbaler_provider.dart';
import 'package:flutter_application_1/providers/klub_provider.dart';
import 'package:flutter_application_1/providers/korisnik_provider.dart';
import 'package:flutter_application_1/providers/liga_provider.dart';
import 'package:flutter_application_1/providers/match_provider.dart';
import 'package:flutter_application_1/providers/sezona_provider.dart';
import 'package:flutter_application_1/route_generator.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:provider/provider.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  Stripe.publishableKey =
      "pk_test_51O0THdG4y19tAglhiVRezsCQlaQg3kdfAWWopu8Jy65RMdQTMwXuHcEMABcLbpSSnwNCp7nBq3ZkHX3IaAQsKnux00yTjNEah4";
  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(create: (_) => AuthProvider()),
      ChangeNotifierProvider(create: (_) => LigaProvider()),
      ChangeNotifierProvider(create: (_) => MatchProvider()),
      ChangeNotifierProvider(create: (_) => KlubProvider()),
      ChangeNotifierProvider(create: (_) => SezonaProvider()),
      ChangeNotifierProvider(create: (_) => FudbalerProvider()),
      ChangeNotifierProvider(create: (_) => KorisnikProvider()),
    ],
    child: MyApp(),
  ));
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      initialRoute: '/login',
      debugShowCheckedModeBanner: false,
      onGenerateRoute: RouteGenerator.generateRoute,
    );
  }
}
