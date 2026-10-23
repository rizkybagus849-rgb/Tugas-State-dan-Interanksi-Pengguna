import 'package:flutter/material.dart';

// Widget anak (stateless): menerima data dari induk
class RingkasanSks extends StatelessWidget {
  final int totalSks;
  final int batasSks;

  const RingkasanSks({
    super.key,
    required this.totalSks,
    required this.batasSks,
  });

  @override
  Widget build(BuildContext context) {
    final rasio = totalSks / batasSks;
    final Color warna = rasio < 0.7
        ? Colors.green
        : (rasio < 1.0 ? Colors.orange : Colors.red);

    return Card(
      margin: const EdgeInsets.all(16),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Ahmad Fauzi  |  NIM 2301010123',
                style: TextStyle(fontWeight: FontWeight.bold)),
            const Text('Teknik Informatika - Semester 5'),
            const SizedBox(height: 12),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text('Total SKS dipilih'),
                Text('$totalSks / $batasSks',
                    style: TextStyle(
                        fontWeight: FontWeight.bold, color: warna)),
              ],
            ),
            const SizedBox(height: 8),
            // Animasi: progress bar berubah halus saat state berubah
            TweenAnimationBuilder<double>(
              tween: Tween(begin: 0, end: rasio.clamp(0.0, 1.0)),
              duration: const Duration(milliseconds: 500),
              curve: Curves.easeInOut,
              builder: (context, nilai, _) => LinearProgressIndicator(
                value: nilai,
                minHeight: 10,
                color: warna,
                backgroundColor: Colors.grey.shade300,
                borderRadius: BorderRadius.circular(8),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
