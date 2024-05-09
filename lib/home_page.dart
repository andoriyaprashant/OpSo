import 'package:flutter/material.dart';
import 'package:opso/programs%20screen/girl_script.dart';
import 'package:opso/programs%20screen/mlh.dart';
import 'package:opso/programs%20screen/google_season_of_docs_screen.dart';
import 'package:opso/programs%20screen/google_summer_of_code_screen.dart';

import 'bar.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('OpSa'),
        actions: [
          IconButton(
            icon: Icon(Icons.search_sharp),
            onPressed: () {
              showSearch(context: context, delegate: ProgramSearchDelegate());
            },
          ),
          IconButton(
            icon: Icon(Icons.menu),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => AppBarWidget()),
              );
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            ProgramOption(
              title: 'Google Summer of Code',
              imageAssetPath: 'assets/gsoc_logo.png',
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => GoogleSummerOfCodeScreen(),
                  ),
                );
              },
            ),
            SizedBox(height: 20),
            ProgramOption(
              title: 'Google Season of Docs',
              imageAssetPath: 'assets/Google_season_of_docs.png',
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => GoogleSeasonOfDocsScreen(),
                  ),
                );
              },
            ),
            SizedBox(height: 20),
            ProgramOption(
              title: 'Major League Hacking Fellowship',
              imageAssetPath: 'assets/mlh_logo.jpg',
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => mlhfellow()),
                );
              },
            ),
            SizedBox(height: 20),
            ProgramOption(
              title: 'Summer of Bitcoin',
              imageAssetPath: 'assets/summer_of_bitcoin_logo.png',
              onTap: () {},
            ),
            SizedBox(height: 20),
            ProgramOption(
              title: 'Linux Foundation',
              imageAssetPath: 'assets/linux_foundation_logo.png',
              onTap: () {},
            ),
            SizedBox(height: 20),
            ProgramOption(
              title: 'Outreachy',
              imageAssetPath: 'assets/outreachy.png',
              onTap: () {},
            ),
            SizedBox(height: 20),
            ProgramOption(
              title: 'GirlScript Summer of Code',
              imageAssetPath: 'assets/girlscript_logo.png',
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => GSSOCScreen(),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}

class ProgramOption extends StatelessWidget {
  final String title;
  final String imageAssetPath;
  final VoidCallback onTap;

  const ProgramOption({
    required this.title,
    required this.imageAssetPath,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: Color.fromARGB(255, 237, 237, 239),
          borderRadius: BorderRadius.circular(15),
        ),
        child: Row(
          children: [
            Image.asset(
              imageAssetPath,
              width: 50,
              height: 50,
            ),
            SizedBox(width: 20),
            Expanded(
              child: Text(
                title,
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Icon(Icons.arrow_forward),
          ],
        ),
      ),
    );
  }
}

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
        icon: Icon(Icons.clear),
        onPressed: () {
          query = '';
        },
      ),
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: Icon(Icons.arrow_back),
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
              builder: (context) => GSSOCScreen(),
            ));
        break;

      default:
        break;
    }
  }
}
