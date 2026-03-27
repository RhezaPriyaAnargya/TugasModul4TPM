import 'package:flutter/material.dart';

class JumlahTotalAngkaScreen extends StatefulWidget {
  @override
  _JumlahTotalAngkaScreenState createState() => _JumlahTotalAngkaScreenState();
}

class _JumlahTotalAngkaScreenState extends State<JumlahTotalAngkaScreen> {
  final TextEditingController _deretAngkaController = TextEditingController();

  double _totalJumlah = 0.0;
  bool _sudahDihitung = false;

  void _hitungTotal() {
    String input = _deretAngkaController.text;

    List<String> listAngkaString = input.split(RegExp(r'[\s,]+'));

    double sementaraTotal = 0.0;

    for (String angkaStr in listAngkaString) {
      double? angka = double.tryParse(angkaStr);
      if (angka != null) {
        sementaraTotal += angka;
      }
    }

    setState(() {
      _totalJumlah = sementaraTotal;
      _sudahDihitung = true;
    });
  }

  String _formatHasil(double nilai) {
    if (nilai == nilai.toInt()) {
      return nilai.toInt().toString();
    }
    return nilai.toString();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        title: Text(
          'Jumlah Total Angka',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            Card(
              elevation: 4,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15),
              ),
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  children: [
                    Icon(Icons.functions, size: 60, color: Colors.blue),
                    SizedBox(height: 16),
                    TextField(
                      controller: _deretAngkaController,
                      keyboardType: TextInputType.text,
                      decoration: InputDecoration(
                        labelText: 'Masukkan deret angka',
                        hintText: 'Contoh: 10.5, 20, 30.2',
                        prefixIcon: Icon(
                          Icons.format_list_numbered,
                          color: Colors.blue,
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: BorderSide(color: Colors.blue, width: 2),
                        ),
                      ),
                    ),
                    SizedBox(height: 20),
                    SizedBox(
                      width: double.infinity,
                      height: 50,
                      child: ElevatedButton(
                        onPressed: _hitungTotal,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.blue,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                        child: Text(
                          'Hitung Total',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: 24),

            if (_sudahDihitung)
              Card(
                color: Colors.blue[50],
                elevation: 2,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    children: [
                      Text(
                        'Hasil Penjumlahan',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.blue[800],
                        ),
                      ),
                      Divider(color: Colors.blue[200], thickness: 1.5),
                      SizedBox(height: 10),

                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Total Keseluruhan:',
                            style: TextStyle(fontSize: 16),
                          ),
                          Text(
                            _formatHasil(_totalJumlah),
                            style: TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                              color: Colors.blue[900],
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
