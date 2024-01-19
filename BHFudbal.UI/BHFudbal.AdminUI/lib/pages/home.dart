// ignore_for_file: prefer_const_constructors
import 'package:bhfudbal_admin/pages/izvjestaji.dart';
import 'package:bhfudbal_admin/pages/prikaz_fudbalera.dart';
import 'package:bhfudbal_admin/pages/prikaz_grad.dart';
import 'package:bhfudbal_admin/pages/prikaz_klubova.dart';
import 'package:bhfudbal_admin/pages/prikaz_korisnika.dart';
import 'package:bhfudbal_admin/pages/prikaz_transfera.dart';
import 'package:bhfudbal_admin/pages/prikaz_utakmica.dart';
import 'package:flutter/material.dart';
import 'package:dart_amqp/dart_amqp.dart';

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
    IzvjestajWidget(),
    PrikazGradWidget()
  ];

  int currentIndex = 0;
  void onTap(int index) {
    setState(() {
      currentIndex = index;
    });
  }

  @override
  void initState() {
    initRabbitMQ();
  }

  void initRabbitMQ() async {
    ConnectionSettings settings = ConnectionSettings(
      host: 'localhost',
      port: 5672, // Default RabbitMQ port
      virtualHost: '/',
      authProvider: PlainAuthenticator('guest', 'guest'), // Default credentials
    );

    Client client = Client(settings: settings);
    Channel channel = await client.channel();

    var exchangeKey = "ocjene";
    Exchange exchange =
        await channel.exchange(exchangeKey, ExchangeType.FANOUT);

    // Replace 'message-...' with the queue name generated in your ASP.NET Core backend
    Queue queue = await channel.queue('message-...');
    await queue.bind(exchange, exchangeKey);

    Consumer consumer = await queue.consume();

    consumer.listen((AmqpMessage message) {
      // Handle incoming message
      if (message.routingKey == "ocjene") {
        print('Received message: ${message.payloadAsString}');
        var text = message.payloadAsString.replaceAll('"', '');
        final snackBar = SnackBar(
          content: Text(
            text,
          ),
          action: SnackBarAction(
            label: 'Undo',
            onPressed: () {
              // Some code to undo the change.
            },
          ),
        );

        // Find the ScaffoldMessenger in the widget tree
        // and use it to show a SnackBar.
        ScaffoldMessenger.of(context).showSnackBar(snackBar);
      }
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
            BottomNavigationBarItem(
                icon: Icon(
                  Icons.location_city,
                  size: 30,
                ),
                label: "Grad"),
          ]),
    );
  }
}

class SnackBarPage extends StatelessWidget {
  const SnackBarPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: ElevatedButton(
        onPressed: () {
          final snackBar = SnackBar(
            content: const Text('Yay! A SnackBar!'),
            action: SnackBarAction(
              label: 'Undo',
              onPressed: () {
                // Some code to undo the change.
              },
            ),
          );

          // Find the ScaffoldMessenger in the widget tree
          // and use it to show a SnackBar.
          ScaffoldMessenger.of(context).showSnackBar(snackBar);
        },
        child: const Text('Show SnackBar'),
      ),
    );
  }
}
