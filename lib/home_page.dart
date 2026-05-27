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
// import 'package:opso/programs%20screen/google_season_of_docs_screen.dart';
import 'package:opso/programs%20screen/google_summer_of_code_screen.dart';
import 'package:opso/programs%20screen/hacktoberfest_screen.dart';
import 'package:opso/programs%20screen/hyperledger.dart';
import 'package:opso/programs%20screen/linux_foundation.dart';
import 'package:opso/programs%20screen/major_league_hacking_fellowship.dart';
// import 'package:opso/programs%20screen/open_summer_of_code.dart';
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
    /*Program( PROGRAM CONCLUDED
      title: 'Google Season of Docs',
      imageAssetPath: 'assets/Google_season_of_docs.png',
    ),*/
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
    /*Program( NOT DONE IN 2025 NO INFORMATION ABOUT 2026
      title: 'Open Summer of Code',
      imageAssetPath: 'assets/open_summer_of_code.png',
    ),*/
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
          filter: ImageFilter.blur(sigmaX: 10.0, sigmaY: 10.0),
          child: Builder(builder: (context) {
            // Detect current theme
            final bool isDarkMode =
                Theme.of(context).brightness == Brightness.dark;

            return Container(
              // Swaps background based on theme
              color: isDarkMode
                  ? const Color(0xFF121212).withOpacity(0.85)
                  : Colors.white.withOpacity(0.85),
              child: SafeArea(
                child: Padding(
                  padding:
                      EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // --- HEADER (Adaptive Colors) ---
                      Padding(
                        padding:
                            EdgeInsets.only(left: 4.w, top: 8.h, bottom: 4.h),
                        child: Row(
                          children: [
                            Icon(Icons.widgets_rounded,
                                color:
                                    isDarkMode ? Colors.white : Colors.black87,
                                size: 22.sp),
                            SizedBox(width: 12.w),
                            Text(
                              'OpSo Menu',
                              style: TextStyle(
                                color:
                                    isDarkMode ? Colors.white : Colors.black87,
                                fontSize: 18.sp,
                                fontWeight: FontWeight.bold,
                                letterSpacing: 0.5,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Divider(
                        color: isDarkMode
                            ? Colors.white.withOpacity(0.15)
                            : Colors.black.withOpacity(0.1),
                        thickness: 1,
                        height: 24.h,
                      ),

                      // --- MENU GRID ---
                      Expanded(
                        child: SingleChildScrollView(
                          physics: const BouncingScrollPhysics(),
                          child: Column(
                            children: [
                              _buildDrawerCard(
                                title: 'Bookmarks',
                                subtitle: 'Manage saved programs',
                                icon: FontAwesomeIcons.bookmark,
                                gradient: const LinearGradient(
                                  colors: [
                                    Color(0xFF2563EB),
                                    Color(0xFF7C3AED)
                                  ],
                                  begin: Alignment.topLeft,
                                  end: Alignment.bottomRight,
                                ),
                                onTap: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              const BookMarkScreen()));
                                },
                              ),
                              SizedBox(height: 10.h),
                              Row(
                                children: [
                                  Expanded(
                                    child: _buildDrawerCard(
                                      title: 'Theme',
                                      subtitle: 'Toggle UI',
                                      icon:
                                          AdaptiveTheme.of(context).mode.isDark
                                              ? FontAwesomeIcons.solidSun
                                              : FontAwesomeIcons.solidMoon,
                                      gradient: const LinearGradient(
                                        colors: [
                                          Color(0xFF059669),
                                          Color(0xFF10B981)
                                        ],
                                        begin: Alignment.topLeft,
                                        end: Alignment.bottomRight,
                                      ),
                                      onTap: () {
                                        setState(() {
                                          AdaptiveTheme.of(context)
                                              .toggleThemeMode(
                                                  useSystem: false);
                                        });
                                      },
                                    ),
                                  ),
                                  SizedBox(width: 10.w),
                                  Expanded(
                                    child: _buildDrawerCard(
                                      title: 'FAQs',
                                      subtitle: 'Get help',
                                      icon:
                                          FontAwesomeIcons.solidCircleQuestion,
                                      gradient: const LinearGradient(
                                        colors: [
                                          Color(0xFFEA580C),
                                          Color(0xFFF97316)
                                        ],
                                        begin: Alignment.topLeft,
                                        end: Alignment.bottomRight,
                                      ),
                                      onTap: () {
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    FAQPage()));
                                      },
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(height: 10.h),
                              _buildDrawerCard(
                                title: 'GitHub Workflow',
                                subtitle: 'Learn open-source basics',
                                icon: FontAwesomeIcons.code,
                                gradient: const LinearGradient(
                                  colors: [
                                    Color(0xFF0284C7),
                                    Color(0xFF3B82F6)
                                  ],
                                  begin: Alignment.topLeft,
                                  end: Alignment.bottomRight,
                                ),
                                onTap: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              LearningPathPage()));
                                },
                              ),
                              SizedBox(height: 10.h),
                              Row(
                                children: [
                                  Expanded(
                                    child: _buildDrawerCard(
                                      title: 'Timeline',
                                      subtitle: 'Schedules',
                                      icon: FontAwesomeIcons.timeline,
                                      gradient: const LinearGradient(
                                        colors: [
                                          Color(0xFF0D9488),
                                          Color(0xFF14B8A6)
                                        ],
                                        begin: Alignment.topLeft,
                                        end: Alignment.bottomRight,
                                      ),
                                      onTap: () {
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    const OpsoTimeLineScreen()));
                                      },
                                    ),
                                  ),
                                  SizedBox(width: 10.w),
                                  Expanded(
                                    child: _buildDrawerCard(
                                      title: 'About',
                                      subtitle: 'App info',
                                      icon: FontAwesomeIcons.circleInfo,
                                      gradient: const LinearGradient(
                                        colors: [
                                          Color(0xFF4B5563),
                                          Color(0xFF6B7280)
                                        ],
                                        begin: Alignment.topLeft,
                                        end: Alignment.bottomRight,
                                      ),
                                      onTap: () {
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    AboutScreen()));
                                      },
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(height: 20.h),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          }),
        ),
      ),
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            expandedHeight: 230.h, // Slightly increased to fit the new widget
            floating: false,
            pinned: true,
            centerTitle: true,
            elevation: 0,
            backgroundColor: Colors.orange[400],
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.vertical(
                bottom: Radius.circular(30.r),
              ),
            ),
            leadingWidth: 65.w,
            leading: Builder(
              builder: (BuildContext scaffoldContext) => Padding(
                padding: EdgeInsets.only(left: 16.w, top: 8.h, bottom: 8.h),
                child: InkWell(
                  borderRadius: BorderRadius.circular(14.r),
                  onTap: () => Scaffold.of(scaffoldContext).openDrawer(),
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.25),
                      borderRadius: BorderRadius.circular(14.r),
                    ),
                    child: Center(
                      child: Icon(
                        Icons.menu,
                        color: Colors.white,
                        size: 22.sp,
                      ),
                    ),
                  ),
                ),
              ),
            ),
            actions: [
              Padding(
                padding: EdgeInsets.only(right: 16.w, top: 8.h, bottom: 8.h),
                child: InkWell(
                  borderRadius: BorderRadius.circular(14.r),
                  onTap: () {
                    showSearch(
                      context: context,
                      delegate: ProgramSearchDelegate(),
                    );
                  },
                  child: Container(
                    width: 49.w,
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.25),
                      borderRadius: BorderRadius.circular(14.r),
                    ),
                    child: Center(
                      child: Icon(
                        Icons.search_sharp,
                        color: Colors.white,
                        size: 22.sp,
                      ),
                    ),
                  ),
                ),
              ),
            ],
            flexibleSpace: FlexibleSpaceBar(
              centerTitle: true,
              titlePadding: EdgeInsets.only(bottom: 16.h),
              title: Text(
                'OpSo',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: appBarFontSize,
                  color: Colors.white,
                ),
              ),
              background: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.vertical(
                    bottom: Radius.circular(30.r),
                  ),
                  gradient: LinearGradient(
                    colors: [Colors.orange[400]!, Colors.orange[600]!],
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                  ),
                ),
                child: SafeArea(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(height: 10.h),
                      Text(
                        'WELCOME TO OpSo',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 18.sp,
                          fontWeight: FontWeight.w900,
                          letterSpacing: 1.6,
                        ),
                      ),
                      SizedBox(height: 2.h),
                      Text(
                        'the open source hub',
                        style: TextStyle(
                          color: Colors.white70,
                          fontSize: 13.sp,
                          fontStyle: FontStyle.italic,
                          letterSpacing: 1.1,
                        ),
                      ),
                      SizedBox(height: 10.h),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 28.w),
                        child: Text(
                          'Discover programs, kickstart your path, and contribute to great projects.',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Colors.white60,
                            fontSize: 11.sp,
                            height: 1.3,
                          ),
                        ),
                      ),
                      SizedBox(height: 15.h),
                      // --- NEW TRANSPARENT PROGRAM COUNT BOX ---
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 6.h),
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.2),
                          borderRadius: BorderRadius.circular(20.r),
                          border: Border.all(color: Colors.white.withOpacity(0.3), width: 1),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(Icons.library_books, color: Colors.white, size: 14.sp),
                            SizedBox(width: 8.w),
                            Text(
                              '${programs.length} Programs',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 12.sp,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 20.h),
                    ],
                  ),
                ),
              ),
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


      /*case 'Google Season of Docs':
        Navigator.push( PROGRAM CONCLUDED
          context,
          MaterialPageRoute(
            builder: (context) => GoogleSeasonOfDocsScreen(),
          ),
        );
        break;*/

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
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => const OutreachyScreen(),
            ),
            );
        break;
      

      /*case 'Open Summer of Code':
        NOT DONE IN 2025 NO INFORMATION ABOUT 2026      
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
        );*/

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
    /*Program( PROGRAM CONCLUDED
      title: 'Google Season of Docs',
      imageAssetPath: 'assets/Google_season_of_docs.png',
    ),*/
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
    /*Program(NOT DONE IN 2025 NO INFORMATION ABOUT 2026
      title: 'Open Summer of Code',
      imageAssetPath: 'assets/open_summer_of_code.png',
    ),*/
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

      /*case 'Google Season of Docs':
        Navigator.push( PROGRAM CONCLUDED
          context,
          MaterialPageRoute(
            builder: (context) => GoogleSeasonOfDocsScreen(),
          ),
        );
        break;*/

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