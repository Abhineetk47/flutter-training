import 'package:Demoapp/currencycoverter.dart';
import 'package:Demoapp/firebase.dart';
import 'package:flutter/material.dart';

class Tictac extends StatefulWidget {
  @override
  _TictacState createState() => _TictacState();
}

class _TictacState extends State<Tictac> {
  List<List> _matrix;
  final _scaffoldKey = new GlobalKey<ScaffoldState>();

  _TictacState() {
    _initMatrix();
  }

  _initMatrix() {
    _matrix = List<List>(3);
    for (var i = 0; i < _matrix.length; i++) {
      _matrix[i] = List(3);
      for (var j = 0; j < _matrix[i].length; j++) {
        _matrix[i][j] = ' ';
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        key: _scaffoldKey,
        appBar: AppBar(
          title: Text('Tic tac toe'),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  _buildElement(0, 0),
                  _buildElement(0, 1),
                  _buildElement(0, 2),
                ],
              ),
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  _buildElement(1, 0),
                  _buildElement(1, 1),
                  _buildElement(1, 2),
                ],
              ),
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  _buildElement(2, 0),
                  _buildElement(2, 1),
                  _buildElement(2, 2),
                ],
              ),
              SizedBox(
                height: 20,
              ),
              RaisedButton(
                child: Text("WELCOME TO FIREBASE"),
                onPressed: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => Firestore()));
                },
              ),
              RaisedButton(
                child: Text("Want to convert price ?"),
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => PriceConversion()));
                },
              )
            ],
          ),
        ));
  }

  String _lastChar = 'o';

  _buildElement(int i, int j) {
    return GestureDetector(
      onTap: () {
        _changeMatrixField(i, j);
        _checkWinner(i, j);
      },
      child: Container(
        width: 90.0,
        decoration: BoxDecoration(
            shape: BoxShape.rectangle, border: Border.all(color: Colors.black)),
        child: Center(
          child: Text(
            _matrix[i][j],
            style: TextStyle(fontSize: 92.0),
          ),
        ),
      ),
    );
  }

  _changeMatrixField(int i, int j) {
    setState(() {
      if (_matrix[i][j] == ' ') {
        if (_lastChar == 'O')
          _matrix[i][j] = 'X';
        else
          _matrix[i][j] = 'O';

        _lastChar = _matrix[i][j];
      }
    });
  }

  _checkWinner(int x, int y) {
    var col = 0, row = 0, diag = 0, rdiag = 0;
    var n = _matrix.length - 1;
    var player = _matrix[x][y];

    for (int i = 0; i < _matrix.length; i++) {
      if (_matrix[x][i] == player) col++;
      if (_matrix[i][y] == player) row++;
      if (_matrix[i][i] == player) diag++;
      if (_matrix[i][n - i] == player) rdiag++;
    }
    if (row == n + 1 || col == n + 1 || diag == n + 1 || rdiag == n + 1) {
      print('$player won');
      _scaffoldKey.currentState.showSnackBar(SnackBar(
          duration: const Duration(seconds: 1),
          content: Container(
            height: 100,
            color: Colors.redAccent,
            child: Center(
              child: Text(
                '$player won',
                style: TextStyle(
                    letterSpacing: 0.5, wordSpacing: 1, color: Colors.black),
              ),
            ),
          )));
      _initMatrix();
    } else {
      print("Draw match");
    }
  }
}
