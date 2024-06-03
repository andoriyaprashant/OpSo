import 'package:flutter/material.dart';

class EventCard extends StatelessWidget {
  final bool isPast;
  final bool isComing;
  final Widget child;

  const EventCard({
    super.key,
    required this.isPast,
    required this.isComing,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(25),
      padding: const EdgeInsets.all(25),
      decoration: BoxDecoration(
        color: isPast ? Colors.grey : isComing ? Colors.orange.shade100 : Colors.orange,
        borderRadius: BorderRadius.circular(8),
      ),
      child: child,
    );
  }
}
