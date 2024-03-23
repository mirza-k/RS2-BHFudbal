// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, must_be_immutable, use_build_context_synchronously
import 'package:flutter/material.dart';
import 'package:flutter_application_1/models/request/omiljeni_fudbaler_insert_request.dart';
import 'package:flutter_application_1/models/response/fudbaler_detail_response.dart';
import 'package:flutter_application_1/models/response/fudbaler_response.dart';
import 'package:flutter_application_1/providers/fudbaler_provider.dart';
import 'package:provider/provider.dart';
import '../models/response/fudbaler_history_transfer_response.dart';
import '../models/response/klub_response.dart';
import '../providers/klub_provider.dart';
import '../utils/auth_utils.dart';

class HistorijaFudbalera extends StatefulWidget {
  int fudbalerId;
  bool fetchHappened = false;
  HistorijaFudbalera({super.key, required this.fudbalerId});

  @override
  State<HistorijaFudbalera> createState() => _HistorijaFudbaleraState();
}

class _HistorijaFudbaleraState extends State<HistorijaFudbalera> {
  List<FudbalerHistoryTransferResponse> transferHistoryResult = [];
  Future<void> _fetchHistorijaTransfera() async {
    if (widget.fudbalerId != 0) {
      var fudbalerProvider = context.read<FudbalerProvider>();
      var response =
          await fudbalerProvider.getFudbalerHistoryTransfer(widget.fudbalerId);
      widget.fetchHappened = true;
      setState(() {
        transferHistoryResult = response.result;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    _fetchHistorijaTransfera();
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Historija fudbalera"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          children: [
            if (transferHistoryResult.isEmpty && widget.fetchHappened == true)
              Text(
                "Fudbaler nema nijedan izvrsen transfer tako da je historija prazna!",
                style: TextStyle(
                    fontSize: 15,
                    color: Colors.red,
                    fontWeight: FontWeight.bold),
              ),
            Table(
              border: TableBorder.all(),
              columnWidths: const {
                0: FlexColumnWidth(1),
                1: FlexColumnWidth(1),
                2: FlexColumnWidth(1),
                3: FlexColumnWidth(1),
                4: FlexColumnWidth(1)
              },
              children: [
                TableRow(
                  decoration: BoxDecoration(
                    color: Colors.grey,
                  ),
                  children: [
                    TableCell(
                      child: Center(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            'Fudbaler',
                            style: TextStyle(
                                fontSize: 13, fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                    ),
                    TableCell(
                      child: Center(
                        child: Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Text(
                            "Stari klub",
                            style: TextStyle(
                                fontSize: 13, fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                    ),
                    TableCell(
                      child: Center(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            "Novi klub",
                            style: TextStyle(
                                fontSize: 13, fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                    ),
                    TableCell(
                      child: Center(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            "Cijena",
                            style: TextStyle(
                                fontSize: 13, fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                    ),
                    TableCell(
                      child: Center(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            "Ugovor",
                            style: TextStyle(
                                fontSize: 13, fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                ...transferHistoryResult.map((item) {
                  return TableRow(children: [
                    TableCell(
                      child: Center(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(item.imeFudbalera),
                        ),
                      ),
                    ),
                    TableCell(
                      child: Center(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(item.stariKlub),
                        ),
                      ),
                    ),
                    TableCell(
                      child: Center(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(item.noviKlub),
                        ),
                      ),
                    ),
                    TableCell(
                      child: Center(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(item.cijena),
                        ),
                      ),
                    ),
                    TableCell(
                      child: Center(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text('${item.ugovor} godina/e'),
                        ),
                      ),
                    ),
                  ]);
                }).toList(),
              ],
            )
          ],
        ),
      ),
    );
  }
}

class Igraci extends StatefulWidget {
  const Igraci({super.key});

  @override
  State<Igraci> createState() => _IgraciState();
}

class _IgraciState extends State<Igraci> {
  KlubResponse? klubValue;
  List<KlubResponse> klubResults = [];
  FudbalerResponse? fudbalerValue;
  List<FudbalerResponse> fudbalerResult = [];
  List<FudbalerResponse> slicniFudbaleri = [];
  FudbalerDetailResponse? fudbalerDetailResult;
  Future<void> _fetchKlubovi() async {
    var klubProvider = context.read<KlubProvider>();
    var result = await klubProvider.getAll();
    setState(() {
      klubResults = result.result;
    });
  }

  Future<void> _fetchFudbaleri() async {
    fudbalerValue = null;
    fudbalerDetailResult = null;
    fudbalerResult = [];
    if (klubValue != null) {
      var klubId = klubValue!.klubId;
      if (klubId != null && klubId != 0) {
        var fudbalerProvider = context.read<FudbalerProvider>();
        var response = await fudbalerProvider.get(klubId);
        setState(() {
          fudbalerResult = response.result;
        });
      }
    }
  }

  Future<void> _fetchFudbalerUtakmiceDetails() async {
    if (fudbalerValue != null) {
      var fudbalerId = fudbalerValue!.fudbalerId;
      if (fudbalerId != null && fudbalerId != 0) {
        var fudbalerProvider = context.read<FudbalerProvider>();
        var response = await fudbalerProvider.getDetails(fudbalerId);
        setState(() {
          fudbalerDetailResult = response;
        });
      }
    }
  }

  Future<void> _fetchSlicneFudbalere(int fudbalerId) async {
    var fudbalerProvider = context.read<FudbalerProvider>();
    var response = await fudbalerProvider.getSlicneFudbalere(fudbalerId);
    setState(() {
      slicniFudbaleri = response.result;
    });
  }

  void _sendRating() async {
    if (currentPlayerRating != 0) {
      showDialog(
          context: context,
          builder: (BuildContext context) => AlertDialog(
                content: Text("Igrac vec jednom ocijenjen!"),
                actions: [
                  TextButton(
                      onPressed: () => Navigator.pop(context),
                      child: Text("OK"))
                ],
              ));
    } else {
      var fudbalerProvider = context.read<FudbalerProvider>();
      var ratingRequest = OmiljeniFudbalerInsertRequest(
          korisnikId: Authorization.id ?? 0,
          fudbalerId: izabraniFudbaler,
          rating: selectedNumber);
      var request = OmiljeniFudbalerInsertRequest().toJson(ratingRequest);
      await fudbalerProvider.ocijeniFudbalera(request);
      showDialog(
          context: context,
          builder: (BuildContext context) => AlertDialog(
                content: Text("Uspjesno ste ocijenili fudbalera!"),
                actions: [
                  TextButton(
                      onPressed: () => Navigator.pop(context),
                      child: Text("OK"))
                ],
              ));
      setState(() {
        currentPlayerRating = selectedNumber;
      });
    }
  }

  Future<void> _fetchRating() async {
    var fudbalerProvider = context.read<FudbalerProvider>();
    var response =
        await fudbalerProvider.getRating(izabraniFudbaler, Authorization.id);
    setState(() {
      selectedNumber = response != 0 ? response : 1;
      currentPlayerRating = response;
    });
  }

  @override
  void initState() {
    super.initState();
    _fetchKlubovi();
  }

  int currentPlayerRating = 0;
  int selectedNumber = 1; // Default selected number
  int izabraniFudbaler = 0;

  Widget build(BuildContext context) {
    return Scaffold(
        body: SingleChildScrollView(
      child: Column(children: [
        Column(
          children: [
            Center(
              child: Padding(
                padding: const EdgeInsets.only(top: 30.0),
                child: Column(
                  children: [
                    Text(
                      "Odaberi klub",
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
                      child: DropdownButton<KlubResponse>(
                        isExpanded: true,
                        value: klubValue,
                        onChanged: (val) {
                          setState(() => klubValue = val!);
                          _fetchFudbaleri();
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
                    Padding(padding: EdgeInsets.only(top: 20)),
                    Text(
                      "Odaberi fudbalera",
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
                      child: DropdownButton<FudbalerResponse>(
                        isExpanded: true,
                        value: fudbalerValue,
                        onChanged: (val) {
                          setState(() => fudbalerValue = val!);
                          izabraniFudbaler = val!.fudbalerId ?? 0;
                          _fetchSlicneFudbalere(val.fudbalerId ?? 0);
                          _fetchRating();
                          _fetchFudbalerUtakmiceDetails();
                        },
                        items: fudbalerResult
                            .map((val) => DropdownMenuItem(
                                value: val,
                                child: Text('${val.ime} ${val.prezime}')))
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
            ),
          ],
        ),
        Padding(
          padding: const EdgeInsets.only(top: 30),
          child: Align(
            alignment: Alignment.centerLeft,
            child: Row(
              children: [
                if (fudbalerValue != null)
                  Flexible(
                    flex: 3,
                    fit: FlexFit.tight,
                    child: Padding(
                      padding: const EdgeInsets.only(left: 40),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                              'Ime prezime: ${fudbalerValue!.ime} ${fudbalerValue!.prezime}'),
                          Text('Godine: ${fudbalerValue!.brojGodina}'),
                          Text('Visina ${fudbalerValue!.visina}'),
                          Text('Tezina ${fudbalerValue!.tezina}'),
                          Text('Jaca noga: ${fudbalerValue!.jacaNoga}'),
                          InkWell(
                            onTap: () {
                              if (fudbalerValue != null) {
                                Navigator.of(context).pushNamed(
                                    '/historija-fudbalera',
                                    arguments: fudbalerValue!.fudbalerId ?? 0);
                              }
                            },
                            child: Text(
                              "Historija fudbalera",
                              style: TextStyle(
                                color: Colors.blue,
                              ),
                            ),
                          ),
                          InkWell(
                            onTap: () {
                              if (fudbalerValue != null) {
                                Navigator.of(context).pushNamed(
                                    '/najslicniji-fudbaleri',
                                    arguments: fudbalerValue!.fudbalerId ?? 0);
                              }
                            },
                            child: Text(
                              "Najslicniji fudbaleri",
                              style: TextStyle(
                                color: Colors.blue,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                Flexible(
                  flex: 3,
                  fit: FlexFit.tight,
                  child: Column(
                    children: [
                      Padding(padding: EdgeInsets.only(top: 15)),
                      if (fudbalerValue != null)
                        Text(
                          "Ocijeni fudbalera",
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                      if (fudbalerValue != null)
                        DropdownButton<int>(
                          value: selectedNumber,
                          onChanged: (int? newValue) {
                            setState(() {
                              selectedNumber = newValue!;
                            });
                          },
                          items: List.generate(5, (index) {
                            return DropdownMenuItem<int>(
                              value: index + 1,
                              child: Text('${index + 1}'),
                            );
                          }),
                        ),
                      SizedBox(height: 20),
                      if (fudbalerValue != null)
                        ElevatedButton(
                          onPressed: () {
                            currentPlayerRating != 0 ? null : _sendRating();
                          },
                          style: ElevatedButton.styleFrom(
                              backgroundColor: currentPlayerRating != 0
                                  ? Colors.grey
                                  : Colors.blue),
                          child: Text(
                            currentPlayerRating != 0
                                ? "Ovog fudbalera ste vec ocijenili"
                                : 'Ocijeni',
                            style: TextStyle(fontSize: 13),
                          ),
                        ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
        Padding(padding: const EdgeInsets.only(top: 20)),
        if (fudbalerDetailResult != null)
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Table(
              border: TableBorder.all(),
              columnWidths: const {
                0: FlexColumnWidth(4),
                1: FlexColumnWidth(1),
                2: FlexColumnWidth(1),
                3: FlexColumnWidth(1),
                4: FlexColumnWidth(1)
              },
              children: [
                TableRow(
                  decoration: BoxDecoration(
                    color: Colors.grey,
                  ),
                  children: [
                    TableCell(
                      child: Center(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            'Utakmica',
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
                            'G',
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
                            'A',
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
                            child: Container(
                              width: 13,
                              height: 20,
                              decoration: BoxDecoration(
                                color: Colors.red,
                                borderRadius: BorderRadius.circular(5),
                              ),
                            )),
                      ),
                    ),
                    TableCell(
                      child: Center(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Container(
                            width: 13,
                            height: 20,
                            decoration: BoxDecoration(
                              color: Colors.yellow,
                              borderRadius: BorderRadius.circular(5),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                ...fudbalerDetailResult!.utakmice.map((item) {
                  return TableRow(
                    children: [
                      TableCell(
                        child: Center(
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(item.rezultat),
                          ),
                        ),
                      ),
                      TableCell(
                        child: Center(
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(item.golovi.toString()),
                          ),
                        ),
                      ),
                      TableCell(
                        child: Center(
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(0.toString()),
                          ),
                        ),
                      ),
                      TableCell(
                        child: Center(
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(item.crveniKartoni.toString()),
                          ),
                        ),
                      ),
                      TableCell(
                        child: Center(
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(item.zutiKartoni.toString()),
                          ),
                        ),
                      ),
                    ],
                  );
                }).toList(),
              ],
            ),
          )
      ]),
    ));
  }
}
