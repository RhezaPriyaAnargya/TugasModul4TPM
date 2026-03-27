import 'package:flutter/material.dart';
import 'package:decimal/decimal.dart';

class CalculatorScreen extends StatefulWidget {
  const CalculatorScreen({super.key});

  @override
  State<CalculatorScreen> createState() => _CalculatorScreenState();
}

class _CalculatorScreenState extends State<CalculatorScreen> {
  // Controller untuk mengambil angka dari input teks
  final TextEditingController _angka1Controller = TextEditingController();
  final TextEditingController _angka2Controller = TextEditingController();

  Decimal _hasil = Decimal.zero;
  String _errorMessage = '';
  bool _sudahDihitung = false;

  void _hitung(String operasi) {
    final String input1 = _angka1Controller.text.trim();
    final String input2 = _angka2Controller.text.trim();

    if (input1.isEmpty || input2.isEmpty) {
      setState(() {
        _errorMessage = 'Silakan masukkan kedua angka';
        _sudahDihitung = false;
      });
      return;
    }

    final (Decimal? angka1, String? error1) = _parseDecimal(input1);
    if (error1 != null) {
      setState(() {
        _errorMessage = error1;
        _sudahDihitung = false;
      });
      return;
    }

    final (Decimal? angka2, String? error2) = _parseDecimal(input2);
    if (error2 != null) {
      setState(() {
        _errorMessage = error2;
        _sudahDihitung = false;
      });
      return;
    }

    if (angka1 == null || angka2 == null) {
      setState(() {
        _errorMessage = 'Masukkan angka yang valid';
        _sudahDihitung = false;
      });
      return;
    }

    Decimal hasilHitung = Decimal.zero;

    if (operasi == 'tambah') {
      hasilHitung = angka1 + angka2;
    } else if (operasi == 'kurang') {
      hasilHitung = angka1 - angka2;
    }

    setState(() {
      _errorMessage = '';
      _hasil = hasilHitung;
      _sudahDihitung = true;
    });
  }

  (Decimal?, String?) _parseDecimal(String nilai) {
    final String cleaned = nilai.trim();
    if (cleaned.isEmpty) {
      return (null, null);
    }

    try {
      final Decimal parsed = Decimal.parse(cleaned);

      // Validasi: maksimal 15 digit (tanpa titik desimal)
      final String digitsOnly = cleaned.replaceAll(RegExp(r'[^0-9]'), '');
      if (digitsOnly.length > 15) {
        return (null, 'Angka "$cleaned" terlalu besar (maks 15 digit)');
      }

      return (parsed, null);
    } catch (_) {
      return (null, 'Angka "$cleaned" tidak valid');
    }
  }

  String _formatHasil(Decimal nilai) {
    return _normalizeDecimalString(nilai.toString());
  }

  String _normalizeDecimalString(String value) {
    if (!value.contains('.')) {
      return value;
    }

    final String trimmed = value
        .replaceFirst(RegExp(r'0+$'), '')
        .replaceFirst(RegExp(r'\.$'), '');
    return trimmed.isEmpty || trimmed == '-' ? '0' : trimmed;
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

            if (_errorMessage.isEmpty && _sudahDihitung)
              const SizedBox(height: 40),

            if (_sudahDihitung)
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
                        _formatHasil(_hasil),
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