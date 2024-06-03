import 'package:flutter/material.dart';
import 'home_page.dart';

void main() {
  runApp(const OpSoApp());
}

class OpSoApp extends StatelessWidget {
  const OpSoApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'OpSo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,

      ),
      home: const HomePage(),
    );
  }
}

