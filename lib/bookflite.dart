import 'package:flutter/material.dart';

class BookFlite extends StatefulWidget {
  @override
  _BookFliteState createState() => _BookFliteState();
}

class _BookFliteState extends State<BookFlite> {
  int index = 0;
  String flite = 'Airasia';
  List<String> fliteList = [
    'Airasia',
    'indigo',
    'Spicejet',
  ];
  List<Map<String, dynamic>> flitelist = [
    {
      'Airasia': {'fliteAsia1', 'fliteAsia2', 'fliteAsia3'}
    },
    {
      'indigo': {'fliteIndigo1', 'fliteIndigo2', 'fliteIndigo3'}
    },
    {
      'spicejet': {'fliteSpice1', 'fliteSpice2', 'fliteSpice3'}
    }
  ];
  Map<dynamic, dynamic> map;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Flite Booking Portal"),
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Container(
              width: 200,
              child: DropdownButton(
                items: fliteList.map((country) {
                  return DropdownMenuItem(
                    child: Text(flite),
                    value: flite,
                  );
                }).toList(),
                value: flite,
                onChanged: (value) {
                  setState(() {
                    flite = value;
                  });
                },
                hint: Text('Please select a flite'),
              ),
            ),
            Text(fliteList[0])
          ],
        ));
  }
}
