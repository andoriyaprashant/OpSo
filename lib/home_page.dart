import 'dart:ui';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:opso/ChatBotpage.dart';
import 'package:opso/learning_path.dart';
import 'package:opso/opso_timeline.dart';
import 'package:opso/programs%20screen/djangonautspace.dart';
import 'package:opso/programs%20screen/fossasia.dart';
import 'package:opso/programs%20screen/girl_script.dart';
import 'package:opso/programs%20screen/github_campus.dart';
import 'package:opso/programs%20screen/google_season_of_docs_screen.dart';
import 'package:opso/programs%20screen/google_summer_of_code_screen.dart';
import 'package:opso/programs%20screen/hacktoberfest_screen.dart';
import 'package:opso/programs%20screen/hyperledger.dart';
import 'package:opso/programs%20screen/linux_foundation.dart';
import 'package:opso/programs%20screen/major_league_hacking_fellowship.dart';
import 'package:opso/programs%20screen/open_summer_of_code.dart';
import 'package:opso/programs%20screen/outreachy.dart';
import 'package:opso/programs%20screen/redox.dart';
import 'package:opso/programs%20screen/season_of_kde.dart';
import 'package:opso/programs%20screen/summer_of_bitcoin.dart';
import 'package:opso/programs%20screen/social_winter_of_code.dart';
import 'package:opso/services/notificationService.dart';
import 'package:opso/widgets/book_mark_screen.dart';
import 'package:adaptive_theme/adaptive_theme.dart';
import 'package:opso/widgets/faq.dart';

