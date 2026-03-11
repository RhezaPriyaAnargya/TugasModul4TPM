import 'package:flutter/material.dart';

class CekBilanganScreen extends StatefulWidget {
  @override
  _CekBilanganScreenState createState() => _CekBilanganScreenState();
}

class _CekBilanganScreenState extends State<CekBilanganScreen> {
  final TextEditingController _angkaController = TextEditingController();
  String _hasilGanjilGenap = '';
  String _hasilPrima = '';

  // Fungsi cek prima (Logika Tetap Sama)
  bool isPrima(int n) {
    if (n <= 1) return false;
    for (int i = 2; i * i <= n; i++) {
      if (n % i == 0) return false;
    }
    return true;
  }

  void _cekBilangan() {
    int? angka = int.tryParse(_angkaController.text);

    if (angka != null) {
      setState(() {
        // Cek Ganjil Genap
        _hasilGanjilGenap = (angka % 2 == 0) ? 'Genap' : 'Ganjil';

        // Cek Prima
        _hasilPrima = isPrima(angka)
            ? 'Bilangan Prima'
            : 'Bukan Bilangan Prima';
      });
    } else {
      setState(() {
        _hasilGanjilGenap = 'Input tidak valid';
        _hasilPrima = '-';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:
          Colors.grey[100], // Warna background agak abu-abu agar Card terlihat
      appBar: AppBar(
        title: Text(
          'Cek Bilangan',
          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
        ),
        centerTitle: true,
        backgroundColor: Colors.blue, // Diubah ke Biru
        foregroundColor: Colors.white,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        // Mencegah error overflow saat keyboard muncul
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            // Bagian Input
            Card(
              elevation: 4,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15),
              ),
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  children: [
                    Icon(
                      Icons.calculate,
                      size: 60,
                      color: Colors.blue,
                    ), // Diubah ke Biru
                    SizedBox(height: 16),
                    TextField(
                      controller: _angkaController,
                      keyboardType: TextInputType.number,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                      decoration: InputDecoration(
                        labelText:
                            'Masukkan Sebuah Angka', // Ditambahkan warna biru
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: BorderSide(
                            color: Colors.blue,
                            width: 2,
                          ), // Diubah ke Biru
                        ),
                      ),
                    ),
                    SizedBox(height: 20),
                    SizedBox(
                      width: double.infinity, // Tombol memenuhi lebar layar
                      height: 50,
                      child: ElevatedButton(
                        onPressed: _cekBilangan,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.blue, // Diubah ke Biru
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                        child: Text(
                          'Cek Angka',
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

            // Bagian Hasil (Hanya muncul jika sudah ada hasil)
            if (_hasilGanjilGenap.isNotEmpty)
              Card(
                color: Colors.blue[50], // Diubah ke Biru muda
                elevation: 2,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    children: [
                      Text(
                        'Hasil Pengecekan',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.blue[800],
                        ), // Diubah ke Biru tua
                      ),
                      Divider(
                        color: Colors.blue[200],
                        thickness: 1.5,
                      ), // Diubah ke Biru
                      SizedBox(height: 10),

                      // Baris Ganjil/Genap
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Jenis Bilangan:',
                            style: TextStyle(fontSize: 16),
                          ),
                          Text(
                            _hasilGanjilGenap,
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: _hasilGanjilGenap == 'Input tidak valid'
                                  ? Colors.red
                                  : Colors
                                        .blue[900], // Diubah ke Biru sangat tua
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 12),

                      // Baris Prima
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text('Status Prima:', style: TextStyle(fontSize: 16)),
                          Text(
                            _hasilPrima,
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              // Tetap menggunakan hijau/oranye untuk status prima agar kontras,
                              // tapi Anda bisa mengubahnya jika ingin full biru.
                              color: _hasilPrima == 'Bilangan Prima'
                                  ? Colors.green[700]
                                  : Colors.orange[800],
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
