import 'package:flutter/material.dart';
import 'package:opso/widgets/event_card.dart';
import 'package:timeline_tile/timeline_tile.dart';

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
