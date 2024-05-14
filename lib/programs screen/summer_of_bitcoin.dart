import 'package:flutter/material.dart';

class mlhfellow extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Summer of Bitcoin'),
        actions: [
          IconButton(onPressed: () {}, icon: const Icon(Icons.bookmark_add)),
        ],
      ),
      body: Center(
        child: Text('mlh'),
      ),
    );
  }
}