import 'package:flutter/material.dart';
import 'pyramid_screen.dart'; // Pastikan file ini ada di folder yang sama

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Menu Utama'),
        backgroundColor: Colors.blue, // Tema warna biru
        foregroundColor: Colors.white,
      ),
      // Menggunakan SingleChildScrollView agar layar bisa di-scroll jika menu terlalu banyak
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch, // Membuat tombol memanjang penuh
            children: [
              const Text(
                'Pilih Menu:',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 30),

              // 1. Tombol Data Kelompok
              ElevatedButton(
                onPressed: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Menu Data Kelompok belum dibuat')),
                  );
                },
                style: ElevatedButton.styleFrom(padding: const EdgeInsets.all(16)),
                child: const Text('1. Data Kelompok', style: TextStyle(fontSize: 16)),
              ),
              const SizedBox(height: 16), // Jarak antar tombol

              // 2. Tombol Penjumlahan & Pengurangan
              ElevatedButton(
                onPressed: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Menu Kalkulator belum dibuat')),
                  );
                },
                style: ElevatedButton.styleFrom(padding: const EdgeInsets.all(16)),
                child: const Text('2. Penjumlahan & Pengurangan', style: TextStyle(fontSize: 16)),
              ),
              const SizedBox(height: 16),

              // 3. Tombol Ganjil Genap & Prima
              ElevatedButton(
                onPressed: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Menu Ganjil Genap belum dibuat')),
                  );
                },
                style: ElevatedButton.styleFrom(padding: const EdgeInsets.all(16)),
                child: const Text('3. Ganjil Genap & Prima', style: TextStyle(fontSize: 16)),
              ),
              const SizedBox(height: 16),

              // 4. Tombol Jumlah Total Angka
              ElevatedButton(
                onPressed: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Menu Total Angka belum dibuat')),
                  );
                },
                style: ElevatedButton.styleFrom(padding: const EdgeInsets.all(16)),
                child: const Text('4. Jumlah Total Angka Input', style: TextStyle(fontSize: 16)),
              ),
              const SizedBox(height: 16),

              // 5. Tombol Stopwatch
              ElevatedButton(
                onPressed: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Menu Stopwatch belum dibuat')),
                  );
                },
                style: ElevatedButton.styleFrom(padding: const EdgeInsets.all(16)),
                child: const Text('5. Stopwatch', style: TextStyle(fontSize: 16)),
              ),
              const SizedBox(height: 16),

              // 6. Tombol Hitung Piramid (Yang sudah disambungkan ke file pyramid_screen.dart)
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const PyramidScreen()),
                  );
                },
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.all(16),
                  backgroundColor: Colors.blue[800], // Warnanya sedikit lebih gelap agar beda
                  foregroundColor: Colors.white,
                ),
                child: const Text('6. Hitung Luas & Volume Piramid', style: TextStyle(fontSize: 16)),
              ),
            ],
          ),
        ),
      ),
    );
  }
}