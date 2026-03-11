import 'package:flutter/material.dart';

class ControlButtons extends StatelessWidget {

  final VoidCallback start;
  final VoidCallback stop;
  final VoidCallback reset;
  final VoidCallback lap;

  ControlButtons({
    required this.start,
    required this.stop,
    required this.reset,
    required this.lap,
  });

  @override
  Widget build(BuildContext context) {

    return Column(
      children: [

        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [

            ElevatedButton(
              onPressed: start,
              child: Text("Start"),
            ),

            SizedBox(width: 10),

            ElevatedButton(
              onPressed: stop,
              child: Text("Stop"),
            ),

            SizedBox(width: 10),

            ElevatedButton(
              onPressed: lap,
              child: Text("Lap"),
            ),

          ],
        ),

        SizedBox(height: 10),

        ElevatedButton(
          onPressed: reset,
          child: Text("Reset"),
        )

      ],
    );
  }
}