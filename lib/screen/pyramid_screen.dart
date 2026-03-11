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
  
  // State baru untuk menyimpan detail rumus/langkah perhitungan
  String _detailVolume = "";
  String _detailLuas = "";

  // Fungsi untuk menghitung
  void _hitungPiramid() {
    double sisi = double.tryParse(_sisiAlasController.text) ?? 0.0;
    double tinggi = double.tryParse(_tinggiController.text) ?? 0.0;

    if (sisi > 0 && tinggi > 0) {
      // 1. Hitung Volume
      double luasAlas = sisi * sisi;
      double volume = (1 / 3) * luasAlas * tinggi;

      // 2. Hitung Luas Permukaan
      double setengahSisi = sisi / 2;
      double tinggiMiring = sqrt((setengahSisi * setengahSisi) + (tinggi * tinggi));
      double luasSegitiga = 0.5 * sisi * tinggiMiring;
      double totalLuasSisiTegak = 4 * luasSegitiga;
      double luasPermukaan = luasAlas + totalLuasSisiTegak;

      setState(() {
        _hasilVolume = volume.toStringAsFixed(2);
        _hasilLuas = luasPermukaan.toStringAsFixed(2);

        // Menyusun string detail perhitungan Volume
        _detailVolume = "Volume = ⅓ × Luas Alas × Tinggi\n"
            "V = ⅓ × (s × s) × t\n"
            "V = ⅓ × ($sisi × $sisi) × $tinggi\n"
            "V = ⅓ × $luasAlas × $tinggi\n"
            "V = $_hasilVolume";

        // Menyusun string detail perhitungan Luas Permukaan
        _detailLuas = "1. Cari Tinggi Miring (Tegak) Segitiga:\n"
            "   tm = √((½ × s)² + t²)\n"
            "   tm = √((½ × $sisi)² + $tinggi²)\n"
            "   tm = √(${setengahSisi * setengahSisi} + ${tinggi * tinggi})\n"
            "   tm = ${tinggiMiring.toStringAsFixed(2)}\n\n"
            "2. Luas Alas (Persegi):\n"
            "   La = s × s = $sisi × $sisi = $luasAlas\n\n"
            "3. Luas 4 Sisi Tegak (Segitiga):\n"
            "   Ls = 4 × (½ × a × tm)\n"
            "   Ls = 4 × (½ × $sisi × ${tinggiMiring.toStringAsFixed(2)})\n"
            "   Ls = 4 × ${luasSegitiga.toStringAsFixed(2)} = ${totalLuasSisiTegak.toStringAsFixed(2)}\n\n"
            "4. Total Luas Permukaan:\n"
            "   L = La + Ls\n"
            "   L = $luasAlas + ${totalLuasSisiTegak.toStringAsFixed(2)}\n"
            "   L = $_hasilLuas";
      });
    } else {
      // Tampilkan error jika input tidak valid
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Masukkan angka yang valid dan lebih dari 0', style: TextStyle(color: Colors.white)),
          backgroundColor: Colors.redAccent,
        ),
      );
    }
  }

  @override
  void dispose() {
    _sisiAlasController.dispose();
    _tinggiController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Hitung Piramid', style: TextStyle(fontWeight: FontWeight.bold)),
        backgroundColor: Colors.blue.shade800, 
        foregroundColor: Colors.white,
        elevation: 0,
      ),
      backgroundColor: Colors.grey.shade100,
      body: SingleChildScrollView( 
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.05),
                    blurRadius: 10,
                    offset: const Offset(0, 5),
                  ),
                ],
              ),
              child: Column(
                children: [
                  const Text(
                    'Data Piramida (Alas Persegi)',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.black87),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 20),
                  TextField(
                    controller: _sisiAlasController,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      labelText: 'Panjang Sisi Alas (s)',
                      filled: true,
                      fillColor: Colors.blue.shade50,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide.none,
                      ),
                      prefixIcon: Icon(Icons.straighten, color: Colors.blue.shade700),
                    ),
                  ),
                  const SizedBox(height: 16),
                  TextField(
                    controller: _tinggiController,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      labelText: 'Tinggi Piramida (t)',
                      filled: true,
                      fillColor: Colors.blue.shade50,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide.none,
                      ),
                      prefixIcon: Icon(Icons.height, color: Colors.blue.shade700),
                    ),
                  ),
                  const SizedBox(height: 32),
                  
             
                  Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [Colors.blue.shade800, Colors.blue.shade500],
                        begin: Alignment.centerLeft,
                        end: Alignment.centerRight,
                      ),
                      borderRadius: BorderRadius.circular(16),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.blue.withOpacity(0.4),
                          blurRadius: 12,
                          offset: const Offset(0, 6),
                        ),
                      ],
                    ),
                    child: ElevatedButton.icon(
                      onPressed: _hitungPiramid,
                      icon: const Icon(Icons.calculate_rounded, size: 24),
                      label: const Text(
                        'HITUNG SEKARANG',
                        style: TextStyle(
                          fontSize: 16, 
                          fontWeight: FontWeight.bold, 
                          letterSpacing: 1.5,
                        ),
                      ),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.transparent,
                        foregroundColor: Colors.white,
                        shadowColor: Colors.transparent, 
                        padding: const EdgeInsets.symmetric(vertical: 18),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            
            const SizedBox(height: 24),
            
            // Menampilkan Card Hasil hanya jika sudah ada perhitungan
            if (_detailVolume.isNotEmpty)
              Card(
                elevation: 4,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Center(
                        child: Text(
                          'Hasil & Detail Perhitungan',
                          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                      ),
                      const Divider(height: 30, thickness: 1.5),
                      
                      // Bagian Volume
                      Row(
                        children: [
                          Icon(Icons.view_in_ar, color: Colors.blue.shade700),
                          const SizedBox(width: 8),
                          Text(
                            'Volume: $_hasilVolume',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Colors.blue.shade800,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 12),
                      Container(
                        width: double.infinity,
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          color: Colors.grey.shade100,
                          borderRadius: BorderRadius.circular(8),
                          border: Border.all(color: Colors.grey.shade300),
                        ),
                        child: Text(
                          _detailVolume,
                          style: const TextStyle(fontSize: 14, fontFamily: 'monospace', height: 1.5),
                        ),
                      ),
                      
                      const SizedBox(height: 24),
                      
                      // Bagian Luas Permukaan
                      Row(
                        children: [
                          Icon(Icons.layers, color: Colors.green.shade700),
                          const SizedBox(width: 8),
                          Text(
                            'Luas: $_hasilLuas',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Colors.green.shade800,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 12),
                      Container(
                        width: double.infinity,
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          color: Colors.grey.shade100,
                          borderRadius: BorderRadius.circular(8),
                          border: Border.all(color: Colors.grey.shade300),
                        ),
                        child: Text(
                          _detailLuas,
                          style: const TextStyle(fontSize: 14, fontFamily: 'monospace', height: 1.5),
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
