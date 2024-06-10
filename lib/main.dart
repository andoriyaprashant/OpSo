import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:opso/landing_page.dart';
import 'package:opso/programs%20screen/girl_script.dart';
import 'package:opso/programs%20screen/google_season_of_docs_screen.dart';
import 'package:opso/programs%20screen/google_summer_of_code_screen.dart';
import 'package:opso/programs%20screen/linux_foundation.dart';
import 'package:opso/programs%20screen/major_league_hacking_fellowship.dart';
import 'package:opso/programs%20screen/outreachy.dart';
import 'package:opso/programs%20screen/summer_of_bitcoin.dart';
import 'package:opso/programs%20screen/social_winter_of_code.dart';
import 'package:opso/services/notificationService.dart';
import 'home_page.dart';
import 'package:adaptive_theme/adaptive_theme.dart';
import 'splash_screen.dart'; 

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await NotificationService.initialNotification();
  runApp(const OpSoApp());
}

class OpSoApp extends StatelessWidget {
  const OpSoApp({super.key});

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
            initial: AdaptiveThemeMode.system,
            builder: (theme, darkTheme) => MaterialApp(
              initialRoute: '/splash_screen', 
              routes: {
                "/progarm_page": (context) => const HomePage(),
                "/girl_script_summer_of_code": (context) => const GSSOCScreen(),
                "/social_winter_of_code": (context) => const SWOCScreen(),
                "/google_summer_of_code": (context) =>
                    GoogleSummerOfCodeScreen(),
                "/google_season_of_docs": (context) =>
                    GoogleSeasonOfDocsScreen(),
                "/summer_of_bitcoin": (context) => const SummerOfBitcoin(),
                "/outreachy": (context) => const OutReachy(),
                "/major_league_hacking_fellowship": (context) =>
                    const MajorLeagueHackingFellowship(),
                "/linux_foundation": (context) => const LinuxFoundation(),
                "/landing_page": (context) => const LandingPage(),
                '/splash_screen': (context) => SplashScreen(), 
              },
              title: 'OpSo',
              debugShowCheckedModeBanner: false,
              theme: theme,
              darkTheme: darkTheme,
              // theme: ThemeData(
              //   primarySwatch: Colors.blue,
              //   visualDensity: VisualDensity.adaptivePlatformDensity,
              // ),
              home: const HomePage(),
              
            ),
          );
        });
  }
}