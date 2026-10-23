import 'package:flutter/material.dart';

import '../models/mata_kuliah.dart';

class MatkulTile extends StatelessWidget {
  final MataKuliah matkul;
  final bool dipilih;
  final bool terkunci;
  final ValueChanged<bool?> onChanged; // fungsi callback dari induk

  const MatkulTile({
    super.key,
    required this.matkul,
    required this.dipilih,
    required this.terkunci,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
      decoration: BoxDecoration(
        color: dipilih ? Colors.indigo.shade50 : Colors.white,
        border: Border.all(
            color: dipilih ? Colors.indigo : Colors.grey.shade300),
        borderRadius: BorderRadius.circular(12),
      ),
      child: CheckboxListTile(
        value: dipilih,
        onChanged: terkunci ? null : onChanged,
        title: Text('${matkul.kode} - ${matkul.nama}'),
        subtitle: Text('${matkul.sks} SKS  •  ${matkul.dosen}'),
        controlAffinity: ListTileControlAffinity.leading,
      ),
    );
  }
}
