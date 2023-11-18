// ignore_for_file: prefer_const_constructors, avoid_print, prefer_const_literals_to_create_immutables
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/models/update_to_premium_korisnik.dart';
import 'package:flutter_application_1/utils/auth_utils.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import '../models/response/premium_report_response.dart';
import '../models/response/sezona_response.dart';
import '../providers/korisnik_provider.dart';
import '../providers/sezona_provider.dart';

class Payment extends StatefulWidget {
  const Payment({super.key});

  @override
  State<Payment> createState() => _PaymentState();
}

class _PaymentState extends State<Payment> {
  late Map<String, dynamic> paymentIntent;
  late bool isPremiumUser = false;
  PremiumReport? _premiumReport = null;
  Future<void> isUserPremium() async {
    var korisnikProvider = context.read<KorisnikProvider>();
    var request = UpdateToPremiumKorisnik(
        username: Authorization.username, password: Authorization.password);
    var req = UpdateToPremiumKorisnik().toJson(request);
    var response = await korisnikProvider.isKorisnikPremium(req);
    setState(() {
      isPremiumUser = response == 1 ? true : false;
    });
  }

  @override
  void initState() {
    super.initState();
    isUserPremium();
    _fetchSezona();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          if (isPremiumUser == false)
            TextButton(
              child: Text("Klikni da postaneš premium član i generišeš report"),
              onPressed: () async {
                await makePayment();
              },
            ),
          if (isPremiumUser == true)
            Text(
              "Izaberite sezonu",
              style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
            ),
          if (isPremiumUser == true)
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
                },
                items: sezonaResult
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
          if (isPremiumUser == true)
            TextButton(
              onPressed: () async {
                await generisiReport();
              },
              child: Text("Generiši report"),
            ),
          if (_premiumReport != null)
            Expanded(child: PremiumReportWidget(premiumReport: _premiumReport))
        ],
      )),
    );
  }

  SezonaResponse? sezonaValue;
  Future<void> generisiReport() async {
    if (sezonaValue != null) {
      var korisnikProvider = context.read<KorisnikProvider>();
      var result =
          await korisnikProvider.getPremiumReport(sezonaValue!.sezonaId ?? 0);
      setState(() {
        _premiumReport = result;
      });
    }
  }

  Future<void> makePayment() async {
    paymentIntent = await createPaymentIntent('1000', 'BAM');
    await Stripe.instance
        .initPaymentSheet(
            paymentSheetParameters: SetupPaymentSheetParameters(
                paymentIntentClientSecret: paymentIntent['client_secret'],
                style: ThemeMode.dark,
                merchantDisplayName: 'Mirza'))
        .then((value) {});

    displayPaymentSheet();
  }

  createPaymentIntent(String amount, String currency) async {
    try {
      Map<String, dynamic> body = {
        'amount': amount,
        'currency': currency,
        'payment_method_types[]': 'card',
      };
      var secretKey =
          'sk_test_51O0THdG4y19tAglhbUozI8A2XtkjuppvCEaU9Uneu6BWkyq72zAprtbhTcb18jhbDsXy7Comw42iJ4MvrBnCFh8W00XfO4s7X3';
      final headers = {
        'Authorization': 'Bearer $secretKey',
        'Content-Type': 'application/x-www-form-urlencoded',
      };
      var response = await http.post(
        Uri.parse('https://api.stripe.com/v1/payment_intents'),
        headers: headers,
        body: body,
      );

      print('Payment intent body -> ${response.body.toString()}');
      return jsonDecode(response.body);
    } catch (e) {
      print('desio se error ${e.toString()}');
    }
  }

  List<SezonaResponse> sezonaResult = [];
  _fetchSezona() async {
    var _sezonaProvider = context.read<SezonaProvider>();
    var response = await _sezonaProvider.get();
    setState(() {
      sezonaResult = response.result;
    });
  }

  displayPaymentSheet() async {
    await Stripe.instance.presentPaymentSheet().then((value) {
      showDialog(
          context: context,
          builder: (_) => AlertDialog(
                content: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Row(
                      children: [
                        Icon(
                          Icons.check_circle,
                          color: Colors.green,
                        ),
                        Text('Plaćanje uspjesno')
                      ],
                    )
                  ],
                ),
              ));
    });
    var korisnikProvider = context.read<KorisnikProvider>();
    var request = UpdateToPremiumKorisnik(
        username: Authorization.username, password: Authorization.password);
    var req = UpdateToPremiumKorisnik().toJson(request);
    var response = korisnikProvider.updateToPremium(req);
    setState(() {
      isPremiumUser = true;
    });
  }
}

