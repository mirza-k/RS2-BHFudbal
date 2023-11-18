// ignore_for_file: prefer_const_constructors, must_be_immutable, prefer_const_literals_to_create_immutables, curly_braces_in_flow_control_structures, prefer_final_fields
import 'dart:convert';
import 'dart:math';
import 'dart:typed_data';
import 'package:flutter_application_1/enums/dogadjaji_utakmice_enum.dart';
import 'package:flutter_application_1/enums/klub_enum.dart';
import 'package:flutter_application_1/models/detalji_utakmice.dart';
import 'package:flutter_application_1/models/postave.dart';
import 'package:flutter_application_1/models/response/match_details_response.dart';
import 'package:provider/provider.dart';
import '../components/liga_table_widget.dart';
import '../components/navigation_button.dart';
import 'package:flutter/material.dart';
import '../models/response/tabela_response.dart';
import '../models/search_results.dart';
import '../models/tabele.dart';
import '../providers/match_provider.dart';

class DetaljiUtakmice extends StatefulWidget {
  List<int> args = [];
  DetaljiUtakmice({super.key, required this.args});

  @override
  State<DetaljiUtakmice> createState() => _DetaljiUtakmiceState();
}

class _DetaljiUtakmiceState extends State<DetaljiUtakmice> {
  late List<DogadjajiUtakmiceVM> dogadjajiUtakmiceVMs = [];
  late var detalji = null;
  late List<StatefulWidget> _pages = [];
  int _selectedIndex = 0;
  MatchDetailsResponse? matchDetailsResponse;
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  StatistikaVM GenerisiStatistiku(DetaljiUtakmiceVM? detaljiUtakmiceVM) {
    Random random = Random();
    int domaciSutevi = random.nextInt(5) + 5;
    int gostiSutevi = random.nextInt(5) + 5;
    String sutevi = "$domaciSutevi - $gostiSutevi";

    List<String> posjed = ["50%-50%", "40%-60%", "60%-40%"];
    String stvarniPosjed = posjed[random.nextInt(posjed.length)];

    int domaciFaulovi = random.nextInt(8) + 5;
    int gostiFaulovi = random.nextInt(8) + 5;
    String faulovi = "$domaciFaulovi - $gostiFaulovi";

    int domaciOfsajdi = random.nextInt(1) + 5;
    int gostiOfsajdi = random.nextInt(1) + 5;
    String ofsajdi = "$domaciOfsajdi - $gostiOfsajdi";

    return StatistikaVM(stvarniPosjed, sutevi, faulovi, ofsajdi);
  }

  Future<void> _fetchDetails() async {
    var matchProvider = context.read<MatchProvider>();
    var response = await matchProvider.getDetails(widget.args[0]); //matchId
    var tabela = await matchProvider.getTabela(widget.args[1]); //ligaId
    var statistika = GenerisiStatistiku(detalji);
    setState(() {
      matchDetailsResponse = response;
      dogadjajiUtakmiceVMs = arrangeData();
      detalji = DetaljiUtakmiceVM(
        matchDetailsResponse!.gosti ?? "",
        matchDetailsResponse!.domaci ?? "",
        matchDetailsResponse!.rezultat,
        dogadjajiUtakmiceVMs,
        Uint8List.fromList(
            base64.decode(matchDetailsResponse!.domaciSlika ?? "")),
        Uint8List.fromList(
            base64.decode(matchDetailsResponse!.gostiSlika ?? "")),
      );
      var postave = Postave(
          matchDetailsResponse!.postaveDomaci ?? [],
          matchDetailsResponse!.postaveGosti ?? [],
          matchDetailsResponse!.domaci ?? "",
          matchDetailsResponse!.gosti ?? "");
      _pages = [
        DetaljiUtakmiceWidget(dogadjajiUtakmiceVM: dogadjajiUtakmiceVMs),
        PostaveWidget(postave: postave),
        StatistikaWidget(
          statistika: statistika,
        ),
        TabelaWidget(
          tabelaResponse: tabela,
        )
      ];
    });
  }

  @override
  void initState() {
    super.initState();
    _fetchDetails();
  }

