import 'dart:ui';
import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:opso/opso_timeline.dart';
import 'package:opso/programs%20screen/girl_script.dart';
import 'package:opso/programs%20screen/google_season_of_docs_screen.dart';
import 'package:opso/programs%20screen/google_summer_of_code_screen.dart';
import 'package:opso/programs%20screen/linux_foundation.dart';
import 'package:opso/programs%20screen/major_league_hacking_fellowship.dart';
import 'package:opso/programs%20screen/outreachy.dart';
import 'package:opso/programs%20screen/summer_of_bitcoin.dart';
import 'package:opso/services/notificationService.dart';
import 'package:opso/widgets/book_mark_screen.dart';
import 'package:adaptive_theme/adaptive_theme.dart';

import 'about.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _initialLabelIndex = 0;

  @override
  void initState() {
    super.initState();
    _getInitialThemeMode();
    showNotification();
    showScheduleNotification();
  }

  void _getInitialThemeMode() async {
    final savedThemeMode = await AdaptiveTheme.getThemeMode();
    setState(() {
      if (savedThemeMode == AdaptiveThemeMode.light) {
        _initialLabelIndex = 0;
      } else if (savedThemeMode == AdaptiveThemeMode.dark) {
        _initialLabelIndex = 1;
      } else {
        _initialLabelIndex = 0;
      }
    });
  }

  void showNotification() async {
    await NotificationService.showNotification(
      title: "OpSo",
      body: "Explore various Open-Source Programs",
    );
  }

  void showScheduleNotification() async {
    await NotificationService.showNotification(
      title: "OpSo",
      body: "Explore various Open-Source Programs",
      scheduled: true,
      interval: 5,
    );
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
    Color backgroundColor = Theme.of(context).brightness == Brightness.dark
        ? Colors.black.withOpacity(0.6)
        : Colors.white.withOpacity(0.6);

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'OpSo',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.search_sharp),
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
                color: backgroundColor,
                child: SafeArea(
                  child: Padding(
                    padding: const EdgeInsets.only(left: 30, right: 30, top: 30),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(
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
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 15),
                        const Divider(
                          color: Colors.black26,
                          height: 1,
                        ),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const SizedBox(height: 15),
                              InkWell(
                                onTap: () {},
                                child: ListTile(
                                  leading: Icon(
                                    _initialLabelIndex == 0
                                        ? FontAwesomeIcons.solidSun
                                        : FontAwesomeIcons.solidMoon,
                                  ),
                                  title: const Text('Switch Theme'),
                                  onTap: () {
                                    setState(() {
                                      if (_initialLabelIndex == 0) {
                                        _initialLabelIndex = 1;
                                        AdaptiveTheme.of(context).setDark();
                                      } else {
                                        _initialLabelIndex = 0;
                                        AdaptiveTheme.of(context).setLight();
                                      }
                                    });
                                  },
                                ),
                              ),
                              const SizedBox(height: 15),
                              ListTile(
                                leading: const Icon(FontAwesomeIcons.bookmark),
                                title: const Text('Add Bookmark'),
                                onTap: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              const BookMarkScreen()));
                                },
                              ),
                              const SizedBox(height: 15),
                              ListTile(
                                leading: Transform.rotate(
                                  angle: 90 * math.pi / 180,
                                  child: const Icon(
                                    FontAwesomeIcons.timeline,
                                  ),
                                ),
                                title: const Text('Program Timeline'),
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) =>
                                          const OpsoTimeLineScreen(),
                                    ),
                                  );
                                },
                              ),
                              const SizedBox(height: 15),
                              ListTile(
                                leading:
                                    const Icon(FontAwesomeIcons.circleInfo),
                                title: const Text('About'),
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
            builder: (context) => const MajorLeagueHackingFellowship(),
          ),
        );
        break;

      case 'GirlScript Summer of Code':
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => const GSSOCScreen(),
          ),
        );
        break;

      case 'Outreachy':
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => const OutReachy()));
        break;

      case 'Summer of Bitcoin':
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => const SummerOfBitcoin(),
          ),
        );
        break;

      case 'Linux Foundation':
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => const LinuxFoundation()));
        break;

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
    super.key,
    required this.title,
    required this.imageAssetPath,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    final borderColor = isDarkMode ? Colors.white : Colors.black;

    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: Container(
        decoration: BoxDecoration(
          color: isDarkMode
              ? Colors.grey[800]?.withOpacity(0.6)
              : Colors.white.withOpacity(0.6),
          border: Border.all(color: borderColor),
          borderRadius: BorderRadius.circular(8.0),
        ),
        child: ListTile(
          leading: Image.asset(
            imageAssetPath,
            width: 40,
            height: 40,
          ),
          title: Text(
            title,
            style: TextStyle(
              color: isDarkMode ? Colors.white : Colors.black,
              fontWeight: FontWeight.bold,
            ),
          ),
          onTap: onTap,
        ),
      ),
    );
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

class ProgramSearchDelegate extends SearchDelegate<Program> {
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
        close(context, Program(title: '', imageAssetPath: ''));
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    final List<Program> matchQuery = [];
    for (var program in programs) {
      if (program.title.toLowerCase().contains(query.toLowerCase())) {
        matchQuery.add(program);
      }
    }

    return ListView.builder(
      itemCount: matchQuery.length,
      itemBuilder: (context, index) {
        var result = matchQuery[index];
        return ProgramOption(
          title: result.title,
          imageAssetPath: result.imageAssetPath,
          onTap: () {
            close(context, result);
            navigateToScreen(context, result);
          },
        );
      },
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    final List<Program> matchQuery = [];
    for (var program in programs) {
      if (program.title.toLowerCase().contains(query.toLowerCase())) {
        matchQuery.add(program);
      }
    }

    return ListView.builder(
      itemCount: matchQuery.length,
      itemBuilder: (context, index) {
        var result = matchQuery[index];
        return ProgramOption(
          title: result.title,
          imageAssetPath: result.imageAssetPath,
          onTap: () {
            query = result.title;
            showResults(context);
          },
        );
      },
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
            builder: (context) => const MajorLeagueHackingFellowship(),
          ),
        );
        break;

      case 'GirlScript Summer of Code':
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => const GSSOCScreen(),
          ),
        );
        break;

      case 'Outreachy':
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => const OutReachy()));
        break;

      case 'Summer of Bitcoin':
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => const SummerOfBitcoin(),
          ),
        );
        break;

      case 'Linux Foundation':
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => const LinuxFoundation()));
        break;

      default:
        break;
    }
  }
}
