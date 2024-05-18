
import 'dart:async';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:opso/programs%20screen/girl_script.dart';
import 'package:opso/programs%20screen/google_season_of_docs_screen.dart';
import 'package:opso/programs%20screen/google_summer_of_code_screen.dart';
import 'package:opso/programs%20screen/linux_foundation.dart';
import 'package:opso/programs%20screen/major_league_hacking_fellowship.dart';
import 'package:opso/programs%20screen/outreachy.dart';
import 'package:opso/programs%20screen/summer_of_bitcoin.dart';
import 'package:opso/services/notificationService.dart';
import 'package:opso/widgets/book_mark_screen.dart';

import 'about.dart';

class HomePage extends StatefulWidget {
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    super.initState();
    showNotification();
    // Schedule notifications when the app starts
    showScheduleNotification();
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
          IconButton(
            icon: Icon(FontAwesomeIcons.bars),
            onPressed: () {
              Scaffold.of(context).openDrawer();
            },
          ),
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
                                onTap: () { Navigator.push(context, MaterialPageRoute(builder: (context) => BookMarkScreen()));},
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
            builder: (context) => MajorLeagueHackingFellowship()
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

      case 'Outreachy':
        Navigator.push(context, MaterialPageRoute(builder: (context) => OutReachy()));

      case 'Summer of Bitcoin' :
        Navigator.pushNamed(context, "/summer_of_bitcoin");

      case 'Summer of Bitcoin':
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => SummerOfBitcoin(),
          ),
        );
        
      case 'Linux Foundation' :
        Navigator.push(context, MaterialPageRoute(builder: (context) => LinuxFoundation()));
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
    required this.image
