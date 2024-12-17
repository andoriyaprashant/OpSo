import 'package:flutter/material.dart';
import 'package:timeline_tile/timeline_tile.dart';
import 'package:opso/services/notificationService.dart';
import 'widgets/event_card.dart';

class OpsoTimeLineScreen extends StatelessWidget {
  const OpsoTimeLineScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final List<Map<String, dynamic>> events = [
      {
        'description':
            "Season of KDE-Mentorship\nApplication Period - 15/12/2023 to 08/01/2024",
        'startDate': DateTime.utc(2024, 12, 15),
        'endDate': DateTime.utc(2024, 1, 8),
      },
      {
        'description':
            "Outreachy(May Internships)\nApplication Period - 15/01/2024 to 31/01/2024",
        'startDate': DateTime.utc(2024, 1, 15),
        'endDate': DateTime.utc(2024, 1, 31),
      },
      {
        'description':
            "Linux Foundation Mentorship(Spring Term)\nApplication Period - 15/01/2024 to 15/02/2024",
        'startDate': DateTime.utc(2024, 1, 15),
        'endDate': DateTime.utc(2024, 2, 15),
      },
      {
        'description':
            "Summer of Bitcoin\nApplication Period - 01/02/2024 to 19/02/2024",
        'startDate': DateTime.utc(2024, 2, 1),
        'endDate': DateTime.utc(2024, 2, 19),
      },
      {
        'description':
            "Google Season of Docs\nApplication Period - 22/02/2024 to 02/04/2024",
        'startDate': DateTime.utc(2024, 2, 22),
        'endDate': DateTime.utc(2024, 4, 2),
      },
      {
        'description':
            "Google Summer of Code\nApplication Period - 18/03/2024 to 02/04/2024",
        'startDate': DateTime.utc(2024, 3, 18),
        'endDate': DateTime.utc(2024, 4, 2),
      },
      {
        'description':
            "MLH Fellowship(Summer Term-B)\nApplication Period - 31/03/2024 to 15/04/2024",
        'startDate': DateTime.utc(2024, 3, 31),
        'endDate': DateTime.utc(2024, 4, 15),
      },
      {
        'description':
            "Open Summer of Code\nApplication Period - 1/04/2024 to 29/04/2024",
        'startDate': DateTime.utc(2024, 4, 1),
        'endDate': DateTime.utc(2024, 4, 29),
      },
      {
        'description':
            "Hyperledger\nApplication Period - 04/04/2024 to 10/05/2024",
        'startDate': DateTime.utc(2024, 4, 4),
        'endDate': DateTime.utc(2024, 5, 10),
      },
      {
        'description':
            "MLH Fellowship(Fall Term)\nApplication Period - 15/04/2024 to 31/05/2024",
        'startDate': DateTime.utc(2024, 4, 15),
        'endDate': DateTime.utc(2024, 5, 31),
      },
      {
        'description':
            "Linux Foundation Mentorship(Summer Term)\nApplication Period - 15/04/2024 to 15/05/2024",
        'startDate': DateTime.utc(2024, 4, 15),
        'endDate': DateTime.utc(2024, 5, 15),
      },
      {
        'description':
            "GirlScript Summer of Code\nApplication Period - 01/05/2024 to 10/05/2024",
        'startDate': DateTime.utc(2024, 5, 1),
        'endDate': DateTime.utc(2024, 5, 10),
      },
      {
        'description':
            "Redox OS Summer of Code\nApplication Period - 01/05/2024 to 01/06/2024",
        'startDate': DateTime.utc(2024, 5, 01),
        'endDate': DateTime.utc(2024, 6, 01),
      },
      {
        'description':
            "Social Winter of Code\nApplication Period - 15/07/2024 to 20/12/2024",
        'startDate': DateTime.utc(2024, 7, 15),
        'endDate': DateTime.utc(2024, 12, 20),
      },
       {
        'description':
            "Linux Foundation Mentorship(Fall Term)\nApplication Period - 31/07/2024 to 27/08/2024",
        'startDate': DateTime.utc(2024, 7, 31),
        'endDate': DateTime.utc(2024, 8, 27),
      },
      {
        'description':
            "Outreachy(December Internships)\nApplication Period - 01/08/2024 to 31/08/2024",
        'startDate': DateTime.utc(2024, 8, 1),
        'endDate': DateTime.utc(2024, 8, 31),
      },
      {
        'description':
            "GitHub Campus Expert\nApplication Period - 01/08/2024 to 31/08/2024",
        'startDate': DateTime.utc(2024, 8, 1),
        'endDate': DateTime.utc(2024, 8, 31),
      },
      {
        'description':
            "FOSSASIA Codeheat\nApplication Period - 01/09/2024 to 31/11/2024",
        'startDate': DateTime.utc(2024, 9, 1),
        'endDate': DateTime.utc(2024, 11, 31),
      },
      {
        'description':
            "Hacktoberfest\nContribution Period - 01/10/2024 to 31/10/2024",
        'startDate': DateTime.utc(2024, 10, 1),
        'endDate': DateTime.utc(2024, 10, 31),
      },
      {
        'description':
        "GirlScript Summer Of Code Extended\nApplication Period - 15/09/2024 to 10/11/2024",
        'startDate': DateTime.utc(2024, 9, 15),
        'endDate': DateTime.utc(2024, 11, 10),
      },
      {
        'description':
        "GirlScript Summer Of Code Extended\nContribution Period - 01/10/2024 to 10/11/2024",
        'startDate': DateTime.utc(2024, 10, 1),
        'endDate': DateTime.utc(2024, 11, 10),
      },
    ];

