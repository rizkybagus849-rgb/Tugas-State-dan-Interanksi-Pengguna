import 'package:flutter/material.dart';

import '../models/mata_kuliah.dart';
import '../widgets/matkul_tile.dart';
import '../widgets/ringkasan_sks.dart';

// STATEFUL WIDGET: halaman KRS (punya state yang berubah)
class KrsPage extends StatefulWidget {
  const KrsPage({super.key});

  @override
  State<KrsPage> createState() => _KrsPageState();
}

class _KrsPageState extends State<KrsPage> {
  // ---------- STATE ----------
  static const int _batasSks = 24;
  final Set<String> _dipilih = {}; // kode matkul yang dipilih
  String _kataKunci = ''; // teks pencarian
  bool _sudahDiajukan = false; // status pengajuan KRS

  // ---------- DATA TURUNAN DARI STATE ----------
  int get _totalSks => daftarMataKuliah
      .where((m) => _dipilih.contains(m.kode))
      .fold(0, (jumlah, m) => jumlah + m.sks);

  List<MataKuliah> get _hasilFilter {
    final q = _kataKunci.toLowerCase();
    return daftarMataKuliah
        .where((m) =>
            m.nama.toLowerCase().contains(q) ||
            m.kode.toLowerCase().contains(q))
        .toList();
  }

  // ---------- CALLBACK / EVENT HANDLER ----------
  void _pilihMatkul(MataKuliah m, bool dipilih) {
    // Validasi: tidak boleh melebihi batas SKS
    if (dipilih && _totalSks + m.sks > _batasSks) {
      _tampilkanPesan('Batas maksimal $_batasSks SKS terlampaui!', error: true);
      return;
    }
    setState(() {
      if (dipilih) {
        _dipilih.add(m.kode);
      } else {
        _dipilih.remove(m.kode);
      }
    });
  }

  Future<void> _ajukanKrs() async {
    final setuju = await showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Konfirmasi KRS'),
        content: Text(
            'Anda memilih ${_dipilih.length} mata kuliah dengan total $_totalSks SKS.\n\nAjukan KRS sekarang?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx, false),
            child: const Text('Batal'),
          ),
          FilledButton(
            onPressed: () => Navigator.pop(ctx, true),
            child: const Text('Ya, Ajukan'),
          ),
        ],
      ),
    );

    if (setuju == true && mounted) {
      setState(() => _sudahDiajukan = true);
      _tampilkanPesan('KRS berhasil diajukan! Menunggu persetujuan dosen wali.');
    }
  }

  void _ubahKrs() {
    setState(() => _sudahDiajukan = false);
    _tampilkanPesan('KRS dibuka kembali untuk diubah.');
  }

  void _resetPilihan() {
    setState(() {
      _dipilih.clear();
      _sudahDiajukan = false;
    });
  }

  void _tampilkanPesan(String pesan, {bool error = false}) {
    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(
        SnackBar(
          content: Text(pesan),
          backgroundColor: error ? Colors.red.shade700 : Colors.green.shade700,
        ),
      );
  }

  // ---------- TAMPILAN ----------
  @override
  Widget build(BuildContext context) {
    final daftar = _hasilFilter;

    return Scaffold(
      appBar: AppBar(
        title: const Text('SIAKAD Mini - KRS Online'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        actions: [
          IconButton(
            tooltip: 'Reset pilihan',
            icon: const Icon(Icons.refresh),
            onPressed: _dipilih.isEmpty ? null : _resetPilihan,
          ),
        ],
      ),
      body: Column(
        children: [
          RingkasanSks(totalSks: _totalSks, batasSks: _batasSks),

          // Input pengguna: pencarian (onChanged + setState)
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 8, 16, 8),
            child: TextField(
              onChanged: (value) => setState(() => _kataKunci = value),
              decoration: const InputDecoration(
                labelText: 'Cari mata kuliah / kode',
                prefixIcon: Icon(Icons.search),
                border: OutlineInputBorder(),
              ),
            ),
          ),

          // Daftar mata kuliah
          Expanded(
            child: daftar.isEmpty
                ? const Center(child: Text('Mata kuliah tidak ditemukan'))
                : ListView.builder(
                    itemCount: daftar.length,
                    itemBuilder: (context, index) {
                      final m = daftar[index];
                      return MatkulTile(
                        matkul: m,
                        dipilih: _dipilih.contains(m.kode),
                        terkunci: _sudahDiajukan,
                        onChanged: (val) => _pilihMatkul(m, val ?? false),
                      );
                    },
                  ),
          ),

          // Tombol aksi
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: SizedBox(
                width: double.infinity,
                height: 48,
                child: _sudahDiajukan
                    ? OutlinedButton.icon(
                        onPressed: _ubahKrs,
                        icon: const Icon(Icons.edit),
                        label: const Text('Ubah KRS'),
                      )
                    : FilledButton.icon(
                        onPressed: _dipilih.isEmpty ? null : _ajukanKrs,
                        icon: const Icon(Icons.send),
                        label: Text('Ajukan KRS ($_totalSks SKS)'),
                      ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
