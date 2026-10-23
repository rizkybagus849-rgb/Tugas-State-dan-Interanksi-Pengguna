import 'package:flutter/material.dart';

import 'pages/krs_page.dart';

void main() {
  runApp(const SiakadApp());
}

// STATELESS WIDGET: root aplikasi (tidak punya state yang berubah)
class SiakadApp extends StatelessWidget {
  const SiakadApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'SIAKAD Mini',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.indigo),
      ),
      home: const KrsPage(),
    );
  }
}
