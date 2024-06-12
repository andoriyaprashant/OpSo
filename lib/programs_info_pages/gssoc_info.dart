import 'package:flutter/material.dart';
import 'package:timeline_tile/timeline_tile.dart';

class   GSSOCInfo extends StatelessWidget {
  const   GSSOCInfo({super.key});

  @override
  Widget build(BuildContext context) {
    final List<Map<String, dynamic>> events = [
      {'date': '5th-6th May', 'description': 'Project Assignment to Mentors.'},
      {'date': '10th May', 'description': 'Coding period begins!'},
      {'date': '20th May', 'description': 'Community bonding period starts!'},
      {'date': '30th May', 'description': 'Leaderboard Opens.'},
      {'date': '30th July', 'description': 'Coding period ends.'},
      {'date': '2nd week of August', 'description': 'Results will be declared.'},
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
                'GirlScript Summer of Code',
                style: Theme.of(context).textTheme.titleLarge,
              ),
              const SizedBox(height: 20),
              _buildOutlinedBox(
                context,
                title: 'Overview',
                content: 'GirlScript Summer Of Code is a three-month-long Open-Source Program conducted every summer by the Girlscript Foundation. With constant efforts, participants contribute to numerous projects under the extreme guidance of skilled mentors over these months. With such exposure, students begin to contribute to real-world projects from the comfort of their homes.',
              ),
              const SizedBox(height: 20),
              _buildOutlinedBox(
                context,
                title: 'Eligibility',
                content: 'Is there any registration fees?\n'
                    'No, there’s no registration fees. It is absolutely free for participants.\n\n'
                    'Will a beginner, with absolutely no knowledge of github, gain anything fruitful?\n'
                    'Yeah, definitely. The organization is meant to assist the beginners grow in the field of development. We will have distinct projects appropriate both for beginners as well as the accolades and thereby we will make sure that each and every participant gets to learn something new from the projects he or she is contributing for.\n\n'
                    'Any age limit for participation?\n'
                    'No, there is no age limit for participation in GSSoC. It is open for all.',
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
                          'Top 3 contributors will be receiving\n - Cash Prizes\n - Certificate of Appreciation\n - Cool T-Shirts & Schwag Kit\n - Internship Opportunities\n - Shoutout on Socials\n - Subscriptions and perks from our partners',
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 8.0),
                        child: _buildPrizeBox(
                          context,
                          'Top 10 contributors will be receiving\n - Certificate of Appreciation\n - Cool T-Shirts & Schwag Kit\n - Internship Opportunities\n - Shoutout on Socials\n - Subscriptions and perks from our partners',
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 8.0),
                        child: _buildPrizeBox(
                          context,
                          'Top 25 contributors will be receiving\n - Certificate of Appreciation\n - Cool T-Shirts & Schwag Kit\n - Shoutout on Socials\n - Subscriptions and perks from our partners',
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 8.0),
                        child: _buildPrizeBox(
                          context,
                          'Top 50 contributors will be receiving\n - Certificate of Appreciation\n - Shoutout on Socials\n - Subscriptions and perks from our partners',
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 8.0),
                        child: _buildPrizeBox(
                          context,
                          'Top 100 contributors will be receiving\n - Certificate of Appreciation\n - Shoutout on Socials\n - Subscriptions and perks from our partners',
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
