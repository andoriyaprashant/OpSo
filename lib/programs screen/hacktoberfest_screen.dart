import 'package:flutter/material.dart';
import 'package:opso/modals/book_mark_model.dart';
import 'package:timeline_tile/timeline_tile.dart';
import 'package:url_launcher/url_launcher.dart';

class Hacktoberfest extends StatefulWidget {
  const Hacktoberfest({super.key});

  @override
  State<Hacktoberfest> createState() => _HacktoberfestState();
}

class _HacktoberfestState extends State<Hacktoberfest> {
  bool isBookmarked = true;
  String currectPage = "/Hacktoberfest";
  String currentProject = "Hacktoberfest";

  @override
  void initState() {
    super.initState();
    _checkBookmarkStatus();
  }

  Future<void> _checkBookmarkStatus() async {
    bool bookmarkStatus = await HandleBookmark.isBookmarked(currentProject);
    setState(() {
      isBookmarked = bookmarkStatus;
    });
  }

  Future<void> _refresh() async {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double gap = screenWidth * 0.05;
    double pad = screenWidth * 0.04;
    double titleSize = screenWidth * 0.05;
    double contentSize = screenWidth * 0.04;
    return RefreshIndicator(
      onRefresh: _refresh,
      child: Scaffold(
        appBar: AppBar(
           leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios),
         
          onPressed: () => Navigator.of(context).pop(),
        ),
        centerTitle: true,
          title: const Text('Hacktoberfest'),
          actions: <Widget>[
            IconButton(
              icon: (isBookmarked)
                  ? const Icon(Icons.bookmark_add_rounded)
                  : const Icon(Icons.bookmark_add_outlined),
              onPressed: () {
                setState(() {
                  isBookmarked = !isBookmarked;
                });
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(
                        isBookmarked ? 'Bookmark added' : 'Bookmark removed'),
                    duration: const Duration(seconds: 2),
                  ),
                );
                if (isBookmarked) {
                  print("Adding");
                  HandleBookmark.addBookmark(currentProject, currectPage);
                } else {
                  print("Deleting");
                  HandleBookmark.deleteBookmark(currentProject);
                }
              },
            )
          ],
        ),
        body: SingleChildScrollView(
          padding: EdgeInsets.all(pad),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.symmetric(vertical: pad),
                child: Text(
                  'Celebrate Open Source and Grow Your Skills with Hacktoberfest!',
                  style: TextStyle(
                      fontSize: titleSize, fontWeight: FontWeight.bold),
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(vertical: pad),
                child: Text(
                  'Hacktoberfest is an annual event in October, organized by DigitalOcean and GitHub, to promote open-source contributions. Participants submit pull requests to GitHub repositories, fostering community, learning, and collaboration among developers worldwide.',
                  style: TextStyle(
                    fontSize: contentSize,
                  ),
                ),
              ),
              Row(
                children: [
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.orange,
                      foregroundColor: Colors.black,
                    ),
                    onPressed: () async {
                      await _launchUrl("https://hacktoberfest.com/");
                    },
                    child: const Text("Website")),
                  SizedBox(width: gap),
                  ElevatedButton(
                    onPressed: () async {
                      await _launchUrl(
                          "https://hacktoberfest.com/about/");
                    },
                    child: const Text("Learn More")),
                ],
              ),
              SizedBox(height: gap),
              Padding(
                padding: EdgeInsets.symmetric(vertical: pad),
                child: Text(
                  'How to find issues in Hacktoberfest',
                  style: TextStyle(
                      fontSize: titleSize, fontWeight: FontWeight.bold),
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(vertical: pad),
                child: Text(
                      '1. First, go to GitHub.\n'
                      '2. Click on "Issues.\n'
                      '3. Use the filter: is:open is:issue archived:false label:hacktoberfest.\n'
                      '4. Solve issues and make your contributions.',
                      style: TextStyle(
                        fontSize: contentSize,
                        height: 2, // Adjusts line spacing
                      ),
                    ),
              ),
              
              Padding(
                padding: EdgeInsets.symmetric(vertical: pad),
                child: Text(
                  'For Maintainers',
                  style: TextStyle(
                      fontSize: titleSize, fontWeight: FontWeight.bold),
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(vertical: pad),
                child: Text(
                  'Prepare your project for contributions by following these best practices:\n\n'
                  '1. Add the “hacktoberfest” topic to your repository to opt-in to Hacktoberfest and indicate you’re looking for contributions.\n\n'
                  '2. Apply the “hacktoberfest” label to issues you want contributors to help with in your GitHub or GitLab project.\n\n'
                  '3. Add a CONTRIBUTING.md file with contribution guidelines to your repository.\n\n'
                  '4. Choose issues that have a well-defined scope and are self-contained.\n\n'
                  '5. Adopt a code of conduct to create a greater sense of inclusion and community for contributors.\n\n'
                  '6. Be ready to review pull/merge requests, accepting those that are valid by merging them, leaving an overall approving review, or by adding the “hacktoberfest-accepted” label.\n\n'
                  '7. Reject any spammy requests you receive by labeling them as “spam,” and any other invalid contributions by closing them or labeling them as “invalid.”',
                  style: TextStyle(
                    fontSize: contentSize,
                    height: 1.5, // Adjusts line spacing
                  ),
                ),
              ),
                SizedBox(height: gap),
                _buildTimeline(),
                SizedBox(height: gap),
                Center(
                  child: ElevatedButton(
                    onPressed: () {
                      _launchUrl('https://hacktoberfest.com/participation/#faq');
                    },
                    child: const Text('Read the FAQ'),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTrackTile(String title, String description, VoidCallback onTap) {
    return InkWell(
      onTap: onTap,
      child: Card(
        surfaceTintColor: Colors.orange,
        elevation: 4.0,
        margin: const EdgeInsets.symmetric(vertical: 10.0),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(title,
                  style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.orange)),
              const SizedBox(height: 8),
              Text(description),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTimelineItem(
      {required String time,
      required String title,
      required String description}) {
    return TimelineTile(
      alignment: TimelineAlign.start,
      isFirst: true,
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
            Text(description),
          ],
        ),
      ),
    );
  }
}

 Widget _buildTimeline() {
    return Column(
      children: [
        _buildTimelineItem(
          time: 'October 1, 2024',
          title: 'Hacktoberfest Starts',
          description: 'The event kicks off and repositories start receiving contributions.',
        ),
        _buildTimelineItem(
          time: 'October 31, 2024',
          title: 'Hacktoberfest Ends',
          description: 'The event concludes and final contributions are counted.',
        ),
      ],
    );
  }



  Widget _buildTimelineItem(
      {required String time,
      required String title,
      required String description}) {
    return TimelineTile(
      alignment: TimelineAlign.start,
      isFirst: true,
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
            Text(description),
          ],
        ),
      ),
    );
  }


