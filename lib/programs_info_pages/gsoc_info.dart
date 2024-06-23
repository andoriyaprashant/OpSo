import 'package:flutter/material.dart';
import 'package:timeline_tile/timeline_tile.dart';

class GSOCInfo extends StatelessWidget {
  const GSOCInfo({super.key});

  @override
  Widget build(BuildContext context) {
    final List<Map<String, dynamic>> events = [
      {'date': 'February 21 - 18:00 UTC', 'description': 'List of accepted mentoring organizations published'},
      {'date': 'February 22 - March 18', 'description': 'Potential GSoC contributors discuss application ideas with mentoring organizations'},
      {'date': 'March 18 - 18:00 UTC', 'description': 'GSoC contributor application period begins'},
      {'date': 'April 2 - 18:00 UTC', 'description': 'GSoC contributor application deadline'},
      {'date': 'April 24 - 18:00 UTC', 'description': 'GSoC contributor proposal rankings due from Org Admins'},
      {'date': 'May 1 - 18:00 UTC', 'description': 'Accepted GSoC contributor projects announced'},
      {'date': 'May 1 - 26', 'description': 'Community Bonding Period | GSoC contributors get to know mentors, read documentation, get up to speed to begin working on their projects'},
      {'date': 'May 27', 'description': 'Coding officially begins!'},
      {'date': 'July 8 - 18:00 UTC', 'description': 'Mentors and GSoC contributors can begin submitting midterm evaluations'},
      {'date': 'August 19 - 26 - 18:00 UTC', 'description': 'Final week: GSoC contributors submit their final work product and their final mentor evaluation (standard coding period)'},
      {'date': 'August 26 - September 2 - 18:00 UTC', 'description': 'Mentors submit final GSoC contributor evaluations (standard coding period)'},
      {'date': 'September 3', 'description': 'Initial results of Google Summer of Code 2024 announced'},
      {'date': 'September 3 - November 4', 'description': 'GSoC contributors with extended timelines continue coding'},
      {'date': 'November 4 - 18:00 UTC', 'description': 'Final date for all GSoC contributors to submit their final work product and final evaluation'},
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text('Project Information'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Google Summer Of Code',
                style: Theme.of(context).textTheme.titleLarge,
              ),
              const SizedBox(height: 20),
              _buildOutlinedBox(
                context,
                title: 'Overview',
                content: 'Google Summer of Code is a global, online program focused on bringing new contributors into open source software development. GSoC Contributors work with an open source organization on a 12+ week programming project under the guidance of mentors.',
              ),
              const SizedBox(height: 20),
              _buildOutlinedBox(
                context,
                title: 'Eligibility : What are the eligibility requirements for participation?',
                content: 
                    '> You must be at least 18 years of age when you register.\n'
                    '> You must be eligible to work in the country you will reside in during the program.\n'
                    '> You must be an open source beginner or a student.\n'
                    '> You have not been accepted as a GSoC Contributor/Student in GSoC more than once.\n'
                    '> You must reside in a country that is not currently embargoed by the United States.',
              ),
              const SizedBox(height: 20),
              Text(
                'Program Timeline',
                style: Theme.of(context).textTheme.headlineSmall,
              ),
              const SizedBox(height: 10),
              _buildTimeline(events),
              const SizedBox(height: 20),
              Text(
                'Prizes and Rewards',
                style: Theme.of(context).textTheme.headlineSmall,
              ),
              const SizedBox(height: 10),
              Column(
                children: [
                  _buildPrizeBox(
                    context,
                    'Google will provide a stipend to GSoC Contributors who pass their evaluations and are able to receive stipends.',
                  ),
                  const SizedBox(height: 10),
                  _buildPrizeBox(
                    context,
                    'Google will also provide a Certificate of Completion to GSoC Contributors who pass their evaluations.',
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildOutlinedBox(BuildContext context, {required String title, required String content}) {
    return Container(
      padding: const EdgeInsets.all(10.0),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.orange, width: 1.0),
        borderRadius: BorderRadius.circular(8.0),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: Theme.of(context).textTheme.headlineSmall,
          ),
          const SizedBox(height: 10),
          Text(
            content,
            style: Theme.of(context).textTheme.bodyLarge,
          ),
        ],
      ),
    );
  }

  Widget _buildTimeline(List<Map<String, dynamic>> events) {
    return Column(
      children: events.asMap().entries.map((entry) {
        int index = entry.key;
        Map<String, dynamic> event = entry.value;
        final bool isFirst = index == 0;
        final bool isLast = index == events.length - 1;
        final bool isLeft = index % 2 == 0;

        return TimelineTile(
          axis: TimelineAxis.vertical,
          alignment: TimelineAlign.center,
          isFirst: isFirst,
          isLast: isLast,
          beforeLineStyle: const LineStyle(
            color: Colors.orange,
            thickness: 4,
          ),
          afterLineStyle: const LineStyle(
            color: Colors.orange,
            thickness: 4,
          ),
          indicatorStyle: IndicatorStyle(
            indicator: Container(
              decoration: const BoxDecoration(
                color: Colors.orange,
                shape: BoxShape.circle,
              ),
              child: const Icon(
                Icons.event,
                size: 15,
                color: Colors.white,
              ),
            ),
          ),
          startChild: isLeft ? _buildEventChild(event) : null,
          endChild: isLeft ? null : _buildEventChild(event),
        );
      }).toList(),
    );
  }

  Widget _buildEventChild(Map<String, dynamic> event) {
    return Container(
      width: 150,
      margin: const EdgeInsets.all(10), 
      padding: const EdgeInsets.all(10),  
      decoration: BoxDecoration(
        color: Colors.orange,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            event['date'],
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 16,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            event['description'],
            style: const TextStyle(
              fontSize: 14,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPrizeBox(BuildContext context, String description) {
    return Container(
      padding: const EdgeInsets.all(10.0),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.orange, width: 1.0),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Text(
        description,
        textAlign: TextAlign.center,
        style: Theme.of(context).textTheme.bodyLarge,
      ),
    );
  }
}
