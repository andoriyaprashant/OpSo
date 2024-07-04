import 'package:flutter/material.dart';
import 'package:timeline_tile/timeline_tile.dart';

class OUTREACHYInfo extends StatelessWidget {
  const OUTREACHYInfo({super.key});

  @override
  Widget build(BuildContext context) {
    final List<Map<String, dynamic>> events = [
      {'date': '1 Aug 2024', 'description': 'Call for mentoring communities opens'},
      {'date': '31 Aug 2024', 'description': 'Initial applications open'},
      {'date': '1 Sept 2024', 'description': 'Initial applications due'},
      {'date': '1 Oct 2024', 'description': 'Contribution period opens'},
      {'date': '31 Oct 2024', 'description': 'Contribution period ends'},
      {'date': '30 Nov 2024', 'description': 'Interns announced'},
      {'date': '1 Dec 2024', 'description': 'Internships start'},
      {'date': '31 Mar 2024', 'description': 'Internships end'},
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
                'Outreachy',
                style: Theme.of(context).textTheme.titleLarge,
              ),
              const SizedBox(height: 20),
              _buildOutlinedBox(
                context,
                title: 'Overview',
                content: 'Outreachy provides internships in open source and open science. Outreachy provides internships to people subject to systemic bias and impacted by underrepresentation in the technical industry where they are living.'
              ),
              const SizedBox(height: 20),
              _buildOutlinedBox(
                context,
                title: 'Outreachy Eligibility Rules',
                content: 
                  '1. General eligibility\n'
                  '- You must be 18 years of age or older by May 27, 2024.\n'
                  '- You must be available for a full-time internship. Outreachy interns work 30 hours per week. The internship runs from May 27, 2024 to Aug. 23, 2024.\n\n'
                  '2. Past internships\n'
                  '- You are welcome to apply to Outreachy multiple times. However, you can only be accepted as an Outreachy intern once.\n'
                  '- You must not be a past Outreachy intern.\n'
                  '- You must not be a past Outreach Program for Women intern.\n'
                  '- You must not be a past Google Summer of Code intern. All Google Summer of Code interns are ineligible for Outreachy. This includes people who did not successfully finish their Google Summer of Code internship.\n\n'
                  '3. Current or future internships\n'
                  '- The Outreachy internship runs from May 27, 2024 to Aug. 23, 2024.\n'
                  '- You must not have another internship during the Outreachy internship period. This includes unpaid internships.\n'
                  '- Applicants are required to list their current internships on their initial application. If you receive a job or internship offer, please notify Outreachy organizers immediately.\n\n'
                  '4. Rules for people with jobs\n'
                  '- The Outreachy internship runs from May 27, 2024 to Aug. 23, 2024.\n'
                  '- You must not have a full-time job during the Outreachy internship.\n'
                  '- You must not have a full-time contracting position during the Outreachy internship period.\n'
                  '- You must not be on a leave of absence from a full-time job during the Outreachy internship.\n'
                  '- If you are willing to quit your full-time job, you are welcome to apply to Outreachy. If you cannot quit your full-time job, you are not eligible for Outreachy.\n'
                  '- If you have a part-time job, you are welcome to apply to Outreachy. Part-time jobs must be approved by Outreachy organizers.\n'
                  '- Applicants are required to list their current jobs on their initial application. If you receive a job or internship offer, please notify Outreachy organizers immediately.\n\n'
                  '5. Rules for people who are not students\n'
                  '- People who are not students are welcome to apply to Outreachy.\n'
                  '- Outreachy has two internship cohorts: May to August, and December to March. If you are not a student, you may apply to either internship cohort.\n\n'
                  '6. Rules for students\n'
                  '- Both students and people who are not students are welcome to apply to Outreachy.\n'
                  '- University students must have 42 consecutive days free from school and exams during the internship period.\n'
                  '- Students must apply to the correct internship cohort based on university hemisphere.\n'
                  '- Outreachy internships run twice a year, May to August and December to March. Specific rules apply based on university location relative to the equator.\n\n'
                  '7. Rules for students on visas\n'
                  '- Your visa must allow you to work 30 hours per week. If you cannot work 30 hours per week, you are not eligible for Outreachy.\n'
                  '- If you are on a student visa in the United States of America, you might have limited dates when you can work 30 hours a week. Outreachy can accommodate shifting internship dates by up to five weeks but cannot shorten the 13-week internship.\n'
                  '- Students on an F-1 visa may need to apply for CPT with their university, and Outreachy organizers can provide documentation upon selection.\n',
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
                          'Career Development Opportunities:\n\n'
                          '- Resume review\n'
                          '- Encouragement to conduct informational chats with open source professionals during week 9 of the internship\n\n',
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 8.0),
                        child: _buildPrizeBox(
                          context,
                          'Payments:\n\n'
                          'Outreachy interns are paid 7,000 USD total for three months of work. The stipend is paid in two payments:\n\n'
                          '- 3,000 initial stipend\n'
                          '- 4,000 final stipend\n\n',
                        ),
                      ),
                    ],
                  ),
                ),
              )

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
