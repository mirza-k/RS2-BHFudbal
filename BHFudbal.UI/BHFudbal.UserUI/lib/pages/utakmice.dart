import 'package:flutter/material.dart';
import 'package:flutter_application_1/models/response/utakmica_response.dart';
import 'package:flutter_application_1/providers/match_provider.dart';
import 'package:provider/provider.dart';
import '../models/response/liga_response.dart';
import '../providers/liga_provider.dart';

class Utakmice extends StatefulWidget {
  const Utakmice({super.key});

  @override
  State<Utakmice> createState() => _UtakmiceState();
}

class _UtakmiceState extends State<Utakmice> {
  int? koloValue;
  LigaResponse? ligaValue;
  List<int> koloResults = [];
  List<LigaResponse> ligaResults = [];
  List<UtakmiceResponse> utakmice = [];

  Future<void> _fetchLige() async {
    var _ligaProvider = context.read<LigaProvider>();
    var result = await _ligaProvider.get();
    setState(() {
      ligaResults = result.result;
    });
  }

  Future<void> _fetchBrojKola() async {
    koloValue = null;
    var matchProvider = context.read<MatchProvider>();
    if (ligaValue != null) {
      var ligaId = ligaValue!.ligaId1;
      var maxBrojKola = await matchProvider.GetMaxBrojKola(ligaId ?? 0);
      List<int> kola = [];
      for (int i = 1; i <= maxBrojKola; i++) {
        kola.add(i);
      }
      setState(() {
        koloResults = kola;
      });
    }
  }

  Future<void> _fetchMatchevi() async {
    var matchProvider = context.read<MatchProvider>();
    var response = await matchProvider.get(ligaValue!.ligaId1, koloValue);
    setState(() {
      utakmice = response.result;
    });
  }

  @override
  void initState() {
    super.initState();
    _fetchLige();
    _fetchBrojKola();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
      child: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 15.0),
              child: Padding(
                padding: const EdgeInsets.only(top: 50.0),
                child: Column(
                  children: [
                    Text(
                      "Odaberi ligu",
                      style:
                          TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
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
                      child: DropdownButton<LigaResponse>(
                        isExpanded: true,
                        value: ligaValue,
                        onChanged: (val) {
                          setState(() => ligaValue = val!);
                          _fetchBrojKola();
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
                    Padding(padding: EdgeInsets.only(top: 15.0)),
                    Text(
                      "Odaberi kolo",
                      style:
                          TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
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
                      child: DropdownButton<int>(
                        isExpanded: true,
                        value: koloValue,
                        onChanged: (val) async {
                          setState(() => koloValue = val!);
                          _fetchMatchevi();
                        },
                        items: koloResults
                            .map((val) => DropdownMenuItem(
                                value: val, child: Text(val.toString())))
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
                    Column(
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(top: 50.0),
                          child: Container(
                            width: double.infinity,
                            color: Colors.blue,
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Center(
                                child: Text(
                                  "Premier Liga",
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 20),
                                ),
                              ),
                            ),
                          ),
                        ),
                        PreviewUtakmice(
                          utakmice: utakmice,
                          ligaId: ligaValue != null ? ligaValue!.ligaId1 ?? 0 : 0,
                        )
                      ],
                    )
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    ));
  }
}

class PreviewUtakmice extends StatelessWidget {
  List<UtakmiceResponse> utakmice;
  int ligaId;
  PreviewUtakmice({super.key, required this.utakmice, required this.ligaId});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(children: [
        ...utakmice.map((item) {
          return Center(
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 10.0),
                  child: Center(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Row(
                          children: [
                            Text(
                              item.prikaz.toString(),
                              style: TextStyle(fontSize: 18),
                            ),
                            InkWell(
                              onTap: () {
                                var matchId = item.matchId as int;
                                Navigator.of(context).pushNamed(
                                    '/detalji-utakmice',
                                    arguments: [matchId, ligaId]);
                              },
                              child: Padding(
                                  padding: const EdgeInsets.only(left: 10),
                                  child: Text(
                                    "detalji",
                                    style: TextStyle(
                                      color: Colors.blue,
                                    ),
                                  )),
                            )
                          ],
                        )
                      ],
                    ),
                  ),
                )
              ],
            ),
          );
        })
      ]),
    );
  }
}
