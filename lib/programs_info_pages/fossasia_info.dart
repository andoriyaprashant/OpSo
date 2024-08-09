import 'package:flutter/material.dart';
import 'package:timeline_tile/timeline_tile.dart';

class   FossasiaInfo extends StatelessWidget {
  const   FossasiaInfo({super.key});

  @override
  Widget build(BuildContext context) {
    final List<Map<String, dynamic>> codeheatEvents = [
      {'date': '2023-12-01', 'description': 'Coding Starts'},
      {'date': '2023-12-08', 'description': 'Event: Codeheat Ask Me Anything'},
      {'date': '2023-12-15', 'description': 'Event: Codeheat Ask Me Anything'},
      {'date': '2024-01-12', 'description': 'Event: Codeheat Ask Me Anything'},
      {'date': '2024-01-19', 'description': 'Event: Codeheat Ask Me Anything'},
      {'date': '2024-01-26', 'description': 'Event: Codeheat Ask Me Anything'},
      {'date': '2024-02-01', 'description': 'Event: Codeheat Ask Me Anything'},
      {'date': '2024-03-31', 'description': 'Codeheat period ends. Participants submit Gist with links to their work through a link on the program spreadsheet to participate in the winners evaluations.'},
      {'date': '2024-04-09', 'description': 'Winners Announcement'},
      {'date': '2024-04-16', 'description': 'Distribute digital certificates and gifts'},
      {'date': '2024-04-30', 'description': 'Publish Contest Report'},
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
                'FOSSASIA Codeheat', 
                style: Theme.of(context).textTheme.titleLarge,
              ),
              const SizedBox(height: 20),
              _buildOutlinedBox(
                context,
                title: 'Overview',
                content: 'CodeHeat is the annual coding contest for students and developers to contribute to Free and Open Source software (FOSS) and open hardware projects. Join the development of real world applications, build up your developer profile, learn new coding skills, collaborate with the community and make new friends from around the world!',
              ),
              const SizedBox(height: 20),
              _buildOutlinedBox(
                context,
                title: 'Mentee Applicant Eligibility',
                content: 'Anyone with excellent coding skills can participate in FOSSASIA Codeheat, regardless of age, gender, background, or status.'
                    ),
              const SizedBox(height: 20),
              Text(
                'Program Timeline',
                style: Theme.of(context).textTheme.headlineSmall,
              ),
              const SizedBox(height: 10),
              _buildTimeline(codeheatEvents),
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
                          'Participants who solve any five issues will receive a digital certificate and a free conference pass to the FOSSASIA Summit 2024.',
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 8.0),
                        child: _buildPrizeBox(
                          context,
                          'Category 1: Collaboration Catalyst - 20 x Coder Surprise Packages. Apart from good code contributions a winner in this category will show a particular ability to effectively collaborate with others. You will show an outstanding mindset to foster a positive open-source community by supporting newbies to join the contest, reviewing the work of others, and helping others with PRs, e.g. contributors who are stuck with a pull request.',
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 8.0),
                        child: _buildPrizeBox(
                          context,
                          'Category 2: Open Source Pioneer - 10 x Professional Online Software Development Courses. A winner in this category would showcase their excellent coding ability by making pioneering contributions. You demonstrate excellent debugging skills, finding and fixing issues in the most effective and efficient manner.',
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 8.0),
                        child: _buildPrizeBox(
                          context,
                          'Category 3: Code Excellence - 3 x Trips to the FOSSASIA Summit 2024 (Value of 600 USD each). A winner in this category would show important and continuous code contributions that have a substantial impact on the functionality, usability, or overall improvement of projects in the CodeHeat contest.',
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
