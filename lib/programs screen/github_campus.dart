import 'package:flutter/material.dart';
import 'package:opso/modals/book_mark_model.dart';
import 'package:opso/utils/programs_screen/github_campus_methods.dart';

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
              buildHeroSection(),
              SizedBox(height: gap),
              buildActionButtons(gap),
              SizedBox(height: gap),
              buildBenefitsSection(titleSize, contentSize, pad),
              SizedBox(height: gap),
              buildRequirementsSection(titleSize, contentSize, pad),
              SizedBox(height: gap),
              buildApplicationProcessSection(titleSize, contentSize, pad),
            ],
          ),
        ),
      ),
    );
  }
}
