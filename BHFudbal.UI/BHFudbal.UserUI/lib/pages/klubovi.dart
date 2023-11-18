// ignore_for_file: prefer_const_constructors, unnecessary_new, prefer_const_literals_to_create_immutables
import 'package:flutter/material.dart';
import 'package:flutter_application_1/models/response/matches_by_klub_response.dart';
import 'package:flutter_application_1/models/response/sezona_response.dart';
import 'package:flutter_application_1/providers/match_provider.dart';
import 'package:flutter_application_1/providers/sezona_provider.dart';
import 'package:provider/provider.dart';
import '../components/navigation_button.dart';
import '../models/response/klub_response.dart';
import '../providers/klub_provider.dart';

class Klubovi extends StatefulWidget {
  const Klubovi({super.key});
  @override
  State<Klubovi> createState() => _KluboviState();
}

class _KluboviState extends State<Klubovi> {
  KlubResponse? klubValue;
  List<KlubResponse> klubResults = [];
  int _selectedIndex = 0;
  TextEditingController pretragaController = TextEditingController();
  List<Widget> _pages = [];
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  Future<void> _fetchKlubovi() async {
    klubValue = null;
    var _klubProvider = context.read<KlubProvider>();
    var result = await _klubProvider.getByNaziv(pretragaController.text);
    setState(() {
      klubResults = result.result;
    });
  }

  @override
  void initState() {
    super.initState();
    _fetchKlubovi();
    _pages = [
      TrenutnaSezona(
        klubId: klubValue != null ? klubValue!.klubId ?? 0 : 0,
      ),
      HistorijaSezona(klubId: klubValue != null ? klubValue!.klubId ?? 0 : 0)
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SingleChildScrollView(
      child: Column(children: [
        TextFormField(
          onChanged: (value) {
            _fetchKlubovi();
          },
          controller: pretragaController,
          decoration: const InputDecoration(
              labelText: "Pretraga",
              border: OutlineInputBorder(),
              prefixIcon: Icon(Icons.search)),
        ),
        Center(
          child: Padding(
            padding: const EdgeInsets.only(top: 30.0),
            child: Column(
              children: [
                Text(
                  "Odaberi klub",
                  style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
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
                  child: DropdownButton<KlubResponse>(
                    isExpanded: true,
                    value: klubValue,
                    onChanged: (val) {
                      setState(() => klubValue = val!);
                      _pages[0] = TrenutnaSezona(
                        klubId: klubValue != null ? klubValue!.klubId ?? 0 : 0,
                      );
                      _pages[1] = HistorijaSezona(
                          klubId:
                              klubValue != null ? klubValue!.klubId ?? 0 : 0);
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
                Padding(
                  padding: const EdgeInsets.only(top: 50.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      NavigationButton(
                        title: 'Trenutna sezona',
                        isSelected: _selectedIndex == 0,
                        onTap: () => _onItemTapped(0),
                      ),
                      NavigationButton(
                        title: 'Historija',
                        isSelected: _selectedIndex == 1,
                        onTap: () => _onItemTapped(1),
                      ),
                    ],
                  ),
                ),
                Column(children: [
                  _pages[_selectedIndex],
                ]),
              ],
            ),
          ),
        )
      ]),
    ));
  }
}

class TrenutnaSezona extends StatefulWidget {
  int klubId;
  TrenutnaSezona({super.key, required this.klubId});

  @override
  State<TrenutnaSezona> createState() => _TrenutnaSezonaState();
}

class _TrenutnaSezonaState extends State<TrenutnaSezona> {
  MatchesByKlubResponse? result;

  _fetchMatches() async {
    var _matchProvider = context.read<MatchProvider>();
    if (widget.klubId > 0) {
      var response = await _matchProvider.getAllMatchesByKlubId(widget.klubId);
      setState(() {
        result = response;
      });
    }
  }

  @override
  void didUpdateWidget(TrenutnaSezona oldWidget) {
    if (widget.klubId != oldWidget.klubId) {
      // The klubId has changed, perform your action here
      _fetchMatches();
    }
    super.didUpdateWidget(oldWidget);
  }

  @override
  void initState() {
    super.initState();
    _fetchMatches();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 20),
      child: Container(
        child: Column(children: [
          if (result?.rezultati != null && widget.klubId != 0)
            Text(
              'Broj datih golova: ${result != null ? result!.brojDatihGolova ?? 0 : 0}',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          if (result?.rezultati != null)
            Text(
              'Broj primljenih golova: ${result != null ? result!.brojPrimljenihGolova ?? 0 : 0}',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          Padding(
            padding: const EdgeInsets.only(top: 10),
            child: Column(
              children: [
                if (result?.rezultati != null)
                  ...result!.rezultati.map((item) {
                    return Padding(
                      padding: const EdgeInsets.only(left: 15.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text(
                            "${item}",
                            style: TextStyle(fontSize: 18),
                          ),
                        ],
                      ),
                    );
                  })
              ],
            ),
          )
        ]),
      ),
    );
  }
}

class HistorijaSezona extends StatefulWidget {
  int klubId;
  HistorijaSezona({super.key, required this.klubId});

  @override
  State<HistorijaSezona> createState() => _HistorijaSezonaState();
}

class _HistorijaSezonaState extends State<HistorijaSezona> {
  @override
  SezonaResponse? sezonaValue;
  List<SezonaResponse> sezonaResult = [];
  MatchesByKlubResponse? result;

  _fetchMatches() async {
    var _matchProvider = context.read<MatchProvider>();
    if (widget.klubId > 0 && sezonaValue != null) {
      var sezonaId = sezonaValue!.sezonaId;
      if (sezonaId != null && sezonaId != 0) {
        var response =
            await _matchProvider.getByKlubAndSezona(widget.klubId, sezonaId);
        setState(() {
          result = response;
        });
      }
    }
  }

  @override
  void didUpdateWidget(HistorijaSezona oldWidget) {
    if (widget.klubId != oldWidget.klubId) {
      _fetchMatches();
    }
    super.didUpdateWidget(oldWidget);
  }

  _fetchSezona() async {
    var _sezonaProvider = context.read<SezonaProvider>();
    var response = await _sezonaProvider.get();
    setState(() {
      sezonaResult = response.result;
    });
  }

  @override
  void initState() {
    super.initState();
    _fetchSezona();
    _fetchMatches();
  }

  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(children: [
        Text(
          "Izaberite sezonu",
          style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
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
          child: DropdownButton<SezonaResponse>(
            isExpanded: true,
            value: sezonaValue,
            onChanged: (val) {
              setState(() => sezonaValue = val!);
              _fetchMatches();
            },
            items: sezonaResult
                .map((val) =>
                    DropdownMenuItem(value: val, child: Text(val.naziv ?? "")))
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
          padding: const EdgeInsets.only(top: 10),
          child: Column(children: [
            if (result?.rezultati != null)
              Text(
                'Broj datih golova: ${result != null ? result!.brojDatihGolova ?? 0 : 0}',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            if (result?.rezultati != null)
              Text(
                'Broj primljenih golova: ${result != null ? result!.brojPrimljenihGolova ?? 0 : 0}',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            Padding(
              padding: const EdgeInsets.only(top: 10),
              child: Column(
                children: [
                  if (result?.rezultati != null)
                    ...result!.rezultati.map((item) {
                      return Center(
                        child: Padding(
                          padding: const EdgeInsets.only(left: 15),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Text(
                                "${item}",
                                style: TextStyle(fontSize: 18),
                              ),
                            ],
                          ),
                        ),
                      );
                    })
                ],
              ),
            )
          ]),
        ),
      ]),
    );
  }
}
