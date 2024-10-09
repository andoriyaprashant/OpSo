import 'package:flutter/material.dart';
import 'package:opso/modals/book_mark_model.dart';
import 'package:timeline_tile/timeline_tile.dart';
import 'package:url_launcher/url_launcher.dart';

class GithubCampus extends StatefulWidget {
  const GithubCampus({super.key});

  @override
  State<GithubCampus> createState() => _GithubCampusState();
}

class _GithubCampusState extends State<GithubCampus> {
  bool isBookmarked = true;
  String currectPage = "/GithubCampus";
  String currentProject = "GitubCampus";

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
          title: const Text('Github Campus Expert'),
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
              _buildHeroSection(),
              SizedBox(height: gap),
              _buildActionButtons(gap),
              SizedBox(height: gap),
              _buildBenefitsSection(titleSize, contentSize, pad),
              SizedBox(height: gap),
              _buildRequirementsSection(titleSize, contentSize, pad),
              SizedBox(height: gap),
              _buildApplicationProcessSection(titleSize, contentSize, pad),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHeroSection() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.orange[100],
        borderRadius: BorderRadius.circular(8.0),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            spreadRadius: 2,
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      padding: const EdgeInsets.all(16.0),
      child: const Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Become a GitHub Campus Expert and lead the next generation of student developers',
            style: TextStyle(
                fontSize: 20.0, fontWeight: FontWeight.bold, color: Colors.black),
          ),
          SizedBox(height: 8.0),
          Text(
            'The GitHub Campus Expert program empowers student leaders to cultivate a thriving community of developers and innovators on their campus, providing them with training, resources, and support to host events and drive impactful projects',
            style: TextStyle(
              fontSize: 16.0,
              color: Colors.black87,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildActionButtons(double gap) {
    return Row(
      children: [
        Expanded(
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.orange,
              foregroundColor: Colors.black,
            ),
            onPressed: () async {
              await _launchUrl("https://education.github.com/campus_experts");
            },
            child: const Text("Website"),
          ),
        ),
        SizedBox(width: gap),
        Expanded(
          child: ElevatedButton(
            onPressed: () async {
              await _launchUrl("https://github.com/about");
            },
            child: const Text("Learn More"),
          ),
        ),
      ],
    );
  }

  Widget _buildBenefitsSection(double titleSize, double contentSize, double pad) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.blue[50],
        borderRadius: BorderRadius.circular(8.0),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            spreadRadius: 2,
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      padding: EdgeInsets.all(pad),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Benefits of Being a Campus Expert',
            style: TextStyle(
                fontSize: titleSize, fontWeight: FontWeight.bold, color: Colors.black),
          ),
          SizedBox(height: pad),
          _buildRichText([
            _buildTextSpan('1. Training and Development: ', 'Access to a comprehensive training program covering public speaking, community building, and technical workshops.\n\n'),
            _buildTextSpan('2. Support and Mentorship: ', 'Guidance from GitHub staff and a network of other Campus Experts.\n\n'),
            _buildTextSpan('3. Resources: ', 'Access to GitHub’s platform and tools, event support, swag, and GitHub Campus Expert branded merchandise.\n\n'),
            _buildTextSpan('4. Networking: ', 'Opportunities to connect with other experts, professionals, and community leaders.'),
          ], contentSize),
        ],
      ),
    );
  }

  Widget _buildRequirementsSection(double titleSize, double contentSize, double pad) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.green[50],
        borderRadius: BorderRadius.circular(8.0),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            spreadRadius: 2,
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      padding: EdgeInsets.all(pad),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Requirements',
            style: TextStyle(
                fontSize: titleSize, fontWeight: FontWeight.bold, color: Colors.black),
          ),
          SizedBox(height: pad),
          _buildRichText([
            _buildTextSpan('1. Student Status: ', 'You must be a university student over the age of 18.\n\n'),
            _buildTextSpan('2. GitHub Account: ', 'A GitHub account in good standing.\n\n'),
            _buildTextSpan('3. GitHub Education Student Developer Pack: ', 'You must have access to the GitHub Education Student Developer Pack.\n\n'),
            _buildTextSpan('4. Passion for Community Building: ', 'Demonstrated interest in community building and organizing events.\n\n'),
            _buildTextSpan('5. Communication Skills: ', 'Ability to effectively communicate and collaborate with peers.'),
          ], contentSize),
        ],
      ),
    );
  }

  Widget _buildApplicationProcessSection(double titleSize, double contentSize, double pad) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.purple[50],
        borderRadius: BorderRadius.circular(8.0),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            spreadRadius: 2,
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      padding: EdgeInsets.all(pad),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Application Process',
            style: TextStyle(
                fontSize: titleSize, fontWeight: FontWeight.bold, color: Colors.black),
          ),
          SizedBox(height: pad),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildApplicationStep(
                stepNumber: '1',
                title: 'Application Form',
                description: 'Fill out the online application form available on the GitHub Campus Experts website.',
                icon: Icons.description,
                color: Colors.purple,
              ),
              _buildApplicationStep(
                stepNumber: '2',
                title: 'Essays and Video',
                description: 'Provide detailed answers to the essay questions and submit a video introducing yourself and explaining why you want to become a Campus Expert.',
                icon: Icons.video_call,
                color: Colors.purple,
              ),
              _buildApplicationStep(
                stepNumber: '3',
                title: 'Training',
                description: 'If selected, you will undergo a training program that covers public speaking, community leadership, and technical writing.',
                icon: Icons.school,
                color: Colors.purple,
              ),
              _buildApplicationStep(
                stepNumber: '4',
                title: 'Project Proposal',
                description: 'Develop and submit a project proposal outlining your plan for community engagement and impact on your campus.',
                icon: Icons.assignment,
                color: Colors.purple,
              ),
              _buildApplicationStep(
                stepNumber: '5',
                title: 'Review and Selection',
                description: 'The GitHub team reviews your application and makes the final selection.',
                icon: Icons.check_circle,
                color: Colors.purple,
              ),
              _buildApplicationStep(
                stepNumber: '6',
                title: 'Onboarding',
                description: 'If accepted, you will be onboarded into the program and start working as a Campus Expert.',
                icon: Icons.people,
                color: Colors.purple,
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildRichText(List<TextSpan> spans, double contentSize) {
    return RichText(
      text: TextSpan(
        style: TextStyle(
          fontSize: contentSize,
          height: 1.5,
          color: Colors.black,
        ),
        children: spans,
      ),
    );
  }

  TextSpan _buildTextSpan(String title, String content) {
    return TextSpan(
      children: [
        TextSpan(
          text: title,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
        TextSpan(text: content),
      ],
    );
  }

  Widget _buildApplicationStep({
    required String stepNumber,
    required String title,
    required String description,
    required IconData icon,
    required Color color,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, color: color, size: 24.0),
          const SizedBox(width: 8.0),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '$stepNumber. $title',
                  style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16.0, color: Colors.black),
                ),
                const SizedBox(height: 4.0),
                Text(description, style: const TextStyle(color: Colors.black),),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _launchUrl(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }
}