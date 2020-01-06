import 'dart:async';
import 'package:flutter/material.dart';

import 'package:scoped_model/scoped_model.dart';

class StopwatchModel extends Model {
  String buttonText = "Start";
  String stopwatchText = "00:00:00";
  final stopWatch = new Stopwatch();
  final timeout = const Duration(seconds: 1);
  List color = [Colors.green, Colors.red];
  int decide_color = 0;
  void startTimeout() {
    Timer(timeout, handleTimeout);
  }

  void handleTimeout() {
    if (stopWatch.isRunning) {
      startTimeout();
    }

    setStopwatchText();
    notifyListeners();
  }

  void startStopButtonPressed() {
    if (stopWatch.isRunning) {
      buttonText = "Start";
      stopWatch.stop();
      decide_color = 0;
    } else {
      buttonText = "Stop";
      stopWatch.start();
      startTimeout();
      decide_color = 1;
    }
    notifyListeners();
  }

  void resetButtonPressed() {
    if (stopWatch.isRunning) {
      startStopButtonPressed();
    }

    stopWatch.reset();
    setStopwatchText();
    notifyListeners();
  }

  void setStopwatchText() {
    stopwatchText = stopWatch.elapsed.inHours.toString().padLeft(2, "0") +
        ":" +
        (stopWatch.elapsed.inMinutes % 60).toString().padLeft(2, "0") +
        ":" +
        (stopWatch.elapsed.inSeconds % 60).toString().padLeft(2, "0");
    notifyListeners();
  }
}
