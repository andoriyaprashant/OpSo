import 'package:flutter/material.dart';
import 'home_page.dart';

void main() {
  runApp(OpSaApp());
}

class OpSaApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'OpSa',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
        
      ),
      home: HomePage(),
    );
  }
}

