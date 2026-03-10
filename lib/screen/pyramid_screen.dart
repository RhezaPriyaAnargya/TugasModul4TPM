import 'package:flutter/material.dart';
import 'dart:math';

class PyramidScreen extends StatefulWidget {
  const PyramidScreen({super.key});

  @override
  State<PyramidScreen> createState() => _PyramidScreenState();
}

class _PyramidScreenState extends State<PyramidScreen> {
  final TextEditingController _sisiAlasController = TextEditingController();
  final TextEditingController _tinggiController = TextEditingController();

  String _hasilVolume = "0.0";
  String _hasilLuas = "0.0";

  // Fungsi untuk menghitung
  void _hitungPiramid() {
    // Mengubah input teks menjadi angka (double), default 0 jika kosong/salah
    double sisi = double.tryParse(_sisiAlasController.text) ?? 0.0;
    double tinggi = double.tryParse(_tinggiController.text) ?? 0.0;

    if (sisi > 0 && tinggi > 0) {
      // 1. Hitung Volume: (1/3) * Luas Alas * Tinggi
      double volume = (1 / 3) * (sisi * sisi) * tinggi;

      // 2. Hitung Luas Permukaan
      // Cari tinggi miring segitiga selimut pakai Pythagoras
      // Setengah sisi alas = sisi / 2
      double setengahSisi = sisi / 2;
      double tinggiMiring = sqrt(
        (setengahSisi * setengahSisi) + (tinggi * tinggi),
      );

      // Luas alas = s * s
      double luasAlas = sisi * sisi;
      // Luas 1 sisi tegak (segitiga) = 1/2 * alas * tinggi miring
      double luasSegitiga = 0.5 * sisi * tinggiMiring;
      // Total Luas Permukaan = Luas alas + (4 * Luas Segitiga)
      double luasPermukaan = luasAlas + (4 * luasSegitiga);

      setState(() {
        _hasilVolume = volume.toStringAsFixed(
          2,
        ); // Dibulatkan 2 angka di belakang koma
        _hasilLuas = luasPermukaan.toStringAsFixed(2);
      });
    } else {
      // Tampilkan error jika input tidak valid
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Masukkan angka yang valid dan lebih dari 0'),
        ),
      );
    }
  }

  @override
  void dispose() {
    // Bersihkan controller saat screen ditutup 
    _sisiAlasController.dispose();
    _tinggiController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Hitung Piramid'),
        backgroundColor: Colors.blue, 
        foregroundColor: Colors.white,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Text(
              'Masukkan Data Piramida (Alas Persegi)',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 20),
            TextField(
              controller: _sisiAlasController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                labelText: 'Panjang Sisi Alas',
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.straighten),
              ),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: _tinggiController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                labelText: 'Tinggi Piramida',
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.height),
              ),
            ),
            const SizedBox(height: 24),
            ElevatedButton(
              onPressed: _hitungPiramid,
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue,
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(vertical: 16),
              ),
              child: const Text('HITUNG', style: TextStyle(fontSize: 16)),
            ),
            const SizedBox(height: 32),
            Card(
              elevation: 4,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    const Text(
                      'Hasil Perhitungan:',
                      style: TextStyle(fontSize: 16),
                    ),
                    const SizedBox(height: 12),
                    Text(
                      'Volume: $_hasilVolume',
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.blue,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'Luas Permukaan: $_hasilLuas',
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.green,
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
