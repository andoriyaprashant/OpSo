import 'package:flutter/material.dart';
import 'package:timeline_tile/timeline_tile.dart';

class SWOCInfo extends StatelessWidget {
  const SWOCInfo({super.key});

  @override
  Widget build(BuildContext context) {
    final List<Map<String, dynamic>> events = [
      {'date': '15 Aug 2023', 'description': 'Participant Registration starts'},
      {'date': '20 Aug 2023', 'description': 'Project and Mentor Registration Starts'},
      {'date': '15 Dec 2023', 'description': 'Project Registrations ends'},
      {'date': '20 Dec 2023', 'description': 'Participants and mentors registrations ends'},
      {'date': '22 Dec 2023', 'description': 'Acceptance Mails Sent'},
      {'date': '22 Dec 2023', 'description': 'Projects Announcement'},
      {'date': '1 Jan 2024', 'description': 'SWoC Begins'},
      {'date': '28 Feb 2024', 'description': 'SWoC Ends'},
      {'date': '15 Mar 2024', 'description': 'Results Announcement'},
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
                'Social Winter Of Code',
                style: Theme.of(context).textTheme.titleLarge,
              ),
              const SizedBox(height: 20),
              _buildOutlinedBox(
                context,
                title: 'Overview',
                content: 'Social Winter Of Code is a 2-month long open source program by Social India, with the aim to introduce more and more people to the world of Open Source. '
                    'In this program, all the selected participants will get a chance to work on various exciting projects under the guidance of experienced mentors.'
                    '\n\nParticipants can select the project based on their interest and tech stack, and can communicate with mentors and project admins to know the project better during the Community Bonding Period.',
              ),
              const SizedBox(height: 20),
              _buildOutlinedBox(
                context,
                title: 'Eligibility',
                content: 'Is there any registration fees?\n'
                    'No, there’s no registration fees. It is absolutely free for participants.\n\n'
                    'Who all can participate?\n'
                    'No matter if you are a beginner or an expert, SWOC is open for everyone who has a zeal to learn new things and achieve heights.\n\n'
                    'Any age limit for participation?\n'
                    'No, it is open for all.',
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
              SizedBox(
                child: GridView.count(
                  shrinkWrap: true,
                  crossAxisCount: 2,
                  children: [
                    _buildPrizeBox(
                      context,
                      'assets/github_swag.png',
                      'SWOC, GitHub swag kits\nTop 10 Contributors',
                    ),
                    _buildPrizeBox(
                      context,
                      'assets/xyz_domain.png', 
                      '.xyz domains\nTop 40',
                    ),
                    _buildPrizeBox(
                      context,
                      'assets/participation_certificate.png',
                      'Participation Certificate\nFor all',
                    ),
                    _buildPrizeBox(
                      context,
                      'assets/coding_ninja_swag.png',
                      'Swags from Coding Ninja\nTop 1',
                    ),
                  ],
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
      margin: const EdgeInsets.all(25),
      padding: const EdgeInsets.all(25),
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

  Widget _buildPrizeBox(BuildContext context, String imagePath, String description) {
    return Column(
      children: [
        CircleAvatar(
          radius: 40,
          backgroundImage: AssetImage(imagePath),
          backgroundColor: Colors.white,
        ),
        const SizedBox(height: 10),
        Text(
          description,
          textAlign: TextAlign.center,
          style: Theme.of(context).textTheme.bodyLarge,
        ),
      ],
    );
  }
}
