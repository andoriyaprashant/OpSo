import 'package:flutter/material.dart';
import 'package:opso/programs%20screen/girl_script.dart';
import 'package:opso/programs%20screen/google_season_of_docs_screen.dart';
import 'package:opso/programs%20screen/google_summer_of_code_screen.dart';
import 'package:opso/programs%20screen/linux_foundation.dart';
import 'package:opso/programs%20screen/major_league_hacking_fellowship.dart';
import 'package:opso/programs%20screen/outreachy.dart';
import 'package:opso/programs%20screen/summer_of_bitcoin.dart';
import 'package:opso/services/notificationService.dart';
import 'home_page.dart';


void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await NotificationService.initialNotification();
  runApp(OpSoApp());
}


class OpSoApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: '/',
      routes: {
        "/progarm_page" : (context) => HomePage(),
        "/girl_script_summer_of_code" : (context) => const GSSOCScreen(),
        "/google_summer_of_code" : (context) =>  GoogleSummerOfCodeScreen(),
        "/google_season_of_docs" : (context) => GoogleSeasonOfDocsScreen(),
        "/summer_of_bitcoin" : (context) => const BitcoinSummer(),
        "/outreachy" : (context) => const OutReachy(),
        "/major_league_hacking_fellowship" : (context) => const MajorLeagueHackingFellowship(),
        "/linux_foundation" : (context) => const LinuxFoundation(),
      },
      title: 'OpSo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,

      ),
      home: HomePage(),
    );
  }
}


