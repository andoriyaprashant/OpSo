import 'package:flutter/material.dart';
import 'package:timeline_tile/timeline_tile.dart';

class SOBInfo extends StatelessWidget {
  const SOBInfo({super.key});

  @override
  Widget build(BuildContext context) {
    final List<Map<String, dynamic>> events = [
      {'date': 'February 1, 2024', 'description': 'Student Application Period begins. Students can start applying to a track of their choice.'},
      {'date': 'February 19, 2024 at 23:59 UTC', 'description': 'Student Application Period ends. Application deadline for students to apply.'},
      {'date': 'February 16, 2024 - March 31, 2024', 'description': 'Learning Bootcamp. Screened students undergo an intensive bootcamp to learn about bitcoin.'},
      {'date': 'April 1, 2024', 'description': 'Project ideas for the internship program published on the website.'},
      {'date': 'April 1, 2024 - April 30, 2024', 'description': 'Proposal Round. Applicants submit their assignment solutions and project proposals for chosen project ideas.'},
      {'date': 'May 1, 2024 - May 7, 2024', 'description': 'Proposal Review Period. Mentors review and select project proposals.'},
      {'date': 'May 7, 2024', 'description': 'Accepted Students Announced. Accepted students are notified of their acceptance into the program.'},
      {'date': 'May 8, 2024 - May 15, 2024', 'description': 'Program Kick-Off and Onboarding. Accepted students are paired with mentors and start planning their projects and milestones.'},
      {'date': 'May 15, 2024 - August 15, 2024', 'description': 'Project Period. Students work on their Summer of Bitcoin projects.'},
      {'date': 'July 15, 2024 - July 20, 2024', 'description': 'Mid-term Evaluations. Mentors submit evaluations of their mentees. Passing students receive the first part of their stipend.'},
      {'date': 'August 19, 2024', 'description': 'Students Submit Projects. Final project report, including summaries and code submissions, due.'},
      {'date': 'August 19, 2024 - August 30, 2024', 'description': 'Final Evaluations. Mentors review student submissions to determine if projects are successfully completed.'},
      {'date': 'September 5, 2024', 'description': 'Results Announced. Students are notified of their pass/fail status. Passing students receive the final part of their stipend and a certificate of completion.'},
      {'date': 'Post Program Completion', 'description': 'Job Referrals. Exceptional students are offered opportunities for internships or full-time roles with bitcoin companies.'}
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
                'Summer of Bitcoin',
                style: Theme.of(context).textTheme.titleLarge,
              ),
              const SizedBox(height: 20),
              _buildOutlinedBox(
                context,
                title: 'Overview',
                content: 'A global, online summer internship program focused on introducing university students to bitcoin open-source development and design.',
              ),
              const SizedBox(height: 20),
              _buildOutlinedBox(
                context,
                title: 'Eligibility : What are the eligibility requirements for students?',
                content: 
                    'You must:\n'
                    '- Be a student enrolled in a university or high school program.\n'
                    '- Communicate effectively and clearly in English, with respect and courtesy.\n'
                    '- Have strong programming or design skills and experience with open-source development.\n'
                    '- Have experience with Git or be able to learn it quickly (applicable for developer track).\n\n'
                    'Availability:\n'
                    '- Be available to work full-time during the summer.\n'
                    '- Ensure that during the 12 weeks of the summer internship, nothing takes precedence over your project and you have no major distractions.\n'
                    '- If you have another job, decide between it and Summer of Bitcoin; you should choose one.\n'
                    '- If you have significant extra commitments, it is unlikely you will be successful in the program.\n\n'
                    'Connectivity:\n'
                    '- Have good Internet connectivity throughout the summer.\n'
                    '- Be able to stay in regular, close contact with mentors via usual open-source means (email, chat, Jitsi, etc.) for the duration of the summer. Geographic proximity to your mentor is not necessary.',
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
                    'Selected applicants get a ton of exciting swags, such as a bitcoin t-shirt, a bitcoin hardware wallet, a bitcoin book, cup, stickers and a cool bitcoin bag.',
                  ),
                  const SizedBox(height: 10),
                  _buildPrizeBox(
                    context,
                    'By participating in Bitcoin, you will receive a certificate of completion that will add prestigious credentials to your resume. It will highlight your expertise and commitment to excellence in open-source development and design.',
                  ),
                  const SizedBox(height: 10),
                  _buildPrizeBox(
                    context,
                    'Students who complete Summer of Bitcoin successfully get a handsome amount of 3000 dollars as a stipend.',
                  ),
                  const SizedBox(height: 10),
                  _buildPrizeBox(
                    context,
                    'You will also be eligible for job referrals. Exceptional students are offered opportunities for internships or full-time roles with bitcoin companies.',
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
