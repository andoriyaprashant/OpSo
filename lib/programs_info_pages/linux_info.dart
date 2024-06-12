import 'package:flutter/material.dart';

class LINUXInfo extends StatelessWidget {
  const LINUXInfo({super.key});

  @override
  Widget build(BuildContext context) {


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
                'Linux Foundation Mentorship Program',
                style: Theme.of(context).textTheme.titleLarge,
              ),
              const SizedBox(height: 20),
              _buildOutlinedBox(
                context,
                title: 'Overview',
                content: 'The Linux Foundation Mentorship Program is designed to help developers — many of whom are first-time open source contributors — with necessary skills and resources to learn, experiment, and contribute effectively to open source communities. By participating in a mentorship program, mentees have the opportunity to learn from experienced open source contributors as a segue to get internship and job opportunities upon graduation.',
              ),
              const SizedBox(height: 20),
              _buildOutlinedBox(
                context,
                title: 'Eligibility Criteria',
                content: 'The following eligibility rules apply to all mentee applicants:\n\n'
                    '1. Be at least 18 years old by the time the mentorship program starts.\n\n'
                    '2. Not be a prior or an active participant in another Linux Foundation mentorship program.\n\n'
                    '3. Be eligible to work in the country and jurisdiction where you will be participating in the Mentorship program.\n\n'
                    '4. Not reside in a country or jurisdiction where participation in the mentorship is prohibited under applicable U.S. federal, state or local laws or the laws of other countries.\n\n'
                    '5. Seeking to participate on your own behalf as an individual.\n\n'
                    '6. Not be subject to any existing obligations to third parties (such as contractual obligations to an employer) that would restrict or prohibit your participation in a mentorship program.\n\n'
                    '7. Meet all criteria set by the program to which a mentees is applying, i.e. any custom prerequisites and requirements.\n\n'
                    '8. Not be a maintainer, recurring contributor, etc.. with more than minimal involvement with the open source project that offers a mentorship program.',
              ),
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
                          'Get paid while learning\n Mentees are eligible to receive a stipend, which is paid in two installments, provided that regular interval evaluations show you are making satisfactory progress. The final installment will be paid upon successful mentorship completion.',
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 8.0),
                        child: _buildPrizeBox(
                          context,
                          'Get Hired\n After you successfully complete the mentorship program, get connected to potential employers who are focused on your project and are offering interview opportunities. Your mentor may also refer you to a company.',
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
