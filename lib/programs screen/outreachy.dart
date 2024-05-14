import 'package:flutter/material.dart';

class OutReachy extends StatefulWidget {
  const OutReachy({super.key});

  @override
  State<OutReachy> createState() => _OutReachyState();
}

class _OutReachyState extends State<OutReachy> {
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
                // Show a SnackBar to indicate whether the bookmark was added or removed
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(flag ? 'Bookmark removed' : 'Bookmark added'),
                    duration: const Duration(seconds: 2), // Adjust the duration as needed
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