    for (var event in events) {
      NotificationService.scheduleNotificationsForEvent(
        event['description']!,
        event['startDate']!,
        event['endDate']!,
      );
    }

    return Scaffold(
      appBar: AppBar(
         leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios),
         
          onPressed: () => Navigator.of(context).pop(),
        ),
        centerTitle: true,
        title: const Text('Open-Source Timeline of 2024'),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 50.0),
        child: ListView(
          children: events.map((event) {
            DateTime startDate = event['startDate']!;
            DateTime endDate = event['endDate']!;
            return OpSoTimeLineTile(
              isFirst: events.first == event,
              isLast: events.last == event,
              eventDescription: event['description']!,
              startDate: startDate,
              endDate: endDate,
              isPast: DateTime.now().isAfter(endDate),
              isComing: DateTime.now().isBefore(startDate),
            );
          }).toList(),
        ),
      ),
    );
  }
}

class OpSoTimeLineTile extends StatelessWidget {
  final String eventDescription;
  final bool isFirst;
  final bool isLast;
  final bool isPast; //true for DateTime.now().isAfter(endDate),
  final bool isComing; // true for DateTime.now().isBefore(startDate),
  final DateTime startDate;
  final DateTime endDate;

  const OpSoTimeLineTile({
    super.key,
    required this.eventDescription,
    required this.isFirst,
    required this.isLast,
    required this.isPast,
    required this.isComing,
    required this.startDate,
    required this.endDate,
  });

  @override
  Widget build(BuildContext context) {
    return TimelineTile(
      isFirst: isFirst,
      isLast: isLast,
      beforeLineStyle: LineStyle(
        color: isPast
            ? Colors.grey
            : isComing
                ? Colors.orange.shade100
                : Colors.orange,
      ),
      indicatorStyle: IndicatorStyle(
        width: 40,
        color: isPast
            ? Colors.grey
            : isComing
                ? Colors.orange.shade100
                : Colors.orange,
        iconStyle: IconStyle(
          iconData: isPast
              ? Icons.verified
              : isComing
                  ? Icons.hourglass_top_rounded
                  : Icons.notification_important_rounded,
          color: isPast
              ? Colors.white
              : isComing
                  ? Colors.orange
                  : Colors.white,
        ),
      ),
      endChild: EventCard(
        isPast: isPast,
        isComing: isComing,
        child: Text(
          eventDescription,
          style: const TextStyle(color: Colors.black),
        ),
      ),
    );
  }
}