import 'about.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    showNotification();
    super.initState();

    _getInitialThemeMode();
  }

  int _initialLabelIndex = 0;
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
      title: 'FOSSASIA Codeheat',
      imageAssetPath: 'assets/fossasia.png',
    ),
    Program(
      title: 'Major League Hacking Fellowship',
      imageAssetPath: 'assets/mlh_logo.jpg',
    ),
    Program(
      title: 'Djangonaut Space',
      imageAssetPath: 'assets/djangonaut.png',
    ),
    Program(
      title: 'Summer of Bitcoin',
      imageAssetPath: 'assets/summer_of_bitcoin_logo.png',
    ),
    Program(
      title: 'Hyperledger',
      imageAssetPath: 'assets/hyperledger.png',
    ),
    Program(
      title: 'Linux Foundation',
      imageAssetPath: 'assets/linux_foundation_logo.png',
    ),
    Program(
      title: 'Hacktoberfest',
      imageAssetPath: 'assets/hacktoberfest.png',
    ),
    Program(
      title: 'Github Campus Expert',
      imageAssetPath: 'assets/git_campus_logo.png',
    ),
    Program(
      title: 'Outreachy',
      imageAssetPath: 'assets/outreachy.png',
    ),
    Program(
      title: 'GirlScript Summer of Code',
      imageAssetPath: 'assets/girlscript_logo.png',
    ),
    Program(
      title: 'Social Winter of Code',
      imageAssetPath: 'assets/swoc.png',
    ),
    Program(
      title: 'Season of KDE',
      imageAssetPath: 'assets/sokde.png',
    ),
    Program(
      title: 'Redox OS Summer of Code',
      imageAssetPath: 'assets/redox.png',
    ),
    Program(
      title: 'Open Summer of Code',
      imageAssetPath: 'assets/open_summer_of_code.png',
    ),
  ];

  Widget _buildDrawerCard({
    required String title,
    required String subtitle,
    required dynamic icon, // dynamic to accept both FaIconData and IconData
    required Gradient gradient,
    required VoidCallback onTap,
  }) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(16.r),
        child: Container(
          padding: EdgeInsets.all(12.w),
          decoration: BoxDecoration(
            gradient: gradient,
            borderRadius: BorderRadius.circular(16.r),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    padding: EdgeInsets.all(6.w),
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.15),
                      borderRadius: BorderRadius.circular(10.r),
                      border: Border.all(
                          color: Colors.white.withOpacity(0.3), width: 0.5),
                    ),
                    child: FaIcon(icon, color: Colors.white, size: 16.sp),
                  ),
                  Icon(Icons.arrow_outward,
                      color: Colors.white.withOpacity(0.6), size: 14.sp),
                ],
              ),
              SizedBox(height: 16.h),
              Text(
                title,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 14.sp,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 0.5,
                ),
              ),
              SizedBox(height: 2.h),
              Text(
                subtitle,
                style: TextStyle(
                  color: Colors.white.withOpacity(0.8),
                  fontSize: 10.sp,
                ),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(
      context,
    );
    final double appBarFontSize = ScreenUtil().setSp(18);

    return Scaffold(
      floatingActionButton: Padding(
        padding: const EdgeInsets.only(right: 16.0, bottom: 16.0),
        child: FloatingActionButton.extended(
          elevation: 50,
          backgroundColor: Colors.orange[400],
          foregroundColor: Colors.white,
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const ChatBotPage(),
              ),
            );
          },
          icon: const FaIcon(
            FontAwesomeIcons.robot,
          ),
          label: const Text(
            'ChatBot',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              letterSpacing: 0.5,
            ),
          ),
        ),
      ),
      drawer: Drawer(
        backgroundColor: Colors.transparent,
        width: MediaQuery.of(context).size.width * 0.75,
        child: BackdropFilter(
          filter: ImageFilter.blur(
            sigmaX: 5.0,
            sigmaY: 5,
          ),
          child: GestureDetector(
            behavior: HitTestBehavior.translucent,
            onTap: () => Navigator.pop(context),
            child: Stack(
              children: [
                GestureDetector(
                  behavior: HitTestBehavior.opaque,
                  onTap: () {}, // Consume taps inside the drawer to prevent dismissing
                  child: Container(
                    width: MediaQuery.of(context).size.width * 0.70,
                    color: backgroundColor,
                    // decoration: const BoxDecoration(color: Colors.white),
                    child: SafeArea(
                      child: Padding(
                        padding:
                        const EdgeInsets.only(left: 30, right: 30, top: 30),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(
                              height: kTextTabBarHeight,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  IconButton(
                                    icon: Icon(Icons.close),
                                    onPressed: () => Navigator.pop(context),
                                  ),
                                  SizedBox(
                                    width: ScreenUtil().setWidth(10),
                                  ),
                                  Text(
                                    'Menu',
                                    style: TextStyle(
                                      fontSize: appTextFontSize,
                                      // color: Colors.black,
                                      fontWeight: FontWeight.w700,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(height: ScreenUtil().setHeight(15)),
                            const Divider(
                              color: Colors.black26,
                              height: 1,
                            ),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  SizedBox(height: ScreenUtil().setHeight(15)),
                                  InkWell(
                                    onTap: () {},
                                    child: ListTile(
                                      leading: FaIcon(
                                        AdaptiveTheme.of(context).mode.isDark
                                            ? FontAwesomeIcons.solidSun
                                            : FontAwesomeIcons.solidMoon,
                                      ),
                                      title: const Text('Switch Theme'),
                                      onTap: () {
                                        setState(() {
                                          AdaptiveTheme.of(context)
                                              .toggleThemeMode(useSystem: false);
                                        });
                                      },
                                    ),
                                  ),
                                  const SizedBox(height: 15),
                                  ListTile(
                                    leading: const FaIcon(FontAwesomeIcons.bookmark),
                                    title: const Text('Bookmarks'),
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
                                    leading: const FaIcon(FontAwesomeIcons.code),
                                    title: const Text('GitHub Workflow'),
                                    onTap: () {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                              LearningPathPage()));
                                    },
                                  ),
                                  const SizedBox(height: 15),
                                  ListTile(
                                    leading: Transform.rotate(
                                      angle: 90 * math.pi / 180,
                                      child: const FaIcon(
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
                                    leading: const FaIcon(
                                        FontAwesomeIcons.solidCircleQuestion),
                                    title: const Text('Freuently Asked Questions'),
                                    onTap: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) =>
                                              FAQPage(),
                                        ),
                                      );
                                    },
                                  ),
                                  SizedBox(height: ScreenUtil().setHeight(15)),
                                  ListTile(
                                    leading:
                                    const FaIcon(FontAwesomeIcons.circleInfo),
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
                                  SizedBox(height: ScreenUtil().setHeight(15)),
                                ],
                              ),
                            ),
                            const Divider(
                              color: Colors.black26,
                              height: 1,
                            ),
                            SizedBox(height: ScreenUtil().setHeight(15)),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          SliverPadding(
            padding: EdgeInsets.all(16.w),
            sliver: SliverGrid(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 16.w,
                mainAxisSpacing: 16.h,
                childAspectRatio: 0.82,
              ),
              delegate: SliverChildBuilderDelegate(
                (BuildContext context, int index) {
                  final program = programs[index];
                  return ProgramOption(
                    title: program.title,
                    imageAssetPath: program.imageAssetPath,
                    onTap: () {
                      navigateToScreen(context, program);
                    },
                  );
                },
                childCount: programs.length,
              ),
            ),
          ),
        ],
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

      case 'FOSSASIA Codeheat':
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => FOSSASIA(),
          ),
        );
        break;

      case 'Major League Hacking Fellowship':
        Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => const MajorLeagueHackingFellowship()),
        );
        break;

      case 'Djangonaut Space':
        Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => const DjangonautSpaceProgram()),
        );
        break;

      case 'Summer of Bitcoin':
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const SummerOfBitcoin()),
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

      case 'Social Winter of Code':
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => const SWOCScreen(),
          ),
        );
        break;

      case 'Season of KDE':
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => const SeasonOfKDE(),
          ),
        );
        break;

      case 'Hyperledger':
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => const Hyperledger(),
          ),
        );
        break;

      case 'Redox OS Summer of Code':
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => const RsocPage(),
          ),
        );
        break;

      case 'Outreachy':
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => const OutreachyScreen(),
          ),
        );
        break;

      case 'Hacktoberfest':
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => const Hacktoberfest(),
          ),
        );
        break;

      case 'Github Campus Expert':
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => const GithubCampus(),
          ),
        );
        break;

      case 'Open Summer of Code':
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => const OpenSummerOfCode(),
          ),
        );
        break;

      case 'Linux Foundation':
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => const LinuxFoundation(),
          ),
        );
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

    return Container(
      decoration: BoxDecoration(
        color: isDarkMode ? Colors.grey[900] : Colors.white,
        borderRadius: BorderRadius.circular(16.r),
        boxShadow: [
          BoxShadow(
            color: isDarkMode ? Colors.black45 : Colors.grey.withOpacity(0.15),
            spreadRadius: 1,
            blurRadius: 6,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(16.r),
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 14.h),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(
                  flex: 4,
                  child: Center(
                    child: Container(
                      padding: EdgeInsets.all(4.w),
                      decoration: BoxDecoration(
                          color: Colors.white,
                          shape: BoxShape.circle,
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.05),
                              blurRadius: 4,
                            )
                          ]),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(25.r),
                        child: Image.asset(
                          imageAssetPath,
                          width: 50.w,
                          height: 50.h,
                          fit: BoxFit.contain,
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 8.h),
                Expanded(
                  flex: 3,
                  child: Text(
                    title,
                    textAlign: TextAlign.center,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontSize: 13.sp,
                      fontWeight: FontWeight.w700,
                      height: 1.2,
                      color: isDarkMode ? Colors.white : Colors.black87,
                    ),
                  ),
                ),
                Icon(
                  Icons.arrow_forward_rounded,
                  size: 16.sp,
                  color: Colors.orange[400], // Changed to match orange theme
                ),
              ],
            ),
          ),
        ),
      ),
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
      title: 'FOSSASIA Codeheat',
      imageAssetPath: 'assets/fossasia.png',
    ),
    Program(
      title: 'Major League Hacking Fellowship',
      imageAssetPath: 'assets/mlh_logo.jpg',
    ),
    Program(
      title: 'Djangonaut Space',
      imageAssetPath: 'assets/djangonaut.png',
    ),
    Program(
      title: 'Hyperledger',
      imageAssetPath: 'assets/hyperledger.png',
    ),
    Program(
      title: 'Summer of Bitcoin',
      imageAssetPath: 'assets/summer_of_bitcoin_logo.png',
    ),
    Program(
      title: 'Hacktoberfest',
      imageAssetPath: 'assets/hacktoberfest.png',
    ),
    Program(
      title: 'Github Campus Expert',
      imageAssetPath: 'assets/git_campus_logo.png',
    ),
    Program(
      title: 'Redox OS Summer of Code',
      imageAssetPath: 'assets/redox.png',
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
    Program(
      title: 'Social Winter of Code',
      imageAssetPath: 'assets/swoc.png',
    ),
    Program(
      title: 'Season of KDE',
      imageAssetPath: 'assets/sokde.png',
    ),
    Program(
      title: 'Open Summer of Code',
      imageAssetPath: 'assets/open_summer_of_code.png',
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
        ? ['']
        : programs
            .where((program) =>
                program.title.toLowerCase().contains(query.toLowerCase()))
            .map((program) => program.title)
            .toList();

    return suggestionList.isNotEmpty
        ? ListView.builder(
            itemCount: suggestionList.length,
            itemBuilder: (context, index) => suggestionList[0] == ''
                ? Container()
                : ListTile(
                    title: Text(suggestionList[index]),
                    onTap: () {
                      navigateToScreen(context, suggestionList[index]);
                    },
                  ),
          )
        : Image.asset('assets/no-results.png');
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

      case 'FOSSASIA Codeheat':
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => const FOSSASIA(),
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

      case 'Djangonaut Space':
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => const DjangonautSpaceProgram(),
          ),
        );
        break;

      case 'Summer of Bitcoin':
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => const SummerOfBitcoin(),
          ),
        );
        break;

      case 'Hyperledger':
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => const Hyperledger(),
          ),
        );
        break;

      case 'Redox OS Summer of Code':
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => const RsocPage(),
          ),
        );
        break;

      case 'Outreachy':
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => const OutreachyScreen(),
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

      case 'Social Winter of Code':
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => const SWOCScreen(),
          ),
        );
        break;

      case 'Season of KDE':
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => const SeasonOfKDE(),
          ),
        );
        break;

      case 'Hacktoberfest':
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => const Hacktoberfest(),
          ),
        );
        break;

      case 'Github Campus Expert':
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => const GithubCampus(),
          ),
        );
        break;

      case 'Linux Foundation':
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => const LinuxFoundation(),
          ),
        );
        break;

      case 'Open Summer of Code':
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => const OpenSummerOfCode(),
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