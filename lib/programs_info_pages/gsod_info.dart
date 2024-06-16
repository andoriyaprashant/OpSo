import 'package:flutter/material.dart';
import 'package:timeline_tile/timeline_tile.dart';

class GSODInfo extends StatelessWidget {
  const GSODInfo({super.key});

  @override
  Widget build(BuildContext context) {
    final List<Map<String, dynamic>> events = [
      {'date': 'February 2, 2024', 'description': 'Google Season of Docs program announced'},
      {'date': 'April 10, 2024 at 18:00 UTC', 'description': 'Google publishes the list of accepted organizations'},
      {'date': 'April 10, 2024', 'description': 'Doc development can officially begin'},
      {'date': 'April 10 - November 22, 2024', 'description': 'Hired technical writers work on documentation projects with guidance from organizations'},
      {'date': 'May 22, 2024 at 18:00 UTC', 'description': 'Technical writer hiring deadline'},
      {'date': 'June 5, 2024 - June 12, 2024 at 18:00 UTC', 'description': 'First monthly evaluation period. Organization administrators submit first of four monthly evaluation forms'},
      {'date': 'July 5, 2024 - July 12, 2024 at 18:00 UTC', 'description': 'Second monthly evaluation period'},
      {'date': 'September 5, 2024 - September 12, 2024 at 18:00 UTC', 'description': 'Third monthly evaluation period'},
      {'date': 'October 22, 2024 - October 29, 2024 at 18:00 UTC', 'description': 'Fourth monthly evaluation period'},
      {'date': 'November 22, 2024 - December 10, 2024 at 18:00 UTC', 'description': 'Organization administrators submit their case study and final project evaluation'},
      {'date': 'December 13, 2024', 'description': 'Google publishes the 2024 Google Season of Docs case studies and aggregate project data'},
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
                'Google Season Of Docs',
                style: Theme.of(context).textTheme.titleLarge,
              ),
              const SizedBox(height: 20),
              _buildOutlinedBox(
                context,
                title: 'Overview',
                content: 'Google Season of Docs provides support for open source projects to improve their documentation and gives professional technical writers an opportunity to gain experience in open source. Together we raise awareness of open source, of docs, and of technical writing.',
              ),
              const SizedBox(height: 20),
              _buildOutlinedBox(
                context,
                title: 'Eligibility : What are the eligibility requirements for participation?',
                content: 
                    '(a) run an active and viable open source software project.\n'
                    '(b) have already produced and released software under an Open Source Initiative (OSI)-approved license.\n'
                    '(c) not be a government agency or acting on behalf of a government or quasi-government agency that is funded by the public.\n'
                    '(d) not be based in a United States embargoed country, or otherwise prohibited by applicable export controls and sanctions programs.\n'
                    '(e) if the Organization is an individual, \n(i) not be a resident of a United States embargoed country; \n(ii) not be ordinarily resident in a United States embargoed country, or otherwise prohibited by applicable export controls and sanctions programs; and \n(iii) be at least eighteen (18) years of age upon registration for the Program.',
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
                    'Each project will receive 5,000 - 15,000 USD. The amount your organization receives will be based on the needs of your documentation project.',
                  ),
                  const SizedBox(height: 10),
                  _buildPrizeBox(
                    context,
                    'By participating in GSoD, you will receive a Google certificate that will add prestigious credentials to your resume and set you apart from the crowd in the tech industry. It will highlight your expertise and commitment to excellence in technical writing.',
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
