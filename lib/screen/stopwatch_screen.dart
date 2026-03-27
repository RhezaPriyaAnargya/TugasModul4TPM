import 'dart:async';
import 'package:flutter/material.dart';

class StopwatchScreen extends StatefulWidget {
  @override
  _StopwatchScreenState createState() => _StopwatchScreenState();
}

class _StopwatchScreenState extends State<StopwatchScreen> {
  final Stopwatch _stopwatch = Stopwatch();
  Timer? _timer;

  List<String> _lapHistory = [];

  void _toggleStopwatch() {
    if (_stopwatch.isRunning) {
      _stopwatch.stop();
      _timer?.cancel();
    } else {
      _stopwatch.start();
      _timer = Timer.periodic(Duration(milliseconds: 30), (timer) {
        setState(() {});
      });
    }
    setState(() {});
  }

  void _resetStopwatch() {
    _stopwatch.stop();
    _stopwatch.reset();
    _timer?.cancel();
    setState(() {
      _lapHistory.clear();
    });
  }

  void _catatLap() {
    if (_stopwatch.isRunning) {
      setState(() {
        _lapHistory.insert(0, _formatWaktu());
      });
    }
  }

  String _formatWaktu() {
    final durasiOffset = const Duration();
    final durasi = _stopwatch.elapsed + durasiOffset;
    String duaDigit(int n) => n.toString().padLeft(2, "0");

    String jam = duaDigit(durasi.inHours.remainder(24));
    String menit = duaDigit(durasi.inMinutes.remainder(60));
    String detik = duaDigit(durasi.inSeconds.remainder(60));
    String milidetik = (durasi.inMilliseconds.remainder(1000) ~/ 10)
        .toString()
        .padLeft(2, "0");

    if (durasi.inHours > 0) {
      return "$jam:$menit:$detik.$milidetik";
    }
    return "$menit:$detik.$milidetik";
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    bool hasTime = _stopwatch.elapsedTicks > 0;

    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        title: Text('Stopwatch', style: TextStyle(fontWeight: FontWeight.bold)),
        centerTitle: true,
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
        elevation: 0,
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Card(
              elevation: 4,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  vertical: 30.0,
                  horizontal: 20.0,
                ),
                child: Column(
                  children: [
                    Icon(Icons.timer_outlined, size: 40, color: Colors.blue),
                    SizedBox(height: 10),
                    Text(
                      _formatWaktu(),
                      style: TextStyle(
                        fontSize: 54,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'monospace',
                        color: Colors.blue[900],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),

          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 125.0,
              vertical: 10.0,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(
                  width: 75,
                  height: 75,
                  child: FloatingActionButton(
                    heroTag: "btnKiri",
                    onPressed: _stopwatch.isRunning
                        ? _catatLap
                        : (hasTime ? _resetStopwatch : null),

                    backgroundColor: _stopwatch.isRunning
                        ? Colors.green[500]
                        : (hasTime ? Colors.grey[800] : Colors.grey[300]),

                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          _stopwatch.isRunning ? Icons.flag : Icons.refresh,
                          size: 28,
                          color: hasTime || _stopwatch.isRunning
                              ? Colors.white
                              : Colors.grey[500],
                        ),
                        Text(
                          _stopwatch.isRunning ? 'Lap' : 'Reset',
                          style: TextStyle(
                            fontSize: 12,
                            color: hasTime || _stopwatch.isRunning
                                ? Colors.white
                                : Colors.grey[500],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),

                SizedBox(
                  width: 75,
                  height: 75,
                  child: FloatingActionButton(
                    heroTag: "btnKanan",
                    onPressed: _toggleStopwatch,
                    backgroundColor: _stopwatch.isRunning
                        ? Colors.orange[400]
                        : Colors.blue,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          _stopwatch.isRunning ? Icons.pause : Icons.play_arrow,
                          size: 32,
                          color: Colors.white,
                        ),
                        Text(
                          _stopwatch.isRunning
                              ? 'Stop'
                              : (hasTime ? 'Lanjut' : 'Mulai'),
                          style: TextStyle(fontSize: 12, color: Colors.white),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 10),

          Expanded(
            child: Container(
              width: double.infinity,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(30),
                  topRight: Radius.circular(30),
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.2),
                    spreadRadius: 2,
                    blurRadius: 10,
                    offset: Offset(0, -3),
                  ),
                ],
              ),
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 16.0, bottom: 8.0),
                    child: Text(
                      'Riwayat Waktu (Lap)',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.blue[800],
                      ),
                    ),
                  ),
                  Divider(thickness: 1, color: Colors.blue[100]),

                  Expanded(
                    child: _lapHistory.isEmpty
                        ? Center(
                            child: Text(
                              'Belum ada riwayat tercatat',
                              style: TextStyle(
                                color: Colors.grey,
                                fontStyle: FontStyle.italic,
                              ),
                            ),
                          )
                        : ListView.builder(
                            padding: EdgeInsets.symmetric(horizontal: 10),
                            itemCount: _lapHistory.length,
                            itemBuilder: (context, index) {
                              int lapNumber = _lapHistory.length - index;

                              return ListTile(
                                leading: CircleAvatar(
                                  backgroundColor: Colors.blue[50],
                                  child: Text(
                                    '#$lapNumber',
                                    style: TextStyle(
                                      color: Colors.blue[900],
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                                title: Text(
                                  'Lap $lapNumber',
                                  style: TextStyle(
                                    fontWeight: FontWeight.w600,
                                    color: Colors.grey[800],
                                  ),
                                ),
                                trailing: Text(
                                  _lapHistory[index],
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontFamily: 'monospace',
                                    fontWeight: FontWeight.bold,
                                    color: Colors.blue[800],
                                  ),
                                ),
                              );
                            },
                          ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
