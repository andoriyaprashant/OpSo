import 'package:flutter/material.dart';
import 'package:opso/modals/book_mark_model.dart';
import 'package:url_launcher/url_launcher.dart';

class DjangonautSpaceProgram extends StatefulWidget {
  const DjangonautSpaceProgram({super.key});

  @override
  State<DjangonautSpaceProgram> createState() => _DjangonautSpaceProgramState();
}

class _DjangonautSpaceProgramState extends State<DjangonautSpaceProgram> {
  bool isBookmarked = true;
  String currectPage = "/DjangonautSpaceProgram";
  String currentProject = "Djangonaut Space Program";

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
          title: const Text('Djangonaut Space Program'),
          actions: [
            IconButton(
              icon: Icon(
                isBookmarked
                    ? Icons.bookmark_add_rounded
                    : Icons.bookmark_add_outlined,
              ),
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
                  HandleBookmark.addBookmark(currentProject, currectPage);
                } else {
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
              Text(
                'Become a Djangonaut and Explore the Open Source Universe!',
                style: TextStyle(
                  fontSize: titleSize,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: pad),
              Text(
                'The Djangonaut Space Program is a community-driven initiative that helps newcomers and enthusiasts contribute to the Django ecosystem. Whether you’re a beginner or an experienced dev, Djangonauts will guide you through real-world contributions and mentorship in Django.',
                style: TextStyle(fontSize: contentSize, height: 1.5),
              ),
              SizedBox(height: pad * 1.5),
              Row(
                children: [
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.deepPurple,
                      foregroundColor: Colors.white,
                    ),
                    onPressed: () async {
                      await _launchUrl("https://djangonaut.space/");
                    },
                    child: const Text("Website"),
                  ),
                  SizedBox(width: gap),
                  ElevatedButton(
                    onPressed: () async {
                      await _launchUrl("https://github.com/djangonaut-space/program/blob/main/README.md");
                    },
                    child: const Text("About Djangonaut"),
                  ),
                ],
              ),
              SizedBox(height: pad * 2),
              Text(
                'How to Get Started with Djangonaut Program',
                style: TextStyle(
                  fontSize: titleSize,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: pad),
              Text(
                '1. Visit the Django GitHub organization.\n'
                '2. Look for beginner-friendly issues with labels like "good first issue".\n'
                '3. Join the Django Forum and IRC channels for guidance.\n'
                '4. Start contributing and submit your PRs for review!',
                style: TextStyle(fontSize: contentSize, height: 1.8),
              ),
              SizedBox(height: pad * 2),
              Text(
                'Mentorship in the Program',
                style: TextStyle(
                  fontSize: titleSize,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: pad),
              Text(
                'The program pairs experienced Django contributors with mentees to help them navigate:\n\n'
                '• The Django codebase\n'
                '• Contribution guidelines and standards\n'
                '• Submitting quality patches\n'
                '• Building confidence as a contributor',
                style: TextStyle(fontSize: contentSize, height: 1.6),
              ),
              SizedBox(height: pad * 2),
              Text(
                'What Can You Contribute To?',
                style: TextStyle(
                  fontSize: titleSize,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: pad),
              Text(
                'As part of the Djangonaut Space Program, contributors can work on projects like Django, Django CMS, and Django Debug Toolbar. '
                'Session organizers guide contributors based on their skills and interests to ensure meaningful contributions across these projects.',
                style: TextStyle(fontSize: contentSize, height: 1.6),
              ),
              SizedBox(height: pad * 2),
              Center(
                child: ElevatedButton(
                  onPressed: () {
                    _launchUrl('https://djangonaut.space/sessions/');
                  },
                  child: const Text('Explore Sessions'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _launchUrl(String url) async {
    final Uri uri = Uri.parse(url);
    if (!await launchUrl(uri)) {
      throw Exception('Could not launch $url');
    }
  }
}
