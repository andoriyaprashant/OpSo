import 'package:flutter/material.dart';

class GoogleSeasonOfDocsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Google Season of Docs'),
        actions: [
          IconButton(onPressed: () {}, icon: const Icon(Icons.bookmark_add)),
        ],
      ),
      body: Center(
        child: Text('Google Season of Docs Screen'),
      ),
    );
  }
}
