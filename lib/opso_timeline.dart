import 'package:flutter/material.dart';
import 'package:timeline_tile/timeline_tile.dart';

import 'widgets/event_card.dart';

class OpsoTimeLineScreen extends StatelessWidget {
  const OpsoTimeLineScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Open-Source Timeline of 2024'),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 50.0),
        child: ListView(
          children: [
            OpSoTimeLineTile(
              isFirst: true,
              isLast: false,
              eventDescription: "Outreachy(May Internships)\nApplication Period - 15/01/2024 to 31/01/2024",
              startDate: DateTime.utc(2024,1,15),
              endDate: DateTime.utc(2024,1,31),
              isPast: DateTime.now().isAfter(DateTime.utc(2024,1,31)),
              isComing: DateTime.now().isBefore(DateTime.utc(2024,1,15)),
            ),
            OpSoTimeLineTile(
              isFirst: false,
              isLast: false,
              eventDescription: "Linux Foundation Mentorship(Spring Term)\nApplication Period - 15/01/2024 to 15/02/2024",
              startDate: DateTime.utc(2024,1,15),
              endDate: DateTime.utc(2024,2,15),
              isPast: DateTime.now().isAfter(DateTime.utc(2024,2,15)),
              isComing: DateTime.now().isBefore(DateTime.utc(2024,1,15)),
            ),
            OpSoTimeLineTile(
              isFirst: false,
              isLast: false,
              eventDescription: "Summer of Bitcoin\nApplication Period - 01/02/2024 to 19/02/2024",
              startDate: DateTime.utc(2024,2,1),
              endDate: DateTime.utc(2024,2,19),
              isPast: DateTime.now().isAfter(DateTime.utc(2024,2,19)),
              isComing: DateTime.now().isBefore(DateTime.utc(2024,2,1)),
            ),
            OpSoTimeLineTile(
              isFirst: false,
              isLast: false,
              eventDescription: "Google Season of Docs\nApplication Period - 22/02/2024 to 02/04/2024",
              startDate: DateTime.utc(2024,2,22),
              endDate: DateTime.utc(2024,4,2),
              isPast: DateTime.now().isAfter(DateTime.utc(2024,4,2)),
              isComing: DateTime.now().isBefore(DateTime.utc(2024,2,22)),
            ),
            OpSoTimeLineTile(
              isFirst: false,
              isLast: false,
              eventDescription: "Google Summer of Code\nApplication Period - 18/03/2024 to 02/04/2024",
              startDate: DateTime.utc(2024,3,18),
              endDate: DateTime.utc(2024,4,2),
              isPast: DateTime.now().isAfter(DateTime.utc(2024,4,2)),
              isComing: DateTime.now().isBefore(DateTime.utc(2024,3,18)),
            ),
            OpSoTimeLineTile(
              isFirst: false,
              isLast: false,
              eventDescription: "MLH Fellowship(Summer Term-B\nApplication Period - 31/03/2024 to 15/04/2024",
              startDate: DateTime.utc(2024,3,31),
              endDate: DateTime.utc(2024,4,15),
              isPast: DateTime.now().isAfter(DateTime.utc(2024,4,15)),
              isComing: DateTime.now().isBefore(DateTime.utc(2024,3,31)),
            ),
            OpSoTimeLineTile(
              isFirst: false,
              isLast: false,
              eventDescription: "MLH Fellowship(Fall Term)\nApplication Period - 15/04/2024 to 31/05/2024",
              startDate: DateTime.utc(2024,4,15),
              endDate: DateTime.utc(2024,7,15),
              isPast: DateTime.now().isAfter(DateTime.utc(2024,7,15)),
              isComing: DateTime.now().isBefore(DateTime.utc(2024,4,15)),
            ),
            OpSoTimeLineTile(
              isFirst: false,
              isLast: false,
              eventDescription: "Linux Foundation Mentorship(Summer Term)\nApplication Period - 15/04/2024 to 15/05/2024",
              startDate: DateTime.utc(2024,4,15),
              endDate: DateTime.utc(2024,5,15),
              isPast: DateTime.now().isAfter(DateTime.utc(2024,5,15)),
              isComing: DateTime.now().isBefore(DateTime.utc(2024,4,15)),
            ),
            OpSoTimeLineTile(
              isFirst: false,
              isLast: false,
              eventDescription: "GirlScript Summer of Code\nApplication Period - 01/05/2024 to 10/05/2024",
              startDate: DateTime.utc(2024,5,1),
              endDate: DateTime.utc(2024,5,10),
              isPast: DateTime.now().isAfter(DateTime.utc(2024,5,10)),
              isComing: DateTime.now().isBefore(DateTime.utc(2024,5,1)),
            ),
            OpSoTimeLineTile(
              isFirst: false,
              isLast: false,
              eventDescription: "Linux Foundation Mentorship(Fall Term)\nApplication Period - 15/07/2024 to 15/08/2024",
              startDate: DateTime.utc(2024,7,15),
              endDate: DateTime.utc(2024,8,15),
              isPast: DateTime.now().isAfter(DateTime.utc(2024,8,15)),
              isComing: DateTime.now().isBefore(DateTime.utc(2024,7,15)),
            ),
            OpSoTimeLineTile(
              isFirst: false,
              isLast: true,
              eventDescription: "Outreachy(December Internships)\nApplication Period - 01/08/2024 to 31/08/2024",
              startDate: DateTime.utc(2024,8,1),
              endDate: DateTime.utc(2024,8,31),
              isPast: DateTime.now().isAfter(DateTime.utc(2024,8,31)),
              isComing: DateTime.now().isBefore(DateTime.utc(2024,8,1)),
            ),
          ],
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
