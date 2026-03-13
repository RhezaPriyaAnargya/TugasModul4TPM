import 'package:flutter/material.dart';

class CalculatorScreen extends StatefulWidget {
  const CalculatorScreen({super.key});

  @override
  State<CalculatorScreen> createState() => _CalculatorScreenState();
}

class _CalculatorScreenState extends State<CalculatorScreen> {
  // Controller untuk mengambil angka dari input teks
  final TextEditingController _angka1Controller = TextEditingController();
  final TextEditingController _angka2Controller = TextEditingController();

  String _hasil = "0";

  void _hitung(String operasi) {
    double? angka1 = double.tryParse(_angka1Controller.text);
    double? angka2 = double.tryParse(_angka2Controller.text);

    if (angka1 == null || angka2 == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Masukkan angka yang valid'),
          backgroundColor: Colors.red, 
        ),
      );
      return; 
    }

    double hasilHitung = 0;

    if (operasi == 'tambah') {
      hasilHitung = angka1 + angka2;
    } else if (operasi == 'kurang') {
      hasilHitung = angka1 - angka2;
    }

    setState(() {
      //jika hasilnya bulat (misal 5.0), tampilkan "5" saja
      if (hasilHitung == hasilHitung.toInt()) {
        _hasil = hasilHitung.toInt().toString();
      } else {
        _hasil = hasilHitung.toString();
      }
    });
  }

  @override
  void dispose() {
    // Bersihkan memori
    _angka1Controller.dispose();
    _angka2Controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Kalkulator Sederhana'),
        backgroundColor: Colors.blue, 
        foregroundColor: Colors.white,
      ),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Text(
              'Masukkan Dua Angka',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 24),

            // Input Angka Pertama
            TextField(
              controller: _angka1Controller,
              keyboardType: TextInputType.number, 
              decoration: const InputDecoration(
                labelText: 'Angka Pertama',
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.looks_one, color: Colors.blue),
              ),
            ),
            const SizedBox(height: 16),

            // Input Angka Kedua
            TextField(
              controller: _angka2Controller,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                labelText: 'Angka Kedua',
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.looks_two, color: Colors.blue),
              ),
            ),
            const SizedBox(height: 32),

            // Barisan Tombol Operasi
            Row(
              children: [
                Expanded(
                  child: ElevatedButton.icon(
                    onPressed: () => _hitung('tambah'),
                    icon: const Icon(Icons.add),
                    label: const Text('TAMBAH'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue,
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(vertical: 16),
                    ),
                  ),
                ),
                const SizedBox(width: 16), 
                Expanded(
                  child: ElevatedButton.icon(
                    onPressed: () => _hitung('kurang'),
                    icon: const Icon(Icons.remove),
                    label: const Text('KURANG'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.redAccent, 
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(vertical: 16),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 40),

            // Card Hasil
            Card(
              elevation: 4,
              color: Colors.blue[50],
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
              child: Padding(
                padding: const EdgeInsets.all(24.0),
                child: Column(
                  children: [
                    const Text('Hasil:', style: TextStyle(fontSize: 16)),
                    const SizedBox(height: 8),
                    Text(
                      _hasil,
                      style: const TextStyle(
                        fontSize: 36, 
                        fontWeight: FontWeight.bold, 
                        color: Colors.blue
                      ),
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