class TrackDetailsScreen extends StatelessWidget {
  final String title, description;
  final String? url;

  const TrackDetailsScreen(
      {super.key, required this.title, required this.description, this.url});

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double gap = screenWidth * 0.05;
    double pad = screenWidth * 0.04;
    double titleSize = screenWidth * 0.05;
    double contentSize = screenWidth * 0.04;
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(pad),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.symmetric(vertical: pad),
              child: Text(
                title,
                style:
                    TextStyle(fontSize: titleSize, fontWeight: FontWeight.bold, color: Colors.white),
              ),
            ),
            SizedBox(height: gap),
            Padding(
              padding: EdgeInsets.symmetric(vertical: pad),
              child: Text(
                description,
                style: TextStyle(
                  fontSize: contentSize,
                  color: Colors.white,
                ),
              ),
            ),
            SizedBox(height: gap),
            (url != null && url!.isNotEmpty)
                ? Center(
                    child: ElevatedButton(
                      onPressed: () {
                        _launchUrl(url!);
                      },
                      child: const Text('Explore More'),
                    ),
                  )
                : Container(),
          ],
        ),
      ),
    );
  }
}

Future<void> _launchUrl(String url) async {
  final Uri uri = Uri.parse(url);
  if (!await launchUrl(uri)) {
    throw 'Could not launch $url';
  }
}