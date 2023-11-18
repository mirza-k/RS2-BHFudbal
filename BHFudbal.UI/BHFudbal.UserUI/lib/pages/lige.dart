// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables
import 'package:flutter/material.dart';
import 'package:flutter_application_1/components/igrac_asistent_table.dart';
import 'package:flutter_application_1/models/response/match_forma_response.dart';
import 'package:flutter_application_1/models/response/match_strijelci_response.dart';
import 'package:provider/provider.dart';
import '../components/forma_table_widget.dart';
import '../components/navigation_button.dart';
import '../models/response/liga_response.dart';
import '../models/response/tabela_response.dart';
import '../models/tabele.dart';
import '../providers/liga_provider.dart';
import '../providers/match_provider.dart';

class Lige extends StatefulWidget {
  const Lige({super.key});

  @override
  State<Lige> createState() => _LigeState();
}

class _LigeState extends State<Lige> {
  int _selectedIndex = 0;
  late List<Widget> _pages = [];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  LigaResponse? ligaValue;
  List<LigaResponse> ligaResults = [];
  List<MatchStrijelciResponse> strijelciResult = [];
  List<MatchFormaResponse> formaResult = [];
  List<TabelaResponse>? tabelaResult;

  Future<void> _fetchLige() async {
    var _ligaProvider = context.read<LigaProvider>();
    var result = await _ligaProvider.get();
    setState(() {
      ligaResults = result.result;
    });
  }

  Future<void> _fetchTabelaData() async {
    var matchProvider = context.read<MatchProvider>();
    if (ligaValue != null) {
      var ligaId = ligaValue!.ligaId1;
      if (ligaId != null && ligaId != 0) {
        var resTabela = await matchProvider.getTabela(ligaId);
        var resStrijelci = await matchProvider.getStrijelci(ligaId);
        var resForma = await matchProvider.getForma(ligaId);
        setState(() {
          tabelaResult = resTabela.result;
          strijelciResult = resStrijelci.result;
          formaResult = resForma.result;
          _pages = [
            Tabela(
              tabela: tabelaResult ?? [],
            ),
            Strijelci(strijelciResult: strijelciResult),
            Forma(
              formaResult: formaResult ?? [],
            )
          ];
        });
      }
    }
  }

  @override
  void initState() {
    super.initState();
    _fetchLige();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 15.0),
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 50.0),
                  child: Column(
                    children: [
                      Text(
                        "Odaberi ligu",
                        style: TextStyle(
                            fontSize: 20.0, fontWeight: FontWeight.bold),
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
                            _fetchTabelaData();
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
                    ],
                  ),
                ),
                // Add your navigation items here
                Padding(
                  padding: const EdgeInsets.only(top: 50.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      NavigationButton(
                        title: 'Tabela',
                        isSelected: _selectedIndex == 0,
                        onTap: () => _onItemTapped(0),
                      ),
                      NavigationButton(
                        title: 'Strijelci',
                        isSelected: _selectedIndex == 1,
                        onTap: () => _onItemTapped(1),
                      ),
                      NavigationButton(
                        title: 'Forma',
                        isSelected: _selectedIndex == 2,
                        onTap: () => _onItemTapped(2),
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
          if (_pages.isNotEmpty)
            Column(children: [
              _pages[_selectedIndex],
            ]),
        ],
      ),
    );
  }
}

class Tabela extends StatefulWidget {
  @override
  int counter = 0;
  List<TabelaResponse> tabela;
  Tabela({required this.tabela});
  State<Tabela> createState() => _TabelaState();
}

class _TabelaState extends State<Tabela> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Table(
            border: TableBorder.all(),
            columnWidths: const {
              0: FlexColumnWidth(1),
              1: FlexColumnWidth(2),
              2: FlexColumnWidth(2),
              3: FlexColumnWidth(2),
            },
            children: [
              const TableRow(
                decoration: BoxDecoration(
                  color: Colors.grey,
                ),
                children: [
                  TableCell(
                    child: Center(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          '#',
                          style: TextStyle(
                              fontSize: 17, fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                  ),
                  TableCell(
                    child: Center(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          'Klub',
                          style: TextStyle(
                              fontSize: 17, fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                  ),
                  TableCell(
                    child: Center(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          'Br. utakmica',
                          style: TextStyle(
                              fontSize: 17, fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                  ),
                  TableCell(
                    child: Center(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          'Bodovi',
                          style: TextStyle(
                              fontSize: 17, fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              ...widget.tabela.map((item) {
                return TableRow(
                  children: [
                    TableCell(
                      child: Center(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text((++widget.counter).toString()),
                        ),
                      ),
                    ),
                    TableCell(
                      child: Center(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(item.nazivKluba),
                        ),
                      ),
                    ),
                    TableCell(
                      child: Center(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(item.brojOdigranihUtakmica.toString()),
                        ),
                      ),
                    ),
                    TableCell(
                      child: Center(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(item.brojBodova.toString()),
                        ),
                      ),
                    ),
                  ],
                );
              }).toList(),
            ],
          )),
    );
  }
}

class Strijelci extends StatefulWidget {
  @override
  List<MatchStrijelciResponse>? strijelciResult;
  Strijelci({required this.strijelciResult});
  State<Strijelci> createState() => _StrijelciState();
}

class _StrijelciState extends State<Strijelci> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: IgracAsistentWidget(
          data: widget.strijelciResult,
          firstLabel: "Igrac",
          secondLabel: "Br. golova"),
    );
  }
}

class Forma extends StatefulWidget {
  @override
  List<MatchFormaResponse> formaResult = [];
  Forma({required this.formaResult});
  State<Forma> createState() => _FormaState();
}

class _FormaState extends State<Forma> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: FormaTabelaWidget(data: widget.formaResult),
    );
  }
}
