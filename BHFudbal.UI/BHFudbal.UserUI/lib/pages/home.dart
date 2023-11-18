// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_application_1/pages/Utakmice.dart';
import 'package:flutter_application_1/pages/igraci.dart';
import 'package:flutter_application_1/pages/klubovi.dart';
import 'package:flutter_application_1/pages/lige.dart';
import 'package:flutter_application_1/pages/payment.dart';
import 'package:flutter_application_1/pages/uredi_profil.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List pages = [
    Utakmice(),
    Klubovi(),
    Igraci(),
    Lige(),
    UrediProfil(),
    Payment()
  ];

  int currentIndex = 0;
  void onTap(int index) {
    setState(() {
      currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("BH Fudbal"),
        automaticallyImplyLeading: false,
      ),
      body: pages[currentIndex],
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.only(bottom: 15.0),
        child: BottomNavigationBar(
            onTap: onTap,
            currentIndex: currentIndex,
            selectedItemColor: Colors.black54,
            unselectedItemColor: Colors.grey.withOpacity(0.5),
            elevation: 0,
            items: const [
              BottomNavigationBarItem(
                  icon: Icon(Icons.sports), label: "Utakmice"),
              BottomNavigationBarItem(
                  icon: Icon(Icons.sports_soccer), label: "Klubovi"),
              BottomNavigationBarItem(icon: Icon(Icons.man), label: "Igrači"),
              BottomNavigationBarItem(
                  icon: Icon(Icons.table_chart_outlined), label: "Lige"),
              BottomNavigationBarItem(
                  icon: Icon(Icons.person), label: "Profil"),
              BottomNavigationBarItem(
                  icon: Icon(Icons.report), label: "Report"),
            ]),
      ),
    );
  }
}
