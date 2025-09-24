import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

import 'package:opso/programs screen/fossasia.dart';
import 'package:opso/programs screen/girl_script.dart';
import 'package:opso/programs screen/github_campus.dart';
import 'package:opso/programs screen/google_season_of_docs_screen.dart';
import 'package:opso/programs screen/google_summer_of_code_screen.dart';
import 'package:opso/programs screen/hacktoberfest_screen.dart';
import 'package:opso/programs screen/hyperledger.dart';
import 'package:opso/programs screen/linux_foundation.dart';
import 'package:opso/programs screen/major_league_hacking_fellowship.dart';
import 'package:opso/programs screen/open_summer_of_code.dart';
import 'package:opso/programs screen/outreachy.dart';
import 'package:opso/programs screen/redox.dart';
import 'package:opso/programs screen/season_of_kde.dart';
import 'package:opso/programs screen/summer_of_bitcoin.dart';
import 'package:opso/programs screen/social_winter_of_code.dart';
import 'package:opso/services/notificationService.dart';
import 'package:adaptive_theme/adaptive_theme.dart';
import 'package:opso/widgets/book_mark_screen.dart';

import 'home_page.dart';
import 'splash_screen.dart';
import 'github_api.dart';
import 'contributor_leaderboard_screen.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Temporarily comment out .env loading to avoid FileNotFoundError
  // await dotenv.load(fileName: ".env");

  try {
    await fetchContributors();
    print('Contributors fetched successfully at app start');
  } catch (e) {
    print('Error fetching contributors at app start: $e');
  }

  final savedThemeMode = await AdaptiveTheme.getThemeMode();
  await NotificationService.initialNotification();

  runApp(OpSoApp(savedThemeMode: savedThemeMode));
}

class OpSoApp extends StatelessWidget {
  final AdaptiveThemeMode? savedThemeMode;

  const OpSoApp({super.key, this.savedThemeMode});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(360, 690),
      minTextAdapt: true,
      splitScreenMode: false,
      builder: (_, child) {
        return AdaptiveTheme(
          light: ThemeData.light(),
          dark: ThemeData.dark(),
          initial: savedThemeMode ?? AdaptiveThemeMode.light,
          builder: (theme, darkTheme) => MaterialApp(
            title: 'OpSo',
            debugShowCheckedModeBanner: false,
            initialRoute: '/splash_screen',
            theme: theme,
            darkTheme: darkTheme,
            routes: {
              '/program_page': (context) => const HomePage(),
              '/progarm_page': (context) => const HomePage(), // ← Typo fix
              '/girl_script_summer_of_code': (context) => const GSSOCScreen(),
              '/social_winter_of_code': (context) => const SWOCScreen(),
              '/season_of_kde': (context) => const SeasonOfKDE(),
              '/google_summer_of_code': (context) =>
                  const GoogleSummerOfCodeScreen(),
              '/google_season_of_docs': (context) => GoogleSeasonOfDocsScreen(),
              '/summer_of_bitcoin': (context) => const SummerOfBitcoin(),
              '/fossasia': (context) => const FOSSASIA(),
              '/hacktoberfest': (context) => const Hacktoberfest(),
              '/open_summer_of_code': (context) => const OpenSummerOfCode(),
              '/hyperledger': (context) => const Hyperledger(),
              '/rsoc': (context) => const RsocPage(),
              '/outreachy': (context) => const OutreachyScreen(),
              '/major_league_hacking_fellowship': (context) =>
                  const MajorLeagueHackingFellowship(),
              '/linux_foundation': (context) => const LinuxFoundation(),
              '/github_campus': (context) => const GithubCampus(),
              '/contributor_leaderboard': (context) =>
                  const ContributorLeaderboardScreen(),
              '/splash_screen': (context) => SplashScreen(),
              '/bookmarks': (context) => const BookMarkScreen(),
            },
          ),
        );
      },
    );
  }
}
