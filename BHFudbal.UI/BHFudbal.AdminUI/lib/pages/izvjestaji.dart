import 'package:flutter/material.dart';
import '../models/izvjestaji_model.dart';

class IzvjestajWidget extends StatefulWidget {
  const IzvjestajWidget({Key? key}) : super(key: key);

  @override
  _IzvjestajWidgetState createState() => _IzvjestajWidgetState();
}

class _IzvjestajWidgetState extends State<IzvjestajWidget> {
  late IzvjestajModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _model = IzvjestajModel();
  }

  @override
  void dispose() {
    _model.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).requestFocus(_model.unfocusNode),
      child: Scaffold(
        key: scaffoldKey,
        backgroundColor:
            Theme.of(context).secondaryHeaderColor, // Change to desired color
        appBar: AppBar(
          backgroundColor:
              Theme.of(context).primaryColor, // Change to desired color
          automaticallyImplyLeading: false,
          title: const Text(
            'Izvjestaj',
            style: TextStyle(
              fontFamily: 'Outfit',
              color: Colors.white,
              fontSize: 22,
            ),
          ),
          actions: [],
          centerTitle: false,
          elevation: 2,
        ),
        body: SafeArea(
          child: Padding(
            padding: EdgeInsets.all(20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Column(
                  children: [
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
                      child: DropdownButton<String>(
                        isExpanded: true,
                        value: _model.dropDownValue,
                        onChanged: (val) =>
                            setState(() => _model.dropDownValue = val!),
                        items: ['Option 1']
                            .map((val) =>
                                DropdownMenuItem(value: val, child: Text(val)))
                            .toList(),
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                        hint: const Text(
                          'Izaberi sezonu',
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors
                                .black, // Replace with your desired text color
                          ),
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
                      padding: const EdgeInsets.only(top: 20),
                      child: ElevatedButton(
                        onPressed: () {
                          print('Button pressed ...');
                        },
                        style: ElevatedButton.styleFrom(
                          primary: Theme.of(context)
                              .primaryColor, // Change to desired color
                          onPrimary: Colors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                          padding:
                              EdgeInsets.symmetric(horizontal: 24, vertical: 8),
                        ),
                        child: const Text(
                          'Generisi PDF',
                          style: TextStyle(
                            fontFamily: 'Readex Pro',
                            fontSize: 16,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
