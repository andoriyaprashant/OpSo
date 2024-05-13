import 'package:flutter/material.dart';
import 'package:opso/programs%20screen/google_summer_of_code_screen.dart';
import 'home_page.dart';

void main() {
  runApp(OpSoApp());
}

class OpSoApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'OpSo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
        
      ),
      home: HomePage(),
    );
  }
}

