import 'package:flutter/material.dart';

class CekTanggalLahirScreen extends StatefulWidget {
  const CekTanggalLahirScreen({super.key});

  @override
  State<CekTanggalLahirScreen> createState() => _CekTanggalLahirScreenState();
}

class _CekTanggalLahirScreenState extends State<CekTanggalLahirScreen> {
  DateTime? _tanggalLahir;
  String _errorMessage = '';
  bool _sudahDihitung = false;

  late int _tahun;
  late int _bulan;
  late int _hari;
  late int _jam;
  late int _menit;

  @override
  void dispose() {
    super.dispose();
  }

  Future<void> _pilihTanggal() async {
    try {
      final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: DateTime(2000),
        firstDate: DateTime(1900),
        lastDate: DateTime.now(),
        builder: (context, child) {
          return Theme(
            data: Theme.of(context).copyWith(
              colorScheme: ColorScheme.light(
                primary: Colors.blue.shade700,
                onPrimary: Colors.white,
                surface: Colors.white,
                onSurface: Colors.black87,
              ),
            ),
            child: child!,
          );
        },
      );

      if (picked != null) {
        // Validasi tanggal yang dipilih
        if (picked.isAfter(DateTime.now())) {
          setState(() {
            _errorMessage = 'Tanggal tidak boleh di masa depan';
            _sudahDihitung = false;
          });
          return;
        }

        setState(() {
          _tanggalLahir = picked;
          _errorMessage = '';
          _sudahDihitung = false;
        });
      }
    } catch (e) {
      setState(() {
        _errorMessage = 'Terjadi kesalahan saat memilih tanggal: ${e.toString()}';
        _sudahDihitung = false;
      });
    }
  }

  void _hitungUmur() {
    try {
      // Validasi: tanggal lahir harus dipilih
      if (_tanggalLahir == null) {
        setState(() {
          _errorMessage = 'Silakan pilih tanggal lahir terlebih dahulu';
          _sudahDihitung = false;
        });
        return;
      }

      final DateTime sekarang = DateTime.now();

      // Validasi: tanggal lahir tidak boleh lebih besar dari sekarang
      if (_tanggalLahir!.isAfter(sekarang)) {
        setState(() {
          _errorMessage = 'Tanggal lahir tidak boleh lebih besar dari hari ini';
          _sudahDihitung = false;
        });
        return;
      }

      // Validasi: tanggal lahir tidak boleh terlalu jauh (tahun 1900)
      if (_tanggalLahir!.year < 1900) {
        setState(() {
          _errorMessage = 'Tanggal lahir tidak valid (tahun terlalu kecil)';
          _sudahDihitung = false;
        });
        return;
      }

      // Validasi: umur tidak boleh lebih dari 150 tahun (deteksi data aneh)
      final int umurTahun = sekarang.year - _tanggalLahir!.year;
      if (umurTahun > 150) {
        setState(() {
          _errorMessage = 'Tanggal lahir tidak valid (umur tidak masuk akal)';
          _sudahDihitung = false;
        });
        return;
      }

      // Hitung tahun
      _tahun = sekarang.year - _tanggalLahir!.year;
      _bulan = sekarang.month - _tanggalLahir!.month;
      _hari = sekarang.day - _tanggalLahir!.day;

      // Koreksi jika hari negatif
      if (_hari < 0) {
        _bulan--;
        final DateTime bulanSebelumnya = DateTime(sekarang.year, sekarang.month, 0);
        _hari += bulanSebelumnya.day;
      }

      // Koreksi jika bulan negatif
      if (_bulan < 0) {
        _tahun--;
        _bulan += 12;
      }

      // Validasi hasil perhitungan
      if (_tahun < 0 || _bulan < 0 || _hari < 0) {
        throw Exception('Perhitungan umur menghasilkan nilai negatif');
      }

      // Hitung jam dan menit
      final Duration selisih = sekarang.difference(_tanggalLahir!);
      if (selisih.isNegative) {
        throw Exception('Selisih waktu tidak valid');
      }

      _jam = selisih.inHours % 24;
      _menit = selisih.inMinutes % 60;

      setState(() {
        _errorMessage = '';
        _sudahDihitung = true;
      });
    } catch (e) {
      setState(() {
        _errorMessage = 'Terjadi kesalahan saat menghitung umur: ${e.toString()}';
        _sudahDihitung = false;
      });
    }
  }

  String _formatTanggal(DateTime tanggal) {
    try {
      final List<String> bulan = [
        'Januari',
        'Februari',
        'Maret',
        'April',
        'Mei',
        'Juni',
        'Juli',
        'Agustus',
        'September',
        'Oktober',
        'November',
        'Desember'
      ];

      // Validasi bulan
      if (tanggal.month < 1 || tanggal.month > 12) {
        throw Exception('Bulan tidak valid');
      }

      // Validasi hari
      if (tanggal.day < 1 || tanggal.day > 31) {
        throw Exception('Hari tidak valid');
      }

      return '${tanggal.day} ${bulan[tanggal.month - 1]} ${tanggal.year}';
    } catch (e) {
      return 'Tanggal tidak valid';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        title: const Text(
          'Cek Tanggal Lahir',
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
                    Icon(Icons.cake, size: 60, color: Colors.blue),
                    const SizedBox(height: 16),
                    const Text(
                      'Pilih Tanggal Lahir Anda',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.black87,
                      ),
                    ),
                    const SizedBox(height: 20),
                    GestureDetector(
                      onTap: _pilihTanggal,
                      child: Container(
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.blue, width: 2),
                          borderRadius: BorderRadius.circular(12),
                          color: Colors.blue[50],
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                Icon(Icons.calendar_today, color: Colors.blue),
                                const SizedBox(width: 12),
                                Text(
                                  _tanggalLahir == null
                                      ? 'Pilih Tanggal'
                                      : _formatTanggal(_tanggalLahir!),
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w500,
                                    color: _tanggalLahir == null
                                        ? Colors.grey
                                        : Colors.blue[900],
                                  ),
                                ),
                              ],
                            ),
                            Icon(Icons.arrow_drop_down, color: Colors.blue),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                    SizedBox(
                      width: double.infinity,
                      height: 50,
                      child: ElevatedButton(
                        onPressed: _hitungUmur,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.blue,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                        child: const Text(
                          'Hitung Umur',
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
            if (_errorMessage.isNotEmpty)
              Card(
                color: Colors.red[50],
                elevation: 2,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15),
                  side: BorderSide(color: Colors.red[300]!, width: 1),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Row(
                    children: [
                      Icon(Icons.error_outline, color: Colors.red[700], size: 24),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Text(
                          _errorMessage,
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.red[700],
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
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
                        'Umur Anda',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.blue[800],
                        ),
                      ),
                      const Divider(thickness: 1.5),
                      const SizedBox(height: 16),
                      _buildUmurItem('Tahun', _tahun, Colors.blue[700]!),
                      const SizedBox(height: 12),
                      _buildUmurItem('Bulan', _bulan, Colors.purple[600]!),
                      const SizedBox(height: 12),
                      _buildUmurItem('Hari', _hari, Colors.teal[600]!),
                      const SizedBox(height: 12),
                      _buildUmurItem('Jam', _jam, Colors.orange[600]!),
                      const SizedBox(height: 12),
                      _buildUmurItem('Menit', _menit, Colors.pink[600]!),
                      const SizedBox(height: 16),
                      Container(
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(color: Colors.blue[200]!, width: 1),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text(
                              'Total Usia:',
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            Text(
                              '$_tahun tahun, $_bulan bulan, $_hari hari',
                              style: const TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                                color: Colors.blue,
                              ),
                            ),
                          ],
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

  Widget _buildUmurItem(String label, int value, Color color) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: color.withOpacity(0.3), width: 1),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w500,
              color: Colors.black87,
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
            decoration: BoxDecoration(
              color: color.withOpacity(0.15),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Text(
              '$value',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: color,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
