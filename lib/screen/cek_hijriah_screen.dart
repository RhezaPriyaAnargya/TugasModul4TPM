import 'package:flutter/material.dart';

class CekHijriahScreen extends StatefulWidget {
  const CekHijriahScreen({super.key});

  @override
  _CekHijriahScreenState createState() => _CekHijriahScreenState();
}

class _CekHijriahScreenState extends State<CekHijriahScreen> {
  final TextEditingController _tanggalController = TextEditingController();
  final TextEditingController _bulanController = TextEditingController();
  final TextEditingController _tahunController = TextEditingController();

  String _hasilHijriah = '';
  bool _sudahDihitung = false;

  // Algoritma Tabular Islamic Calendar (Kuwaiti Algorithm) murni tanpa package
  String _konversiMasehiKeHijriah(int tgl, int bln, int thn) {
    int m = bln;
    int y = thn;

    if (m < 3) {
      y -= 1;
      m += 12;
    }

    int a = (y / 100).floor();
    int b = 2 - a + (a / 4).floor();
    if (y < 1583) b = 0;
    if (y == 1582) {
      if (m > 10) b = -10;
      if (m == 10) {
        b = 0;
        if (tgl > 4) b = -10;
      }
    }

    // Perhitungan Julian Day
    int jd =
        (365.25 * (y + 4716)).floor() +
        (30.6001 * (m + 1)).floor() +
        tgl +
        b -
        1524;

    double iyear = 10631.0 / 30.0;
    int epochastro = 1948084;
    double shift1 = 8.01 / 60.0;

    double z = (jd - epochastro).toDouble();
    int cyc = (z / 10631.0).floor();
    z = z - 10631 * cyc;
    int j = ((z - shift1) / iyear).floor();
    int iy = 30 * cyc + j;
    z = z - (j * iyear + shift1).floor();
    int im = ((z + 28.5001) / 29.5).floor();
    if (im == 13) im = 12;
    int id = (z - (29.5001 * im - 29).floor()).round();

    List<String> bulanHijriah = [
      "Muharram",
      "Safar",
      "Rabi'ul Awal",
      "Rabi'ul Akhir",
      "Jumadil Awal",
      "Jumadil Akhir",
      "Rajab",
      "Sya'ban",
      "Ramadhan",
      "Syawal",
      "Dzulqa'dah",
      "Dzulhijjah",
    ];

    return "$id ${bulanHijriah[im - 1]} $iy H";
  }

  void _hitung() {
    int? tgl = int.tryParse(_tanggalController.text);
    int? bln = int.tryParse(_bulanController.text);
    int? thn = int.tryParse(_tahunController.text);

    if (tgl != null && bln != null && thn != null) {
      // Validasi penanggalan masehi sederhana
      DateTime inputTanggal = DateTime.utc(thn, bln, tgl);
      if (inputTanggal.year == thn &&
          inputTanggal.month == bln &&
          inputTanggal.day == tgl) {
        setState(() {
          _hasilHijriah = _konversiMasehiKeHijriah(tgl, bln, thn);
          _sudahDihitung = true;
        });
      } else {
        setState(() {
          _hasilHijriah = 'Tanggal Masehi Tidak Valid';
          _sudahDihitung = true;
        });
      }
    } else {
      setState(() {
        _hasilHijriah = 'Harap isi semua kolom';
        _sudahDihitung = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        title: const Text(
          'Konversi Hijriah',
          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
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
                    const Icon(
                      Icons.nights_stay_rounded,
                      size: 60,
                      color: Colors.blue,
                    ),
                    const SizedBox(height: 16),
                    Text(
                      'Masukkan Tanggal Masehi',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.blue[800],
                      ),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 16),

                    Row(
                      children: [
                        Expanded(
                          child: TextField(
                            controller: _tanggalController,
                            keyboardType: TextInputType.number,
                            textAlign: TextAlign.center,
                            decoration: InputDecoration(
                              labelText: 'Tgl',
                              hintText: '17',
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(width: 10),
                        Expanded(
                          child: TextField(
                            controller: _bulanController,
                            keyboardType: TextInputType.number,
                            textAlign: TextAlign.center,
                            decoration: InputDecoration(
                              labelText: 'Bln',
                              hintText: '8',
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(width: 10),
                        Expanded(
                          flex: 2,
                          child: TextField(
                            controller: _tahunController,
                            keyboardType: TextInputType.number,
                            textAlign: TextAlign.center,
                            decoration: InputDecoration(
                              labelText: 'Tahun',
                              hintText: '1945',
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),

                    SizedBox(
                      width: double.infinity,
                      height: 50,
                      child: ElevatedButton(
                        onPressed: _hitung,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.blue,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                        child: const Text(
                          'Konversi ke Hijriah',
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
            const SizedBox(height: 24),

            if (_sudahDihitung)
              Card(
                color:
                    (_hasilHijriah.contains('Valid') ||
                        _hasilHijriah.contains('isi'))
                    ? Colors.red[50]
                    : Colors.blue[50],
                elevation: 2,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    vertical: 30.0,
                    horizontal: 20.0,
                  ),
                  child: Column(
                    children: [
                      Text(
                        'Tanggal Hijriah:',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.blue[800],
                        ),
                      ),
                      const SizedBox(height: 10),
                      Text(
                        _hasilHijriah,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize:
                              (_hasilHijriah.contains('Valid') ||
                                  _hasilHijriah.contains('isi'))
                              ? 20
                              : 30,
                          fontWeight: FontWeight.bold,
                          color:
                              (_hasilHijriah.contains('Valid') ||
                                  _hasilHijriah.contains('isi'))
                              ? Colors.red[800]
                              : Colors.blue[900],
                        ),
                      ),
                      if (!_hasilHijriah.contains('Valid') &&
                          !_hasilHijriah.contains('isi')) ...[
                        const SizedBox(height: 15),
                        const Text(
                          '*Catatan: Hasil perhitungan ini berbasis algoritma tabular matematika. Dalam praktiknya, pergantian bulan Hijriah bisa selisih 1 hari tergantung pada visibilitas hilal (rukyatul hilal).',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 12,
                            color: Colors.grey,
                            fontStyle: FontStyle.italic,
                          ),
                        ),
                      ],
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
