import 'package:flutter/material.dart';

class Program {
  final String title;
  final String imageAssetPath;

  Program({
    required this.title,
    required this.imageAssetPath,
  });
}

void navigateToScreen(BuildContext context, Program program) {
  switch (program.title) {
    case 'Google Summer of Code':
      Navigator.pushNamed(context, "/google_summer_of_code");

      break;

    case 'Google Season of Docs':
      Navigator.pushNamed(context, "/google_season_of_docs");

      break;

    case 'FOSSASIA Codeheat':
      Navigator.pushNamed(context, "/fossasia");

      break;

    case 'Major League Hacking Fellowship':
      Navigator.pushNamed(context, "/major_league_hacking_fellowship");

      break;

    case 'GirlScript Summer of Code':
      Navigator.pushNamed(context, "/girl_script_summer_of_code");

      break;

    case 'Social Winter of Code':
      Navigator.pushNamed(context, "/social_winter_of_code");

      break;

    case 'Season of KDE':
      Navigator.pushNamed(context, "/season_of_kde");

      break;

    case 'Hyperledger':
      Navigator.pushNamed(context, "/hyperledger");

      break;

    case 'Redox OS Summer of Code':
      Navigator.pushNamed(context, "/rsoc");

      break;

    case 'Outreachy':
      Navigator.pushNamed(context, "/outreachy");
      break;

    case 'Summer of Bitcoin':
      Navigator.pushNamed(context, "/summer_of_bitcoin");
      break;

    case 'Hacktoberfest':
      Navigator.pushNamed(context, "/Hacktoberfest");
      break;

    case 'Github Campus Expert':
      Navigator.pushNamed(context, "/GithubCampus");
      break;

    case 'Open Summer of Code':
      Navigator.pushNamed(context, "/open_summer_of_code");
      break;

    case 'Linux Foundation':
      Navigator.pushNamed(context, "/linux_foundation");
      break;

    default:
      break;
  }
}

void navigateToScreen2(
    BuildContext context, String title, List<Program> programs) {
  final Program selectedProgram =
      programs.firstWhere((program) => program.title == title);
  switch (selectedProgram.title) {
    case 'Google Summer of Code':
      Navigator.pushNamed(context, "/google_summer_of_code");

      break;

    case 'Google Season of Docs':
      Navigator.pushNamed(context, "/google_season_of_docs");

      break;

    case 'FOSSASIA Codeheat':
      Navigator.pushNamed(context, "/fossasia");

      break;

    case 'Major League Hacking Fellowship':
      Navigator.pushNamed(context, "/major_league_hacking_fellowship");

      break;

    case 'GirlScript Summer of Code':
      Navigator.pushNamed(context, "/girl_script_summer_of_code");

      break;

    case 'Social Winter of Code':
      Navigator.pushNamed(context, "/social_winter_of_code");

      break;

    case 'Season of KDE':
      Navigator.pushNamed(context, "/season_of_kde");

      break;

    case 'Hyperledger':
      Navigator.pushNamed(context, "/hyperledger");

      break;

    case 'Redox OS Summer of Code':
      Navigator.pushNamed(context, "/rsoc");

      break;

    case 'Outreachy':
      Navigator.pushNamed(context, "/outreachy");
      break;

    case 'Summer of Bitcoin':
      Navigator.pushNamed(context, "/summer_of_bitcoin");
      break;

    case 'Hacktoberfest':
      Navigator.pushNamed(context, "/Hacktoberfest");
      break;

    case 'Github Campus Expert':
      Navigator.pushNamed(context, "/GithubCampus");
      break;

    case 'Open Summer of Code':
      Navigator.pushNamed(context, "/open_summer_of_code");
      break;

    case 'Linux Foundation':
      Navigator.pushNamed(context, "/linux_foundation");
      break;

    default:
      break;
  }
}
