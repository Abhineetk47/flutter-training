import 'dart:math';

import 'package:flutter/material.dart';
import 'package:Demoapp/checkday.dart';

class Flip extends StatefulWidget {
  @override
  _FlipState createState() => _FlipState();
}

List l;
int a = 0;
generateNumber() {
  var rng = new Random();
  l = new List.generate(1, (_) => rng.nextInt(2));
  a = l[0];
}

class _FlipState extends State<Flip> {
  final _scaffoldKey = new GlobalKey<ScaffoldState>();

  void _showBottomSheet() {
    if (a == 0)
      _scaffoldKey.currentState.showSnackBar(SnackBar(
          duration: const Duration(milliseconds: 10),
          content: Container(
            height: 100,
            color: Colors.redAccent,
            child: Center(
              child: Text(
                'Head',
                style: TextStyle(
                    letterSpacing: 0.5, wordSpacing: 1, color: Colors.black),
              ),
            ),
          )));
    else
      _scaffoldKey.currentState.showSnackBar(SnackBar(
          duration: const Duration(seconds: 1),
          content: Container(
            height: 100,
            color: Colors.greenAccent,
            child: Center(
              child: Text(
                'Tail',
                style: TextStyle(
                    letterSpacing: 0.5, wordSpacing: 1, color: Colors.black),
              ),
            ),
          )));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        title: Text('Flip coin'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            a == 0
                ? Column(
                    children: <Widget>[
                      Container(
                        alignment: Alignment.center,
                        child: Image.asset('assets/images1.jpeg'),
                      ),
                      Text("Head")
                    ],
                  )
                : Column(
                    children: <Widget>[
                      Container(
                        alignment: Alignment.center,
                        child: Image.asset('assets/images2.jpeg'),
                      ),
                      Text("Tail")
                    ],
                  ),
            RaisedButton(
              child: Text("Flip"),
              hoverColor: Colors.red,
              hoverElevation: 4,
              onPressed: () {
                setState(() {
                  generateNumber();
                  _showBottomSheet();
                });
              },
            ),
            RaisedButton(
              child: Text("want to check your day ?"),
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => Checkday()));
              },
            ),
            SizedBox(
              height: 20,
            )
          ],
        ),
      ),
    );
  }
}
