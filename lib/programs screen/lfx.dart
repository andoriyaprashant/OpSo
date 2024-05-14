import 'package:flutter/material.dart';

class Temp2 extends StatefulWidget {
  const Temp2({super.key});

  @override
  State<Temp2> createState() => _Temp2State();
}

class _Temp2State extends State<Temp2> {
  bool flag = true;
  @override
  Widget build(BuildContext context) {
    return Scaffold(

      appBar: AppBar(
        title: const Text('OpSo'),
          actions: <Widget>[
            IconButton(
            icon: (flag)
                ? const Icon(Icons.bookmark_add)
                : const Icon(Icons.bookmark_added),
            onPressed: () {
              setState(() {
                flag = !flag;
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(flag ? 'Bookmark removed' : 'Bookmark added'),
                    duration: const Duration(seconds: 2), 
                  ),
                );
              });
            },
            )
          ]
        ),

      body: const Center(
        child: Text('mlh'),
      ),
    );
  }
}