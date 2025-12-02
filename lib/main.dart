import 'package:flutter/material.dart';
import 'home_page.dart';

void main() {
  runApp(const NumeraApp());
}

class NumeraApp extends StatelessWidget {
  const NumeraApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Numera',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.greenAccent),
        useMaterial3: true,
      ),
      home: const HomePage(),
    );
  }
}