  List<DogadjajiUtakmiceVM> arrangeData() {
    var data = matchDetailsResponse;
    List<DogadjajiUtakmiceVM> dogadjaji = [];
    var golDetails = data!.golDetails;
    if (golDetails != null) {
      for (int i = 0; i < golDetails.length; i++) {
        dogadjaji.add(DogadjajiUtakmiceVM(
            golDetails[i].imeFudbalera ?? "",
            golDetails[i].minutaGola.toString(),
            DogadjajiUtakmiceEnum.gol,
            golDetails[i].domacin != null && golDetails[i].domacin == true
                ? KlubEnum.domaci
                : KlubEnum.gost));
      }
    }

    var zutiKartonDetails = data.zutiKartonDetails;
    if (zutiKartonDetails != null) {
      for (int i = 0; i < zutiKartonDetails.length; i++) {
        dogadjaji.add(DogadjajiUtakmiceVM(
            zutiKartonDetails[i].imeFudbalera ?? "",
            zutiKartonDetails[i].minutaKartona.toString(),
            DogadjajiUtakmiceEnum.zutiKarton,
            zutiKartonDetails[i].domacin != null &&
                    zutiKartonDetails[i].domacin == true
                ? KlubEnum.domaci
                : KlubEnum.gost));
      }
    }

    var crveniKartonDetails = data.crveniKartonDetails;
    if (crveniKartonDetails != null) {
      for (int i = 0; i < crveniKartonDetails.length; i++) {
        dogadjaji.add(DogadjajiUtakmiceVM(
            crveniKartonDetails[i].imeFudbalera ?? "",
            crveniKartonDetails[i].minutaKartona.toString(),
            DogadjajiUtakmiceEnum.crveniKarton,
            crveniKartonDetails[i].domacin != null &&
                    crveniKartonDetails[i].domacin == true
                ? KlubEnum.domaci
                : KlubEnum.gost));
      }
    }

    int compareByMinuta(DogadjajiUtakmiceVM a, DogadjajiUtakmiceVM b) {
      final minutaA = int.tryParse(a.minuta) ?? 0;
      final minutaB = int.tryParse(b.minuta) ?? 0;
      return minutaA.compareTo(minutaB);
    }

    dogadjaji.sort(compareByMinuta);
    return dogadjaji;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Detalji utakmice"),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(top: 50),
          child: Column(
            children: [
              Row(children: [
                if (detalji != null)
                  Flexible(
                      flex: 3,
                      fit: FlexFit.tight,
                      child: Column(
                        children: [
                          if (detalji.domaciSlika != null)
                            Image.memory(
                              detalji.domaciSlika ??
                                  Uint8List.fromList([10, 20, 30]),
                              width: 150,
                              height: 150,
                            ),
                          Text(detalji.domaci ?? "",
                              style: TextStyle(fontSize: 20))
                        ],
                      )),
                if (detalji != null)
                  Flexible(
                      flex: 1,
                      fit: FlexFit.tight,
                      child: Column(
                        children: [
                          Text(
                            detalji.rezultat ?? "",
                            style: TextStyle(fontSize: 25),
                          ),
                        ],
                      )),
                if (detalji != null)
                  Flexible(
                    flex: 3,
                    fit: FlexFit.tight,
                    child: Column(
                      children: [
                        if (detalji.gostiSlika != null)
                          Image.memory(
                            detalji.gostiSlika ??
                                Uint8List.fromList([10, 20, 30]),
                            width: 150,
                            height: 150,
                          ),
                        Text(detalji.gosti ?? "", style: TextStyle(fontSize: 20))
                      ],
                    ),
                  ),
              ]),
              Padding(
                padding: const EdgeInsets.only(top: 50.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    NavigationButton(
                      title: 'Detalji',
                      isSelected: _selectedIndex == 0,
                      onTap: () => _onItemTapped(0),
                    ),
                    NavigationButton(
                      title: 'Postave',
                      isSelected: _selectedIndex == 1,
                      onTap: () => _onItemTapped(1),
                    ),
                    NavigationButton(
                      title: 'Statistika',
                      isSelected: _selectedIndex == 2,
                      onTap: () => _onItemTapped(2),
                    ),
                    NavigationButton(
                      title: 'Tabela',
                      isSelected: _selectedIndex == 3,
                      onTap: () => _onItemTapped(3),
                    )
                  ],
                ),
              ),
              if (_pages.isNotEmpty)
                Column(
                  children: [_pages[_selectedIndex]],
                )
            ],
          ),
        ),
      ),
    );
  }
}

class DetaljiUtakmiceWidget extends StatefulWidget {
  List<DogadjajiUtakmiceVM> dogadjajiUtakmiceVM;
  DetaljiUtakmiceWidget({super.key, required this.dogadjajiUtakmiceVM});

  @override
  State<DetaljiUtakmiceWidget> createState() => _DetaljiUtakmiceWidgetState();
}

