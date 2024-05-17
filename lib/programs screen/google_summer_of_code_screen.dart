import 'package:flutter/material.dart';
import 'package:opso/modals/book_mark_model.dart';
import 'package:opso/programs%20screen/articles_page.dart';

class GoogleSummerOfCodeScreen extends StatefulWidget {
  const GoogleSummerOfCodeScreen({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _GoogleSummerOfCodeScreenState createState() =>
      _GoogleSummerOfCodeScreenState();
}

class _GoogleSummerOfCodeScreenState extends State<GoogleSummerOfCodeScreen> {
  bool flag = true;
  String currectPage = "/google_summer_of_code";
  String currentProject = "Google Summer of Code";
  bool isBookmarked = true;

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
        ArticleButton(0, context),
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
                    const Duration(seconds: 1), // Adjust the duration as needed
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
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
            child: TextField(
              decoration: InputDecoration(
                hintText: 'Search',
                prefixIcon: const Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30.0),
                ),
                contentPadding: const EdgeInsets.symmetric(
                    vertical: 12.0, horizontal: 20.0),
              ),
              onChanged: (value) {
                // Handle search input
              },
            ),
          ),
          const SizedBox(height: 20),
          const Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              YearButton(
                year: '2021',
                url:
                    'https://summerofcode.withgoogle.com/archive/2021/organizations', // Replace with actual URL
              ),
              YearButton(
                year: '2022',
                url:
                    'https://summerofcode.withgoogle.com/archive/2022/organizations', // Replace with actual URL
              ),
            ],
          ),
          const SizedBox(height: 20),
          const Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              YearButton(
                year: '2023',
                url:
                    'https://summerofcode.withgoogle.com/archive/2023/organizations', // Replace with actual URL
              ),
              YearButton(
                year: '2024',
                url:
                    'https://summerofcode.withgoogle.com/archive/2024/organizations', // Replace with actual URL
              ),
            ],
          ),
          const SizedBox(height: 20),
          ElevatedButton(
            onPressed: () {
              // launch('https://example.com/projects'); // Replace with actual URL
            },
            style: ElevatedButton.styleFrom(
              backgroundColor:
                  const Color.fromARGB(255, 226, 230, 120), // Set button color
              padding:
                  const EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
            ),
            child: const Text('View Projects'),
          ),
        ],
      ),
    );
  }
}

class YearButton extends StatelessWidget {
  final String year;
  final String url;

  const YearButton({required this.year, required this.url});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        // ignore: deprecated_member_use
        // launch(url);
      },
      style: ElevatedButton.styleFrom(
        backgroundColor:
            const Color.fromARGB(255, 172, 207, 236), // Set button color
      ),
      child: Text(year),
    );
  }
}
