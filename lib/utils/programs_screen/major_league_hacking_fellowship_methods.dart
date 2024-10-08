import 'package:flutter/material.dart';
import 'package:timeline_tile/timeline_tile.dart';

Widget buildTrackTile(String title, String description, VoidCallback onTap) {
  return InkWell(
    onTap: onTap,
    child: Card(
      surfaceTintColor: Colors.orange,
      elevation: 4.0,
      margin: const EdgeInsets.symmetric(vertical: 10.0),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(title,
                style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.orange)),
            const SizedBox(height: 8),
            Text(description),
          ],
        ),
      ),
    ),
  );
}

Widget buildTimeline() {
  return Column(
    children: [
      buildTimelineItem(
        time: '10:00 AM',
        title: 'Daily Standup',
        description:
            'Start your day with your Pod\'s daily standup where you\'ll share what you\'re working on and eliminate blockers.',
      ),
      buildTimelineItem(
        time: '11:00 AM',
        title: 'Pair Programming',
        description:
            'Jump into a pair programming session with another fellow to put the finishing touches on a pull request you\'re working on together.',
      ),
      buildTimelineItem(
        time: '12:00 PM',
        title: 'Speaker Series',
        description:
            'Attend one of the regular speaker sessions where you\'ll learn from engineers, founders, and talent experts.',
      ),
      buildTimelineItem(
        time: '02:00 PM',
        title: 'Practical Curriculum',
        description:
            'Go through the latest module on the LMS where you\'re learning practical skills you can apply right away.',
      ),
      buildTimelineItem(
        time: '05:00 PM',
        title: 'Code Review',
        description:
            'Meet with one of the expert mentors for a code review of the pull request you were working on this morning. Lots of great feedback you can start on in the morning!',
      ),
    ],
  );
}

Widget buildTimelineItem(
    {required String time,
    required String title,
    required String description}) {
  return TimelineTile(
    alignment: TimelineAlign.start,
    isFirst: true,
    indicatorStyle: const IndicatorStyle(
      width: 40.0,
      color: Colors.orange,
      padding: EdgeInsets.all(8.0),
    ),
    endChild: Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            time,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 8.0),
          Text(
            title,
            style: const TextStyle(
              fontSize: 18.0,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 4.0),
          Text(description),
        ],
      ),
    ),
  );
}
