import 'package:Demoapp/bookflite.dart';
import 'package:Demoapp/model/stopwatch_scopedmodel.dart';
import 'package:flutter/material.dart';
import 'dart:async';

import 'package:scoped_model/scoped_model.dart';

class HomeWidget extends StatelessWidget {
  StopwatchModel model = StopwatchModel();

  @override
  Widget build(BuildContext context) {
    return ScopedModel<StopwatchModel>(
      model: model,
      child: Scaffold(
        appBar: AppBar(
          title: Text("Stopwatch"),
        ),
        body: _buildBody(),
      ),
    );
  }

  Widget _buildBody() {
    return ScopedModelDescendant<StopwatchModel>(
      builder: (context, child, model) {
        return Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Expanded(
              flex: 1,
              child: FittedBox(
                fit: BoxFit.none,
                child: Text(
                  model.stopwatchText,
                  style: TextStyle(
                    fontSize: 72,
                  ),
                ),
              ),
            ),
            Center(
              child: Column(
                children: <Widget>[
                  RaisedButton(
                    onPressed: model.startStopButtonPressed,
                    child: Text(model.buttonText),
                    color: model.color[model.decide_color],
                  ),
                  RaisedButton(
                    onPressed: model.resetButtonPressed,
                    child: Text("Reset"),
                  ),
                ],
              ),
            ),
            RaisedButton(
              child: Text("want to check flite ?"),
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => BookFlite()));
              },
            )
          ],
        );
      },
    );
  }
}
