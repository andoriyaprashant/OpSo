import 'package:flutter/material.dart';

class   RsocInfo extends StatelessWidget {
  const   RsocInfo({super.key});

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
                'Redox OS Summer of Code',
                style: Theme.of(context).textTheme.titleLarge,
              ),
              const SizedBox(height: 20),
              _buildOutlinedBox(
                context,
                title: 'Overview',
                content: 'Announcing Redox Summer of Code for 2024! This summer, we have a small number of positions open for students or recent graduates. To qualify, you must be a contributor to Redox or to a Redox-adjacent project, and be an experienced Rust programmer.',
              ),
              const SizedBox(height: 20),
              _buildOutlinedBox(
                context,
                title: 'Eligibility',
                content: 'Is there any registration fees?\n'
                    'No, there’s no registration fees. It is absolutely free for participants.\n\n'
                    'Who all can participate?\n'
                    'To qualify, you must be a contributor to Redox or to a Redox-adjacent project, and be an experienced Rust programmer.\n\n'
                    'Any age limit for participation?\n'
                    'No, there is no age limit for participation in Redox OS Summer of Code. It is open for all.',
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
                          'Gain experience working on a real-world project & improve your RUST skills',
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 8.0),
                        child: _buildPrizeBox(
                          context,
                          'Stipend to all the participants upon successful completion of the program',
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
