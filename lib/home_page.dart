// ignore_for_file: prefer_const_constructors, use_key_in_widget_constructors, unused_import

import 'package:flutter/material.dart';
import 'package:opso/components/Mydrawer.dart';
import 'package:opso/components/programoptions.dart';
import 'package:opso/programs%20screen/girl_script.dart';
import 'package:opso/programs%20screen/mlh.dart';
import 'programs screen/google_season_of_docs_screen.dart';
import 'programs screen/google_summer_of_code_screen.dart';


class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Mydrawer(),
      appBar: AppBar(

        centerTitle: true,
        title: Text(
          'OPSA',
          style: TextStyle(fontWeight: FontWeight.w600, letterSpacing: 3),
        ),

      ),
      body: Container(
        margin: EdgeInsets.all(8),
        padding: EdgeInsets.all(8),
        child: ListView(
          children: [
            ProgramOption(
              title: 'Google Summer of Code',

              image: Image.asset(
                'assets/gsoc_logo.png',
                width: 50,
                height: 50,
              ),

              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(

                      builder: (context) => GoogleSummerOfCodeScreen()),

                );
              },
            ),
            SizedBox(height: 20),
            ProgramOption(

              title: 'Google season of docs',
              image: Image.asset(
                'assets/Google_season_of_docs.png',
                width: 50,
                height: 50,
              ),

              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(

                      builder: (context) => GoogleSeasonOfDocsScreen()),

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

              image: Image.asset(
                'assets/summer_of_bitcoin_logo.png',
                width: 50,
                height: 50,
              ),

              onTap: () {},
            ),
            SizedBox(height: 20),
            ProgramOption(
              title: 'Linux Foundation',

              image: Image.asset(
                'assets/linux_foundation_logo.png',
                width: 50,
                height: 50,
              ),

              onTap: () {},
            ),
            SizedBox(height: 20),
            ProgramOption(
              title: 'Outreachy',

              image: Image.asset(
                'assets/outreachy.png',
                width: 50,
                height: 50,
              ),

              onTap: () {},
            ),
            SizedBox(height: 20),
            ProgramOption(
              title: 'GirlScript Summer of Code',
              imageAssetPath: 'assets/girlscript_logo.png',
              onTap: () {
                Navigator.push(
                  context,

                  MaterialPageRoute(builder: (context) => GSSOCScreen()),
                );
              },
            ),
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
