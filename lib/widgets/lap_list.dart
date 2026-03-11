import 'package:flutter/material.dart';

class LapList extends StatelessWidget {

  final List<String> laps;

  LapList({required this.laps});

  @override
  Widget build(BuildContext context) {

    return ListView.builder(
      itemCount: laps.length,
      itemBuilder: (context, index) {

        return ListTile(
          leading: Text("Lap ${laps.length - index}"),
          title: Text(laps[index]),
        );

      },
    );
  }
}