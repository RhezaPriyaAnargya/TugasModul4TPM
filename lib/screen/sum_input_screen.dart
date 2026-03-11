import 'package:flutter/material.dart';

class JumlahTotalAngkaScreen extends StatefulWidget {
  @override
  _JumlahTotalAngkaScreenState createState() => _JumlahTotalAngkaScreenState();
}

class _JumlahTotalAngkaScreenState extends State<JumlahTotalAngkaScreen> {
  final TextEditingController _deretAngkaController = TextEditingController();
  int _totalJumlah = 0;
  bool _sudahDihitung =
      false; // Tambahan untuk menyembunyikan kotak hasil sebelum tombol ditekan

  // Fungsi hitung total (Logika Tetap Sama)
  void _hitungTotal() {
    String input = _deretAngkaController.text;

    // Memisahkan input berdasarkan spasi atau koma
    List<String> listAngkaString = input.split(RegExp(r'[\s,]+'));

    int sementaraTotal = 0;

    for (String angkaStr in listAngkaString) {
      int? angka = int.tryParse(angkaStr);
      if (angka != null) {
        sementaraTotal += angka;
      }
    }

    setState(() {
      _totalJumlah = sementaraTotal;
      _sudahDihitung = true; // Tandai bahwa perhitungan sudah dilakukan
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:
          Colors.grey[100], // Background senada dengan halaman pertama
      appBar: AppBar(
        title: Text(
          'Jumlah Total Angka',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        backgroundColor: Colors.blue, // Tema warna biru
        foregroundColor: Colors.white,
        elevation: 0,
      ),
      body: SingleChildScrollView(
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
                      Icons.functions,
                      size: 60,
                      color: Colors.blue,
                    ), // Ikon Sigma/Matematika
                    SizedBox(height: 16),
                    TextField(
                      controller: _deretAngkaController,
                      keyboardType: TextInputType.text,
                      decoration: InputDecoration(
                        labelText: 'Masukkan deret angka',
                        hintText: 'Contoh: 10, 20, 30',
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

            // Bagian Hasil (Hanya muncul jika tombol sudah ditekan)
            if (_sudahDihitung)
              Card(
                color: Colors.blue[50], // Biru muda
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
                            '$_totalJumlah',
                            style: TextStyle(
                              fontSize: 24, // Dibuat lebih besar agar menonjol
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
