import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:opso/modals/book_mark_model.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  group('HandleBookmark Tests', () {
    setUp(() {
      SharedPreferences.setMockInitialValues({});
    });

    test('should return empty list when no bookmarks are saved', () async {
      final bookmarks = await HandleBookmark.loadBookmarks();
      expect(bookmarks, isEmpty);
    });

    test('should save and load bookmarks correctly', () async {
      final bookmarksToSave = [
        {'title': 'GSSoC', 'screen': 'gssoc_screen'},
        {'title': 'LFX', 'screen': 'lfx_screen'},
      ];

      await HandleBookmark.saveBookmarks(bookmarksToSave);
      final loadedBookmarks = await HandleBookmark.loadBookmarks();

      expect(loadedBookmarks.length, 2);
      expect(loadedBookmarks[0]['title'], 'GSSoC');
      expect(loadedBookmarks[1]['title'], 'LFX');
    });

    test('should add bookmark and prevent duplicates', () async {
      await HandleBookmark.addBookmark('GSSoC', 'gssoc_screen');
      
      var bookmarks = await HandleBookmark.loadBookmarks();
      expect(bookmarks.length, 1);
      expect(bookmarks[0]['title'], 'GSSoC');

      // Attempt to add duplicate
      await HandleBookmark.addBookmark('GSSoC', 'gssoc_screen');
      bookmarks = await HandleBookmark.loadBookmarks();
      expect(bookmarks.length, 1); // Should still be 1
    });

    test('should check if screen is bookmarked correctly', () async {
      expect(await HandleBookmark.isBookmarked('GSSoC'), isFalse);
      
      await HandleBookmark.addBookmark('GSSoC', 'gssoc_screen');
      expect(await HandleBookmark.isBookmarked('GSSoC'), isTrue);
    });

    test('should delete bookmark correctly', () async {
      await HandleBookmark.addBookmark('GSSoC', 'gssoc_screen');
      await HandleBookmark.addBookmark('LFX', 'lfx_screen');
      
      expect(await HandleBookmark.isBookmarked('GSSoC'), isTrue);
      expect(await HandleBookmark.isBookmarked('LFX'), isTrue);

      await HandleBookmark.deleteBookmark('GSSoC');
      
      expect(await HandleBookmark.isBookmarked('GSSoC'), isFalse);
      expect(await HandleBookmark.isBookmarked('LFX'), isTrue);
    });
  });
}
