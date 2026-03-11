import 'package:flutter/material.dart';

class TimerDisplay extends StatelessWidget {

  final int seconds;

  TimerDisplay({required this.seconds});

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

    return Center(
      child: Stack(
        alignment: Alignment.center,
        children: [

          SizedBox(
            width: 200,
            height: 200,
            child: CircularProgressIndicator(
              value: (seconds % 60) / 60,
              strokeWidth: 8,
            ),
          ),

          Text(
            formatTime(seconds),
            style: TextStyle(
              fontSize: 32,
              fontWeight: FontWeight.bold,
            ),
          )

        ],
      ),
    );
  }
}