import 'package:flutter/material.dart';
import 'package:opso/modals/book_mark_model.dart';
import 'package:opso/services/logger_service.dart';

class BookMarkScreen extends StatefulWidget {
  const BookMarkScreen({super.key});

  @override
  State<BookMarkScreen> createState() => _BookMarkScreenState();
}

class _BookMarkScreenState extends State<BookMarkScreen> {
  late Future<List<Map<String, String>>> bookmarks;

  @override
  void initState() {
    super.initState();
    bookmarks = HandleBookmark.loadBookmarks();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
         leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios),
         
          onPressed: () => Navigator.of(context).pop(),
        ),
        centerTitle: true,
        title: const Text(
          'Bookmarks',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      body: FutureBuilder<List<Map<String, String>>>(
        future: bookmarks,
        builder: (context, snapshot) {
          logger.debug("BookmarkScreen: FutureBuilder executing");
          logger.debug("BookmarkScreen: Snapshot data: ${snapshot.data}");
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return const Center(child: Text('Error loading bookmarks'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            logger.debug("BookmarkScreen: No bookmarks available");
            return const Center(child: Text('No bookmarks available'));
          } else {
            final bookmarks = snapshot.data!;
            return ListView.builder(
              itemCount: bookmarks.length,
              itemBuilder: (context, index) {
                final bookmark = bookmarks[index];
                return ListTile(
                  title: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(bookmark['title']!),
                      IconButton(
                        onPressed: () { 
                          Navigator.pushNamed(context, bookmark['screen']!);
                      }, 
                      icon: const Icon(Icons.arrow_forward))
                    ],

                  ),
                  onTap: () {
                    Navigator.pushNamed(context, bookmark['screen']!);
                  },
                );
              },
            );
          }
        },
      ),
    );
  }
}


