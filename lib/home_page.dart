// ignore_for_file: prefer_const_constructors, use_key_in_widget_constructors, unused_import

import 'package:flutter/material.dart';
import 'package:opso/components/Mydrawer.dart';
import 'package:opso/components/programoptions.dart';
import 'package:opso/programs%20screen/girl_script.dart';
import 'package:opso/programs%20screen/mlh.dart';
import 'programs screen/google_season_of_docs_screen.dart';
import 'programs screen/google_summer_of_code_screen.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Mydrawer(),
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          'OPSA',
          style: TextStyle(fontWeight: FontWeight.w600, letterSpacing: 3),
        ),
      ),
      body: Container(
        margin: EdgeInsets.all(8),
        padding: EdgeInsets.all(8),
        child: ListView(
          children: [
            ProgramOption(
              title: 'Google Summer of Code',
              image: Image.asset(
                'assets/gsoc_logo.png',
                width: 50,
                height: 50,
              ),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => GoogleSummerOfCodeScreen()),
                );
              },
            ),
            SizedBox(height: 20),
            ProgramOption(
              title: 'Google season of docs',
              image: Image.asset(
                'assets/Google_season_of_docs.png',
                width: 50,
                height: 50,
              ),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => GoogleSeasonOfDocsScreen()),
                );
              },
            ),
            SizedBox(height: 20),
            ProgramOption(
              title: 'Major league hacking fellowship',
              image: Image.asset(
                'assets/mlh_logo.jpg',
                width: 50,
                height: 50,
              ),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => mlhfellow()),
                );
              },
            ),
            SizedBox(height: 20),
            ProgramOption(
              title: 'Summer of Bitcoin',
              image: Image.asset(
                'assets/summer_of_bitcoin_logo.png',
                width: 50,
                height: 50,
              ),
              onTap: () {},
            ),
            SizedBox(height: 20),
            ProgramOption(
              title: 'Linux Foundation',
              image: Image.asset(
                'assets/linux_foundation_logo.png',
                width: 50,
                height: 50,
              ),
              onTap: () {},
            ),
            SizedBox(height: 20),
            ProgramOption(
              title: 'Outreachy',
              image: Image.asset(
                'assets/outreachy.png',
                width: 50,
                height: 50,
              ),
              onTap: () {},
            ),
            SizedBox(height: 20),
            ProgramOption(
              title: 'GirlScript Summer of Code',
              image: Image.asset(
                'assets/girlscript_logo.png',
                width: 50,
                height: 50,
              ),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => GSSOCScreen()),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
