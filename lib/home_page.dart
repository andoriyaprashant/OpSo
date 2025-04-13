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
import 'dart:math' as math;


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


  @override
  Widget build(BuildContext context) {
    // var media = MediaQuery.of(context).size;
    Color backgroundColor = Theme.of(context).brightness == Brightness.dark
        ? Colors.black.withOpacity(0.6) // Example dark mode color
        : Colors.white.withOpacity(0.6); // Example light mode color


    ScreenUtil.init(
      context,
    );
    final double appBarFontSize = ScreenUtil().setSp(18);
    final double appTextFontSize = ScreenUtil().setSp(20);
    final double SizedSize = ScreenUtil().setHeight(20);
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          'OpSo',
          style:
          TextStyle(fontWeight: FontWeight.bold, fontSize: appBarFontSize),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.search_sharp),
            onPressed: () {
              showSearch(context: context, delegate: ProgramSearchDelegate(), );
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
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const ChatBotPage(),
            ),
          );
        },
        child: const Icon(Icons.chat_bubble_outline),
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
                                  leading: Icon(
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
                                leading: const Icon(FontAwesomeIcons.bookmark),
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
                                leading: const Icon(FontAwesomeIcons.code),
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
                                leading: const Icon(
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
          MaterialPageRoute(
              builder: (context) => const SummerOfBitcoin()),
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
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => const OutreachyScreen(),
            ),
            );


      

      case 'Hacktoberfest':
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => const Hacktoberfest(),
            ),
            );
      
      case 'Github Campus Expert':
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => const GithubCampus(),
            ),
            );
      

      case 'Open Summer of Code':

        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => const OpenSummerOfCode(),
          ),
        );


      case 'Linux Foundation':
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => const LinuxFoundation(),
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
    super.key,
    required this.title,
    required this.imageAssetPath,
    required this.onTap,
  });


  @override
  Widget build(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    final borderColor = isDarkMode ? Colors.white : Colors.black45;
    return Column(
      children: [
        GestureDetector(
          onTap: onTap,
          child: Container(
            padding: EdgeInsets.all(ScreenUtil().setWidth(20)),
            decoration: BoxDecoration(
              // color: const Color.fromARGB(255, 237, 237, 239),
              borderRadius: BorderRadius.circular(15),
              border: Border.all(
                width: 1,
                color: borderColor,
              ),
            ),
            child: Row(
              children: [
                Image.asset(
                  imageAssetPath,
                  width: ScreenUtil().setWidth(50),
                  height: ScreenUtil().setHeight(50),
                ),
                SizedBox(width: ScreenUtil().setWidth(20)),
                Expanded(
                  child: Text(
                    title,
                    style: TextStyle(
                      fontSize: ScreenUtil().setSp(18),
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                const Icon(Icons.arrow_forward),
              ],
            ),
          ),
        ),
        SizedBox(height: ScreenUtil().setHeight(20)),
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


    return suggestionList.isNotEmpty ? ListView.builder(
      itemCount: suggestionList.length,
      itemBuilder: (context, index) => suggestionList[0] == '' ? Container(): ListTile(
        title: Text(suggestionList[index]),
        onTap: () {
          navigateToScreen(context, suggestionList[index]);
        },
      ),
    ) : Image.asset('assets/no-results.png');
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