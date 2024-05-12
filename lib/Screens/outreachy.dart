import 'package:flutter/material.dart';

class Outreachy extends StatefulWidget {
  const Outreachy({super.key});

  @override
  State<Outreachy> createState() => _OutreachyState();
}

class _OutreachyState extends State<Outreachy> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Outreachy"),
      ),
    );
  }
}
