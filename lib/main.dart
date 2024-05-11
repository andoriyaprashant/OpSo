import 'package:flutter/material.dart';
import 'package:opso/Screens/google_summer_of_code_screen.dart';
import 'home_page.dart';

void main() {
  runApp(const OpSaApp());
}

class OpSaApp extends StatelessWidget {
  const OpSaApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'OpSa',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: const HomePage(),
    );
  }
}