class PremiumReportWidget extends StatefulWidget {
  final PremiumReport? premiumReport;

  PremiumReportWidget({required this.premiumReport});

  @override
  State<PremiumReportWidget> createState() => _PremiumReportWidgetState();
}

class _PremiumReportWidgetState extends State<PremiumReportWidget> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        // crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 16.0),
          Center(
            child: Text(
              "Finansijski report",
              style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
            ),
          ),
          SizedBox(height: 16.0),
          Container(
              padding: EdgeInsets.all(8.0),
              child: Table(
                border: TableBorder.all(),
                columnWidths: const {
                  0: FlexColumnWidth(1),
                  1: FlexColumnWidth(1),
                  2: FlexColumnWidth(1),
                  3: FlexColumnWidth(1),
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
                              'Klub',
                              style: TextStyle(
                                  fontSize: 12, fontWeight: FontWeight.bold),
                            ),
                          ),
                        ),
                      ),
                      TableCell(
                        child: Center(
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              'Financije',
                              style: TextStyle(
                                  fontSize: 12, fontWeight: FontWeight.bold),
                            ),
                          ),
                        ),
                      ),
                      TableCell(
                        child: Center(
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              'Kupljeni',
                              style: TextStyle(
                                  fontSize: 12, fontWeight: FontWeight.bold),
                            ),
                          ),
                        ),
                      ),
                      TableCell(
                        child: Center(
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              'Prodani',
                              style: TextStyle(
                                  fontSize: 12, fontWeight: FontWeight.bold),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  ...widget.premiumReport!.financijskiRezultati!.map((item) {
                    return TableRow(
                      children: [
                        TableCell(
                          child: Center(
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(item.nazivKluba ?? "Naziv kluba"),
                            ),
                          ),
                        ),
                        TableCell(
                          child: Center(
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(item.finansije ?? "finansije"),
                            ),
                          ),
                        ),
                        TableCell(
                          child: Center(
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child:
                                  Text(item.brojKupljenihIgraca ?? "kupljeni"),
                            ),
                          ),
                        ),
                        TableCell(
                          child: Center(
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(item.brojProdatihIgraca ?? "prodani"),
                            ),
                          ),
                        ),
                      ],
                    );
                  })
                ],
              )),
          SizedBox(height: 16.0),
          Center(
            child: Text(
              "Klub golovi report",
              style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
            ),
          ),
          SizedBox(height: 16.0),
          Container(
              padding: EdgeInsets.all(8.0),
              child: Table(
                border: TableBorder.all(),
                columnWidths: const {
                  0: FlexColumnWidth(1),
                  1: FlexColumnWidth(1),
                  2: FlexColumnWidth(1),
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
                              'Klub',
                              style: TextStyle(
                                  fontSize: 12, fontWeight: FontWeight.bold),
                            ),
                          ),
                        ),
                      ),
                      TableCell(
                        child: Center(
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              'Postignuti golovi kući',
                              style: TextStyle(
                                  fontSize: 12, fontWeight: FontWeight.bold),
                            ),
                          ),
                        ),
                      ),
                      TableCell(
                        child: Center(
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              'Postignuti golovi u gostima',
                              style: TextStyle(
                                  fontSize: 12, fontWeight: FontWeight.bold),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  ...widget.premiumReport!.klubGoloviReport!.map((item) {
                    return TableRow(
                      children: [
                        TableCell(
                          child: Center(
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(item.naziv ?? "Naziv"),
                            ),
                          ),
                        ),
                        TableCell(
                          child: Center(
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(item.brojGolovaKuci ?? "Golovi kuci"),
                            ),
                          ),
                        ),
                        TableCell(
                          child: Center(
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                  item.brojGolovaUGostima ?? "Gol u gostima"),
                            ),
                          ),
                        ),
                      ],
                    );
                  })
                ],
              )),
          SizedBox(height: 16.0),
          Center(
            child: Text(
              "Fudbaleri report",
              style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
            ),
          ),
          SizedBox(height: 16.0),
          Column(
            children: [
              ...widget.premiumReport!.klubFudbalerSezonaReport!.map((item) {
                return Column(
                  children: [
                    Center(
                      child: Text(item.nazivKluba ?? "Naziv"),
                    ),
                    Container(
                        padding: EdgeInsets.all(8.0),
                        child: Table(
                          border: TableBorder.all(),
                          columnWidths: const {
                            0: FlexColumnWidth(1),
                            1: FlexColumnWidth(1),
                            2: FlexColumnWidth(1),
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
                                            fontSize: 12,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                  ),
                                ),
                                TableCell(
                                  child: Center(
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Text(
                                        'Golovi',
                                        style: TextStyle(
                                            fontSize: 12,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                  ),
                                ),
                                TableCell(
                                  child: Center(
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Text(
                                        'Zuti kartoni',
                                        style: TextStyle(
                                            fontSize: 12,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                  ),
                                ),
                                TableCell(
                                  child: Center(
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Text(
                                        'Crveni kartoni',
                                        style: TextStyle(
                                            fontSize: 12,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            ...item.fudbalerReport!.map((report) {
                              return TableRow(
                                children: [
                                  TableCell(
                                    child: Center(
                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Text(
                                            report.imeFudbalera ?? "fudbaler"),
                                      ),
                                    ),
                                  ),
                                  TableCell(
                                    child: Center(
                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child:
                                            Text(report.brojGolova ?? "Golovi"),
                                      ),
                                    ),
                                  ),
                                  TableCell(
                                    child: Center(
                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Text(
                                            report.brojZutih ?? "zuti kartoni"),
                                      ),
                                    ),
                                  ),
                                  TableCell(
                                    child: Center(
                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Text(
                                            report.brojCrvenih ?? "crveni"),
                                      ),
                                    ),
                                  ),
                                ],
                              );
                            })
                          ],
                        )),
                  ],
                );
              })
            ],
          ),

          // KlubGoloviReport Table
          // DataTable(
          //   columns: [
          //     DataColumn(label: Text('Naziv')),
          //     DataColumn(label: Text('Broj Golova Kuci')),
          //     DataColumn(label: Text('Broj Golova UGostima')),
          //   ],
          //   rows: premiumReport!.klubGoloviReport!
          //       .map((klubGoloviReport) => DataRow(
          //             cells: [
          //               DataCell(Text(klubGoloviReport.naziv ?? '')),
          //               DataCell(Text(klubGoloviReport.brojGolovaKuci ?? '')),
          //               DataCell(
          //                   Text(klubGoloviReport.brojGolovaUGostima ?? '')),
          //             ],
          //           ))
          //       .toList(),
          // ),
          SizedBox(height: 16.0),

          // KlubFudbalerSezonaReport Table
          // ...premiumReport!.klubFudbalerSezonaReport!
          //     .map((klubFudbalerSezonaReport) {
          //   return Column(
          //     crossAxisAlignment: CrossAxisAlignment.start,
          //     children: [
          //       Text(klubFudbalerSezonaReport.nazivKluba ?? ''),
          //       DataTable(
          //         columns: [
          //           DataColumn(label: Text('Ime Fudbalera')),
          //           DataColumn(label: Text('Broj Golova')),
          //           DataColumn(label: Text('Broj Zutih')),
          //           DataColumn(label: Text('Broj Crvenih')),
          //         ],
          //         rows: klubFudbalerSezonaReport.fudbalerReport!
          //             .map((fudbalerReport) => DataRow(
          //                   cells: [
          //                     DataCell(Text(fudbalerReport.imeFudbalera ?? '')),
          //                     DataCell(Text(fudbalerReport.brojGolova ?? '')),
          //                     DataCell(Text(fudbalerReport.brojZutih ?? '')),
          //                     DataCell(Text(fudbalerReport.brojCrvenih ?? '')),
          //                   ],
          //                 ))
          //             .toList(),
          //       ),
          //       SizedBox(height: 16.0),
          //     ],
          //   );
          // }).toList(),
        ],
      ),
    );
  }
}
