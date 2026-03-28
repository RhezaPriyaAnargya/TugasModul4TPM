import 'package:flutter/material.dart';

class CekWetonScreen extends StatefulWidget {
  @override
  _CekWetonScreenState createState() => _CekWetonScreenState();
}

class _CekWetonScreenState extends State<CekWetonScreen> {
  final TextEditingController _tanggalController = TextEditingController();
  final TextEditingController _bulanController = TextEditingController();
  final TextEditingController _tahunController = TextEditingController();

  String _hasilHariWeton = '';
  bool _sudahDihitung = false;

  void _hitungWeton() {
    int? tgl = int.tryParse(_tanggalController.text);
    int? bln = int.tryParse(_bulanController.text);
    int? thn = int.tryParse(_tahunController.text);

    if (tgl != null && bln != null && thn != null) {
      DateTime inputTanggal = DateTime.utc(thn, bln, tgl);

      if (inputTanggal.year == thn &&
          inputTanggal.month == bln &&
          inputTanggal.day == tgl) {
        List<String> namaHari = [
          'Senin',
          'Selasa',
          'Rabu',
          'Kamis',
          'Jumat',
          'Sabtu',
          'Minggu',
        ];

        List<String> pasaran = ['Legi', 'Pahing', 'Pon', 'Wage', 'Kliwon'];

        DateTime tanggalAcuan = DateTime.utc(1945, 8, 17);

        int selisihHari = inputTanggal.difference(tanggalAcuan).inDays;


        String hari = namaHari[inputTanggal.weekday - 1];


        int indexPasaran = selisihHari % 5;
        if (indexPasaran < 0) {
          indexPasaran +=
              5; 
        }

        String weton = pasaran[indexPasaran];

        setState(() {
          _hasilHariWeton = '$hari $weton';
          _sudahDihitung = true;
        });
      } else {
        setState(() {
          _hasilHariWeton = 'Tanggal Tidak Valid';
          _sudahDihitung = true;
        });
      }
    } else {
      setState(() {
        _hasilHariWeton = 'Harap isi semua kolom';
        _sudahDihitung = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        title: Text(
          'Cek Hari & Weton',
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
                    Icon(Icons.calendar_today, size: 60, color: Colors.blue),
                    SizedBox(height: 16),
                    Text(
                      'Masukkan Tanggal Kelahiran/Acara',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.blue[800],
                      ),
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(height: 16),


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
                        SizedBox(width: 10),
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
                        SizedBox(width: 10),
                        Expanded(
                          flex:
                              2, 
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
                    SizedBox(height: 20),

                    SizedBox(
                      width: double.infinity,
                      height: 50,
                      child: ElevatedButton(
                        onPressed: _hitungWeton,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.blue,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                        child: Text(
                          'Cek Weton',
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
                color:
                    (_hasilHariWeton.contains('Valid') ||
                        _hasilHariWeton.contains('isi'))
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
                        'Hasil Pengecekan:',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.blue[800],
                        ),
                      ),
                      SizedBox(height: 10),
                      Text(
                        _hasilHariWeton,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize:
                              (_hasilHariWeton.contains('Valid') ||
                                  _hasilHariWeton.contains('isi'))
                              ? 20
                              : 32,
                          fontWeight: FontWeight.bold,
                          color:
                              (_hasilHariWeton.contains('Valid') ||
                                  _hasilHariWeton.contains('isi'))
                              ? Colors.red[800]
                              : Colors.blue[900],
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
