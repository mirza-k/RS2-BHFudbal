// ignore_for_file: prefer_const_constructors
import 'package:bhfudbal_admin/pages/izvjestaji.dart';
import 'package:bhfudbal_admin/pages/prikaz_fudbalera.dart';
import 'package:bhfudbal_admin/pages/prikaz_klubova.dart';
import 'package:bhfudbal_admin/pages/prikaz_korisnika.dart';
import 'package:bhfudbal_admin/pages/prikaz_transfera.dart';
import 'package:bhfudbal_admin/pages/prikaz_utakmica.dart';
import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List pages = [
    PrikazKlubovaWidget(),
    PrikazFudbaleraWidget(),
    PrikazUtakmicaWidget(),
    PrikazTransferaWidget(),
    PrikazKorisnikaWidget(),
    IzvjestajWidget()
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
      body: pages[currentIndex],
      bottomNavigationBar: BottomNavigationBar(
          onTap: onTap,
          currentIndex: currentIndex,
          selectedItemColor: Colors.black54,
          unselectedItemColor: Colors.grey.withOpacity(0.5),
          elevation: 0,
          items: const [
            BottomNavigationBarItem(
                icon: Icon(
                  Icons.sports_soccer_rounded,
                  size: 30,
                ),
                label: "Klubovi"),
            BottomNavigationBarItem(
                icon: Icon(
                  Icons.badge_rounded,
                  size: 30,
                ),
                label: "Fudbaleri"),
            BottomNavigationBarItem(
                icon: Icon(
                  Icons.gamepad,
                  size: 30,
                ),
                label: "Utakmice"),
            BottomNavigationBarItem(
                icon: Icon(
                  Icons.repeat,
                  size: 30,
                ),
                label: "Transferi"),
            BottomNavigationBarItem(
                icon: Icon(
                  Icons.person,
                  size: 30,
                ),
                label: "Korisnici"),
            BottomNavigationBarItem(
                icon: Icon(
                  Icons.print_sharp,
                  size: 30,
                ),
                label: "Izvjestaji"),
          ]),
    );
  }
}
