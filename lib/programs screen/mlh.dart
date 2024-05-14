import 'package:flutter/material.dart';

class MajorLeagueHackingFellowship extends StatefulWidget {
  const MajorLeagueHackingFellowship({super.key});

  @override
  State<MajorLeagueHackingFellowship> createState() => _MajorLeagueHackingFellowshipState();
}

class _MajorLeagueHackingFellowshipState extends State<MajorLeagueHackingFellowship> {
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