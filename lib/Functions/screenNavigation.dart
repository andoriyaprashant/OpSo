import 'package:flutter/material.dart';
import 'package:opso/Screens/girl_script.dart';
import 'package:opso/Screens/google_season_of_docs_screen.dart';
import 'package:opso/Screens/google_summer_of_code_screen.dart';
import 'package:opso/Screens/linuxFoundation.dart';
import 'package:opso/Screens/mlh.dart';
import 'package:opso/Screens/outreachy.dart';
import 'package:opso/Screens/summer_of_bitcoin.dart';

class screenNavigation {
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
              builder: (context) => const GSSOCScreen(),
            ));
        break;
      case 'Summer of Bitcoin':
        Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const SummerofBitcoin(),
            ));
        break;
      case 'Linux Foundation':
        Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const LinuxFoundation(),
            ));
        break;
      case 'Outreachy':
        Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const Outreachy(),
            ));
        break;

      default:
        break;
    }
  }
}
