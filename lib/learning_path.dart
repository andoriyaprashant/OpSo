import 'package:flutter/material.dart';
import 'package:timeline_tile/timeline_tile.dart';
import 'package:url_launcher/url_launcher.dart';

class LearningPathPage extends StatelessWidget {
  const LearningPathPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
         leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios),
         
          onPressed: () => Navigator.of(context).pop(),
        ),
        centerTitle: true,
        title: const Text('GitHub Workflow'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            _buildTimelineItem(
              time: 'Step 1',
              title: 'Fork the Repository',
              description: 'Fork the repository to your GitHub account.',
            ),
            _buildTimelineItem(
              time: 'Step 2',
              title: 'Clone the Repository',
              description: 'Clone your forked repository to your local machine.',
            ),
            _buildTimelineItem(
              time: 'Step 3',
              title: 'Create a New Branch',
              description: 'Create a new branch for your feature or bug fix: git checkout -b feature-name.',
            ),
            _buildTimelineItem(
              time: 'Step 4',
              title: 'Make Changes',
              description: 'Make your changes and ensure that the code follows the Flutter style guide.',
            ),
            _buildTimelineItem(
              time: 'Step 5',
              title: 'Test Your Changes',
              description: 'Test your changes locally to ensure they work as expected.',
            ),
            _buildTimelineItem(
              time: 'Step 6',
              title: 'Commit Your Changes',
              description: 'Commit your changes with descriptive commit messages: git commit -m "Add feature XYZ".',
            ),
            _buildTimelineItem(
              time: 'Step 7',
              title: 'Push Your Changes',
              description: 'Push your changes to your forked repository: git push origin feature-name.',
            ),
            _buildTimelineItem(
              time: 'Step 8',
              title: 'Create a Pull Request',
              description: 'Create a pull request against the main branch of the original repository.',
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          const url = 'https://goodfirstissue.dev/';
          if (await canLaunch(url)) {
            await launch(url);
          } else {
            throw 'Could not launch $url';
          }
        },
        child: const Icon(Icons.rocket_launch_sharp),
      ),
    );
  }

  Widget _buildTimelineItem({
    required String time,
    required String title,
    required String description,
  }) {
    return TimelineTile(
      alignment: TimelineAlign.start,
      indicatorStyle: const IndicatorStyle(
        width: 40.0,
        color: Colors.orange,
        padding: EdgeInsets.all(8.0),
      ),
      endChild: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              time,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16.0,
                color: Colors.grey,
              ),
            ),
            const SizedBox(height: 8.0),
            Text(
              title,
              style: const TextStyle(
                fontSize: 18.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 4.0),
            Text(
              description,
              style: const TextStyle(fontSize: 16.0),
            ),
          ],
        ),
      ),
      isFirst: time == 'Step 1',
      isLast: time == 'Step 8',
    );
  }
}