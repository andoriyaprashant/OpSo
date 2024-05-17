import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

class HandleBookmark {
  static Future<List<Map<String, String>>> loadBookmarks() async {
    final prefs = await SharedPreferences.getInstance();
    final jsonString = prefs.getString("bookmark_list");
    if (jsonString != null) {
      final List<dynamic> jsonList = json.decode(jsonString);
      return jsonList.map((json) => Map<String, String>.from(json)).toList();
    }
    return [];
  }

  static Future<void> saveBookmarks(List<Map<String, String>> bookmarks) async {
    final prefs = await SharedPreferences.getInstance();
    final jsonString = json.encode(bookmarks);
    await prefs.setString("bookmark_list", jsonString);
  }

  // Add a bookmark
static Future<void> addBookmark(String title, String screen) async {
    final prefs = await SharedPreferences.getInstance();
    final bookmarks = await loadBookmarks();

    // Check if the bookmark already exists
    bool isDuplicate = bookmarks.any((b) => b['title'] == title);
    if (!isDuplicate) {
      Map<String, String> newBookmark = {'title': title, 'screen': screen};
      bookmarks.add(newBookmark);
      final jsonString = json.encode(bookmarks);
      await prefs.setString("bookmark_list", jsonString);
    }
  }

  // Delete a bookmark
  static Future<void> deleteBookmark(String title) async {
    final bookmarks = await loadBookmarks();
    bookmarks.removeWhere((bookmark) => bookmark["title"] == title);
    await saveBookmarks(bookmarks);
  }

   static Future<bool> isBookmarked(String title) async {
    final bookmarks = await loadBookmarks();
    return bookmarks.any((bookmark) => bookmark['title'] == title);
  }
}
