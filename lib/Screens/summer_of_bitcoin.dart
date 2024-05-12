import 'package:flutter/material.dart';

class SummerofBitcoin extends StatefulWidget {
  const SummerofBitcoin({super.key});

  @override
  State<SummerofBitcoin> createState() => _SummerofBitcoinState();
}

class _SummerofBitcoinState extends State<SummerofBitcoin> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Summer of Bitcoin"),
      ),
    );
  }
}
