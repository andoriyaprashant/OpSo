import 'package:flutter/material.dart';
import 'package:opso/modals/book_mark_model.dart';
import 'package:timeline_tile/timeline_tile.dart';
import 'package:url_launcher/url_launcher.dart';

class MajorLeagueHackingFellowship extends StatefulWidget {
  const MajorLeagueHackingFellowship({super.key});

  @override
  State<MajorLeagueHackingFellowship> createState() =>
      _MajorLeagueHackingFellowshipState();
}

class _MajorLeagueHackingFellowshipState
    extends State<MajorLeagueHackingFellowship> {
  bool isBookmarked = true;
  String currectPage = "/major_league_hacking_fellowship";
  String currentProject = "MajorLeagueHackingFellowship";

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
    setState(() {
      //implement refresh logic here when ready
      // Currently not fetching anything
    });
  }

  @override
  Widget build(BuildContext context) {
    // Size constants
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
            title: const Text('MLH Fellowship'), actions: <Widget>[
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
                    duration: const Duration(
                        seconds: 2), // Adjust the duration as needed
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
          ]),
          body: SingleChildScrollView(
            padding: EdgeInsets.all(pad),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(vertical: pad),
                  child: Text(
                    'Learn Software Engineering through Open Source Projects',
                    style: TextStyle(
                        fontSize: titleSize, fontWeight: FontWeight.bold),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(vertical: pad),
                  child: Text(
                    'A fully remote, 12-week internship alternative where participants earn a stipend '
                    'and learn to collaborate on real open source projects with peers and engineers from top companies.',
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
                          await _launchUrl("https://fellowship.mlh.io/apply");
                        },
                        child: const Text("Apply Now")),
                    SizedBox(width: gap),
                    ElevatedButton(
                        onPressed: () async {
                          await _launchUrl(
                              "https://fellowship.mlh.io/programs/open-source");
                        },
                        child: const Text("Learn More")),
                  ],
                ),
                SizedBox(height: gap),
                Padding(
                  padding: EdgeInsets.symmetric(vertical: pad),
                  child: Text(
                    'Explore Fellowship Tracks',
                    style: TextStyle(
                        fontSize: titleSize, fontWeight: FontWeight.bold),
                  ),
                ),
                _buildTrackTile('Software Engineering',
                    'For aspiring Software Engineers who want to experience what it\'s like to collaborate on real-world projects from our partners.',
                    () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const TrackDetailsScreen(
                                title:
                                    'What exactly is the Software Engineering Fellowship?',
                                description:
                                    "Software Engineering is one of the most in-demand skills that tech companies are hiring for. As an MLH Fellow on the Software Engineering Track, you'll be matched to a real project from one of our partners. You'll experience what it's like to work on a real software engineering team first-hand, working on either open- or closed-source projects that tech companies depend on every day. ",
                                url:
                                    "https://fellowship.mlh.io/programs/software-engineering",
                              )));
                }),
                _buildTrackTile('Site Reliability Engineering',
                    'For aspiring SREs who want to learn the skills required to keep systems running at scale.',
                    () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const TrackDetailsScreen(
                                title:
                                    "What exactly is the Site Reliability Engineering Track?",
                                description:
                                    "Site Reliability Engineering, also known as DevOps, is one of the most in-demand skills that tech companies are hiring for. It's a hybrid between software & systems engineering that works across product & infrastructure to make sure services are reliable & scalable.\nIn the Site Reliability Engineering Track of the MLH Fellowship, you'll learn the skills needed to keep products running. You'll write code and debug hard problems. By the end of the program, you will gain valuable technical skills and the experience needed for a career in Site Reliability Engineering.\nProgram participants will gain practical skills thanks to educational content from Linux Foundation Training & Certification's LFS201 – Essentials of System Administration training course, which covers how to administer, configure and upgrade Linux systems, along with the tools and concepts necessary to efficiently build and manage a production Linux infrastructure.",
                                url:
                                    "https://fellowship.mlh.io/programs/site-reliability-engineering",
                              )));
                }),
                _buildTrackTile('Web3 Engineering',
                    'For hackers who want to dive deep into blockchain technology.',
                    () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const TrackDetailsScreen(
                                title: 'Web3 Track',
                                description:
                                    "Web3 is the name given to internet services that are built using decentralized blockchains — the distributed ledger systems used by cryptocurrencies like Bitcoin and Ether. This underlying technology has broad applications, though, and Web3 has grown to encompass gaming, social platforms, crowdfunding, CRMs and more.\nIn the Web3 track of the MLH Fellowship, you'll learn the skills needed to build on this quickly evolving part of the web and contribute to cutting-edge Web3 applications. Through expert mentorship, you’ll learn how to code on blockchains like Solana, collaborate on a team, and debug hard problems. By the end of the program, you will gain valuable technical skills and the experience needed for a career in Web3 and beyond.",
                                url:
                                    "https://fellowship.mlh.io/programs/web3-engineering",
                              )));
                }),
                SizedBox(height: gap),
                Padding(
                  padding: EdgeInsets.symmetric(vertical: pad),
                  child: Text(
                    "Sample Schedule",
                    style: TextStyle(
                        fontSize: titleSize, fontWeight: FontWeight.bold),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(vertical: pad),
                  child: Text(
                    "Here's what a typical day in the fellowship might look like. The program runs Monday - Friday in most major timezones.",
                    style: TextStyle(
                      fontSize: contentSize,
                    ),
                  ),
                ),
                SizedBox(height: gap),
                _buildTimeline(),
                SizedBox(height: gap),
                Center(
                  child: ElevatedButton(
                    onPressed: () {
                      _launchUrl('https://hackp.ac/fellowship-faq');
                    },
                    child: const Text('Read the FAQ'),
                  ),
                ),
              ],
            ),
          ),
        ));
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

  Widget _buildTimeline() {
    return Column(
      children: [
        _buildTimelineItem(
          time: '10:00 AM',
          title: 'Daily Standup',
          description:
              'Start your day with your Pod\'s daily standup where you\'ll share what you\'re working on and eliminate blockers.',
        ),
        _buildTimelineItem(
          time: '11:00 AM',
          title: 'Pair Programming',
          description:
              'Jump into a pair programming session with another fellow to put the finishing touches on a pull request you\'re working on together.',
        ),
        _buildTimelineItem(
          time: '12:00 PM',
          title: 'Speaker Series',
          description:
              'Attend one of the regular speaker sessions where you\'ll learn from engineers, founders, and talent experts.',
        ),
        _buildTimelineItem(
          time: '02:00 PM',
          title: 'Practical Curriculum',
          description:
              'Go through the latest module on the LMS where you\'re learning practical skills you can apply right away.',
        ),
        _buildTimelineItem(
          time: '05:00 PM',
          title: 'Code Review',
          description:
              'Meet with one of the expert mentors for a code review of the pull request you were working on this morning. Lots of great feedback you can start on in the morning!',
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
                    TextStyle(fontSize: titleSize, fontWeight: FontWeight.bold),
              ),
            ),
            SizedBox(height: gap),
            Padding(
              padding: EdgeInsets.symmetric(vertical: pad),
              child: Text(
                description,
                style: TextStyle(
                  fontSize: contentSize,
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