class _DetaljiUtakmiceWidgetState extends State<DetaljiUtakmiceWidget> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ...widget.dogadjajiUtakmiceVM
            .map((e) => DogadjajUtakmiceWidget(dogadjajiUtakmiceVM: e))
      ],
    );
  }
}

class StatistikaWidget extends StatefulWidget {
  StatistikaVM? statistika;
  StatistikaWidget({super.key, required this.statistika});

  @override
  State<StatistikaWidget> createState() => _StatistikaWidgetState();
}

class _StatistikaWidgetState extends State<StatistikaWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
        child: Column(
      children: [
        Center(
            child: Text(
          "Posjed lopte",
          style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
        )),
        Padding(
          padding: const EdgeInsets.only(top: 5),
          child: Center(child: Text(widget.statistika!.posjed)),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 5),
          child: Center(
              child: Text(
            "Broj šuteva",
            style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
          )),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 5),
          child: Center(child: Text(widget.statistika!.sutevi)),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 5),
          child: Center(
              child: Text(
            "Broj faulova",
            style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
          )),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 5),
          child: Center(child: Text(widget.statistika!.faulovi)),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 5),
          child: Center(
              child: Text(
            "Broj ofsajda",
            style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
          )),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 6),
          child: Center(child: Text(widget.statistika!.ofsajdi)),
        )
      ],
    ));
  }
}

class PostaveWidget extends StatefulWidget {
  Postave postave;
  PostaveWidget({super.key, required this.postave});

  @override
  State<PostaveWidget> createState() => _PostaveWidgetState();
}

class _PostaveWidgetState extends State<PostaveWidget> {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(
              right: 16.0),
          child: Column(
            children: [
              Text(
                "${widget.postave.domaciIme}",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
              ),
              for (int x = 0; x < widget.postave.domaci.length; x++) ...[
                Padding(
                  padding: const EdgeInsets.only(top: 10),
                  child: Text("${widget.postave.domaci[x]}"),
                ),
              ],
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(
              left: 16.0),
          child: Column(
            children: [
              Text(
                "${widget.postave.gostiIme}",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
              ),
              for (int x = 0; x < widget.postave.gosti.length; x++) ...[
                Padding(
                  padding: const EdgeInsets.only(top: 10),
                  child: Text("${widget.postave.gosti[x]}"),
                ),
              ],
            ],
          ),
        ),
      ],
    );
  }
}

class TabelaWidget extends StatefulWidget {
  SearchResult<TabelaResponse> tabelaResponse;
  TabelaWidget({super.key, required this.tabelaResponse});

  @override
  State<TabelaWidget> createState() => _TabelaWidgetState();
}

class _TabelaWidgetState extends State<TabelaWidget> {
  @override
  List<LigaTabela> tabela = [];
  void initState() {
    super.initState();
    for (var i = 0; i < widget.tabelaResponse.result.length; i++) {
      tabela.add(LigaTabela(
        column1: '${i + 1}.',
        column2: widget.tabelaResponse.result[i].nazivKluba,
        column3: "5",
        column4: widget.tabelaResponse.result[i].brojBodova.toString(),
      ));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [LIgaTableWidget(data: tabela)],
      ),
    );
  }
}

class DogadjajUtakmiceWidget extends StatefulWidget {
  DogadjajiUtakmiceVM dogadjajiUtakmiceVM;
  DogadjajUtakmiceWidget({super.key, required this.dogadjajiUtakmiceVM});

  @override
  State<DogadjajUtakmiceWidget> createState() => _DogadjajUtakmiceWidgetState();
}

class _DogadjajUtakmiceWidgetState extends State<DogadjajUtakmiceWidget> {
  Icon getIcon() {
    if (widget.dogadjajiUtakmiceVM.dogadjajiUtakmiceEnum ==
        DogadjajiUtakmiceEnum.gol)
      return Icon(Icons.sports_soccer);
    else if (widget.dogadjajiUtakmiceVM.dogadjajiUtakmiceEnum ==
        DogadjajiUtakmiceEnum.zutiKarton)
      return Icon(Icons.square, color: Colors.yellow);
    return Icon(Icons.square, color: Colors.red);
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 15, right: 15),
      child: Padding(
        padding: const EdgeInsets.only(top: 10),
        child: Row(
          mainAxisAlignment:
              widget.dogadjajiUtakmiceVM.klubEnum == KlubEnum.domaci
                  ? MainAxisAlignment.start
                  : MainAxisAlignment.end,
          children: [
            Text(
                "${widget.dogadjajiUtakmiceVM.fudbaler} ${widget.dogadjajiUtakmiceVM.minuta}'  "),
            getIcon()
          ],
        ),
      ),
    );
  }
}
