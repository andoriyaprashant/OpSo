import 'package:flutter/material.dart';
import 'package:opso/modals/book_mark_model.dart';
import 'package:opso/programs%20screen/articles_page.dart';

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('OpSo'), actions: <Widget>[
        ArticleButton(2, context),
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
                content:
                    Text(isBookmarked ? 'Bookmark added' : 'Bookmark removed'),
                duration:
                    const Duration(seconds: 2), // Adjust the duration as needed
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
      body: const Center(
        child: Text('MajorLeagueHackingFellowship'),
      ),
    );
  }
}
