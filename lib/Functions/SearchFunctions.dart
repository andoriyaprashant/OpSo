import 'package:flutter/material.dart';
import 'package:opso/Screens/girl_script.dart';
import 'package:opso/Screens/google_season_of_docs_screen.dart';
import 'package:opso/Screens/google_summer_of_code_screen.dart';
import 'package:opso/Screens/mlh.dart';
import 'package:opso/Screens/summer_of_bitcoin.dart';

class ProgramSearchDelegate extends SearchDelegate<String> {
  List<String> orgTitles = [
    'Google Summer of Code',
    'Google Season of Docs',
    'Major League Hacking Fellowship',
    'Summer of Bitcoin',
    'Linux Foundation',
    'Outreachy',
    'GirlScript Summer of Code',
  ];

  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        icon: const Icon(Icons.clear),
        onPressed: () {
          query = '';
        },
      ),
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.arrow_back),
      onPressed: () {
        close(context, '');
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    return Container();
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    final List<String> suggestionList = query.isEmpty
        ? []
        : orgTitles
            .where((title) => title.toLowerCase().contains(query.toLowerCase()))
            .toList();

    return ListView.builder(
      itemCount: suggestionList.length,
      itemBuilder: (context, index) => ListTile(
        title: Text(suggestionList[index]),
        onTap: () {
          navigateToScreen(context, suggestionList[index]);
        },
      ),
    );
  }

  void navigateToScreen(BuildContext context, String title) {
    switch (title) {
      case 'Google Summer of Code':
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => GoogleSummerOfCodeScreen(),
          ),
        );
        break;
      case 'Google Season of Docs':
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => GoogleSeasonOfDocsScreen(),
          ),
        );
        break;
      case 'Major League Hacking Fellowship':
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => mlhfellow(),
          ),
        );
        break;
      case 'GirlScript Summer of Code':
        Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const GSSOCScreen(),
            ));
        break;
      case 'Summer of Bitcoin':
        Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const SummerofBitcoin(),
            ));
        break;

      default:
        break;
    }
  }
}
