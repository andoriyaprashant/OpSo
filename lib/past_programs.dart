import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'opso_timeline.dart';

class PastPrograms extends StatefulWidget {
  const PastPrograms({super.key});

  @override
  State<PastPrograms> createState() => _PastProgramsState();
}

class _PastProgramsState extends State<PastPrograms> {
  // Method to get only past events
  List<Map<String, dynamic>> getPastEvents() {
    DateTime now = DateTime.now();
    return OpsoTimeLineScreen.events.where((event) {
      DateTime endDate = event['endDate'];
      return endDate.isBefore(now);
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    // Get the filtered list of past events
    List<Map<String, dynamic>> pastEvents = getPastEvents();

    return Scaffold(
      appBar: AppBar(
        title: const Text("Past Programs"),
      ),
      body: ListView.builder(
        itemCount: pastEvents.length,
        itemBuilder: (context, index) {
          final event = pastEvents[index];
          // final DateTime endDate = event['endDate'];

          return ListTile(
            title: Text(event['title'] as String),
            onTap: () {
              // Handle tap event if needed
              showDialog(
                context: context,
                builder: (context) {
                  return AlertDialog(
                    title: Text(event['title'] as String),
                    content: Text(event['description'] as String),
                    actions: [
                      TextButton(
                        onPressed: () => Navigator.of(context).pop(),
                        child: const Text('Close'),
                      ),
                    ],
                  );
                },
              );
            },
          );
        },
      ),
    );
  }
}
