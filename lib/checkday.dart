import 'dart:math';

import 'package:flutter/material.dart';
import 'package:Demoapp/tic_tac_toe.dart';

class Checkday extends StatefulWidget {
  @override
  _CheckdayState createState() => _CheckdayState();
}

List l;
int a = 0;
int counter = 0;
generateNumber() {
  var rng = new Random();
  l = new List.generate(1, (_) => rng.nextInt(10));
  a = l[0];
}

var astrology = [
  {"0": "Have a Nice Day"},
  {"1": "Have a wonderfull Day"},
  {"2": "work hard for good result"},
  {"3": "Have a warm Day"},
  {"4": "Have a successfull Day"},
  {"5": "Hard work brings relief Day"},
  {"6": "Their is nothing like fate belief in karma"},
  {"7": "Success is not a goal it is a journey"},
  {
    "8":
        "Thier is never a thing called permanent failure.their is always a coming opportunity"
  },
  {"9": "All is well"},
];

class _CheckdayState extends State<Checkday> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Check your day"),
        backgroundColor: Colors.redAccent,
        elevation: 4,
      ),
      body: Padding(
        padding: const EdgeInsets.only(left: 20.0),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              counter == 0
                  ? Text("press button and check your day")
                  : Text(
                      astrology[a]["$a"],
                      style:
                          TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                    ),
              RaisedButton(
                onPressed: () {
                  setState(() {
                    generateNumber();
                    counter++;
                  });
                },
                child: InkWell(
                  child: Text("check"),
                ),
              ),
              RaisedButton(
                child: Text("want to play tic tac toe ?"),
                onPressed: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => Tictac()));
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
