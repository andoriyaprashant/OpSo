import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:opso/programs%20screen/girl_script.dart';
import 'package:opso/programs%20screen/google_season_of_docs_screen.dart';
import 'package:opso/programs%20screen/google_summer_of_code_screen.dart';
import 'package:opso/programs%20screen/mlh.dart';
import 'package:opso/programs%20screen/summer_of_bitcoin.dart';
import 'package:opso/services/notificationService.dart';

import 'about.dart';
import 'bar.dart';

class HomePage extends StatefulWidget {
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  void initState() {
    showNotification();
    super.initState();
  }

//show various notification from here
  void showNotification() async {
    await NotificationService.showNotification(
      title: "OpSo",
      body: "Explore various Open-Source Programs",
    );
  }

//used to show the notification every 5 ms
  void showScheduleNotification() async {
    await NotificationService.showNotification(
        title: "OpSo",
        body: "Explore various Open-Source Programs",
        scheduled: true,
        interval: 5);
  }

  final List<Program> programs = [
    Program(
      title: 'Google Summer of Code',
      imageAssetPath: 'assets/gsoc_logo.png',
    ),
    Program(
      title: 'Google Season of Docs',
      imageAssetPath: 'assets/Google_season_of_docs.png',
    ),
    Program(
      title: 'Major League Hacking Fellowship',
      imageAssetPath: 'assets/mlh_logo.jpg',
    ),
    Program(
      title: 'Summer of Bitcoin',
      imageAssetPath: 'assets/summer_of_bitcoin_logo.png',
    ),
    Program(
      title: 'Linux Foundation',
      imageAssetPath: 'assets/linux_foundation_logo.png',
    ),
    Program(
      title: 'Outreachy',
      imageAssetPath: 'assets/outreachy.png',
    ),
    Program(
      title: 'GirlScript Summer of Code',
      imageAssetPath: 'assets/girlscript_logo.png',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    var media = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'OpSo',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.search_sharp),
            onPressed: () {
              showSearch(context: context, delegate: ProgramSearchDelegate());
            },
          ),
          /*IconButton(
            icon: Icon(Icons.menu),
            onPressed: () {
              // Open drawer when the menu icon is clicked
              Scaffold.of(context).openDrawer();
            },
          ),*/
        ],
      ),
      drawer: Drawer(
        backgroundColor: Colors.transparent,
        width: MediaQuery.of(context).size.width,
        child: BackdropFilter(
          filter: ImageFilter.blur(
            sigmaX: 5.0,
            sigmaY: 5,
          ),
          child: Stack(
            children: [
              Container(
                width: MediaQuery.of(context).size.width * 0.70,
                decoration: BoxDecoration(color: Colors.white),
                child: SafeArea(
                  child: Padding(
                    padding: EdgeInsets.only(left: 30, right: 30, top: 30),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          height: kTextTabBarHeight,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Icon(FontAwesomeIcons.bars),
                              SizedBox(width: 10),
                              Text(
                                'Menu',
                                style: TextStyle(
                                  fontSize: 20,
                                  color: Colors.black,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(height: 15),
                        const Divider(
                          color: Colors.black26,
                          height: 1,
                        ),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const SizedBox(height: 15),
                              ListTile(
                                leading: Icon(FontAwesomeIcons.bookmark),
                                title: Text('Add Bookmark'),
                                onTap: () {},
                              ),
                              const SizedBox(height: 15),
                              ListTile(
                                leading: Icon(FontAwesomeIcons.circleInfo),
                                title: Text('About'),
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => AboutScreen(),
                                    ),
                                  );
                                },
                              ),
                              const SizedBox(height: 15),
                            ],
                          ),
                        ),
                        const Divider(
                          color: Colors.black26,
                          height: 1,
                        ),
                        const SizedBox(height: 15),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: programs.map((program) {
            return ProgramOption(
              title: program.title,
              imageAssetPath: program.imageAssetPath,
              onTap: () {
                navigateToScreen(context, program);
              },
            );
          }).toList(),
        ),
      ),
    );
  }

  void navigateToScreen(BuildContext context, Program program) {
    switch (program.title) {
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
          ),
        );
        break;
      case 'Summer of Bitcoin':
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => SummerOfBitcoin(),
          ),
        );
      default:
        break;
    }
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
    return Column(
      children: [
        GestureDetector(
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
        ),
        SizedBox(height: 20), // Adding SizedBox between each button
      ],
    );
  }
}

class ProgramSearchDelegate extends SearchDelegate<String> {
  final List<Program> programs = [
    Program(
      title: 'Google Summer of Code',
      imageAssetPath: 'assets/gsoc_logo.png',
    ),
    Program(
      title: 'Google Season of Docs',
      imageAssetPath: 'assets/Google_season_of_docs.png',
    ),
    Program(
      title: 'Major League Hacking Fellowship',
      imageAssetPath: 'assets/mlh_logo.jpg',
    ),
    Program(
      title: 'Summer of Bitcoin',
      imageAssetPath: 'assets/summer_of_bitcoin_logo.png',
    ),
    Program(
      title: 'Linux Foundation',
      imageAssetPath: 'assets/linux_foundation_logo.png',
    ),
    Program(
      title: 'Outreachy',
      imageAssetPath: 'assets/outreachy.png',
    ),
    Program(
      title: 'GirlScript Summer of Code',
      imageAssetPath: 'assets/girlscript_logo.png',
    ),
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
        : programs
            .where((program) =>
                program.title.toLowerCase().contains(query.toLowerCase()))
            .map((program) => program.title)
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
    final Program selectedProgram =
        programs.firstWhere((program) => program.title == title);
    switch (selectedProgram.title) {
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
          ),
        );
        break;
      default:
        break;
    }
  }
}

class Program {
  final String title;
  final String imageAssetPath;

  Program({
    required this.title,
    required this.imageAssetPath,
  });
}
