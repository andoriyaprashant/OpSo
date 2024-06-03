import 'package:flutter/material.dart';
import 'package:opso/modals/book_mark_model.dart';




class OutReachy extends StatefulWidget {
  const OutReachy({super.key});


  @override
  State<OutReachy> createState() => _OutReachyState();
}


class _OutReachyState extends State<OutReachy> {
  bool isBookmarked = true;
  String currectPage = "/outreachy";
  String currentProject = "Outreachy";


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
    });
  }
  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: _refresh,
      child: Scaffold(


        appBar: AppBar(
            title: const Text('OpSo'),
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
                      content: Text(isBookmarked ? 'Bookmark added' : 'Bookmark removed'),
                      duration: const Duration(seconds: 2), // Adjust the duration as needed
                    ),
                  );
                  if(isBookmarked){
                    print("Adding");
                    HandleBookmark.addBookmark(currentProject, currectPage);
                  }
                  else{
                    print("Deleting");
                    HandleBookmark.deleteBookmark(currentProject);
                  }
                },
              )
            ]
        ),


        body: const Center(
          child: Text('Outreachy'),
        ),
      ),
    );
  }
}

