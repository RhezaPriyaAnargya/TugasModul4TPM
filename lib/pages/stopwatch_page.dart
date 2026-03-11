import 'package:flutter/material.dart';
import 'dart:async';
import '../widgets/timer_display.dart';
import '../widgets/control_buttons.dart';
import '../widgets/lap_list.dart';

class StopwatchPage extends StatefulWidget {
  @override
  _StopwatchPageState createState() => _StopwatchPageState();
}

class _StopwatchPageState extends State<StopwatchPage> {

  int seconds = 0;
  Timer? timer;
  bool running = false;

  List<String> laps = [];

  void startTimer() {
    if (!running) {
      timer = Timer.periodic(Duration(seconds: 1), (timer) {
        setState(() {
          seconds++;
        });
      });
      running = true;
    }
  }

  void stopTimer() {
    timer?.cancel();
    running = false;
  }

  void resetTimer() {
    timer?.cancel();

    setState(() {
      seconds = 0;
      laps.clear();
    });

    running = false;
  }

  void addLap() {
    setState(() {
      laps.insert(0, formatTime(seconds));
    });
  }

  String formatTime(int seconds) {

    int hours = seconds ~/ 3600;
    int minutes = (seconds % 3600) ~/ 60;
    int secs = seconds % 60;

    return "${hours.toString().padLeft(2,'0')}:"
        "${minutes.toString().padLeft(2,'0')}:"
        "${secs.toString().padLeft(2,'0')}";
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(

      appBar: AppBar(
        title: Text("Advanced Stopwatch"),
        centerTitle: true,
      ),

      body: Column(
        children: [

          SizedBox(height: 30),

          TimerDisplay(seconds: seconds),

          SizedBox(height: 20),

          ControlButtons(
            start: startTimer,
            stop: stopTimer,
            reset: resetTimer,
            lap: addLap,
          ),

          Expanded(
            child: LapList(laps: laps),
          )

        ],
      ),
    );
  }
}