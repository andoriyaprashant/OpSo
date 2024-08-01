import 'package:flutter/material.dart';
import 'package:timeline_tile/timeline_tile.dart';

class   HYPERLEDGERInfo extends StatelessWidget {
  const   HYPERLEDGERInfo({super.key});

  @override
  Widget build(BuildContext context) {
    final List<Map<String, dynamic>> events = [
      {'date': '2024-02-05', 'description': 'Community members submitting mentorship project proposals'},
      {'date': '2024-03-18', 'description': 'Mentorship project proposal review by Technical Oversight Committee'},
      {'date': '2024-04-04', 'description': 'Mentee application period'},
      {'date': '2024-05-13', 'description': 'Mentee application review and applicant interview'},
      {'date': '2024-05-27', 'description': 'Selected mentee notification and acceptance'},
      {'date': '2024-06-03', 'description': 'Onboarding/orientation sessions'},
      {'date': '2024-06-17', 'description': 'Mentee/mentor working period begins (mentees are expected to commit 15-20 hours a week on a consistent basis during this time)'},
      {'date': '2024-07-22', 'description': '1st quarter mentee evaluation'},
      {'date': '2024-09-02', 'description': 'Midterm mentee evaluation, and midterm stipend will be paid to eligible mentees if they are in good standing following the midterm evaluation'},
      {'date': '2024-10-14', 'description': '3rd quarter mentee evaluation'},
      {'date': '2024-11-25', 'description': 'Final mentee evaluation, and final stipend will be paid to eligible mentees if they are in good standing following the final evaluation and successful completion of deliverables as determined by the mentor and program staff'},
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
                'Hyperledger',
                style: Theme.of(context).textTheme.titleLarge,
              ),
              const SizedBox(height: 20),
              _buildOutlinedBox(
                context,
                title: 'Overview',
                content: 'The Hyperledger Mentorship Program is aimed at creating a structured hands-on learning opportunity for new contributors who may otherwise lack the opportunity to gain exposure to or entry into the Hyperledger open source development community.',
              ),
              const SizedBox(height: 20),
              _buildOutlinedBox(
                context,
                title: 'Mentee Applicant Eligibility',
                content: 'You must be at least 18 years of age by end of May.\n\n'
                    'The mentorship will be remote. However, you must be eligible to work in the country and jurisdiction where you reside in for the entire duration of the program.',
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
              Center(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 8.0),
                        child: _buildPrizeBox(
                          context,
                          'Mentees gain exposure to and first-hand experience with real-world open source software development.',
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 8.0),
                        child: _buildPrizeBox(
                          context,
                          'Mentees may be eligible to receive a stipend. The stipend will be paid in two installments provided that regular interval evaluations show the mentee eligible to received a stipend is making satisfactory progress. The final installment will be paid upon successful project completion as evaluated by the mentor(s) and the program staff.',
                        ),
                      ),
                    ],
                  ),
                ),
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
