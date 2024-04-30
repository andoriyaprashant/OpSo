import 'package:flutter/material.dart';
import 'package:opso/programs%20screen/mlh.dart';

import 'programs screen/google_season_of_docs_screen.dart';
import 'programs screen/google_summer_of_code_screen.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('OpSa - Open Source Programs'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
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
    MaterialPageRoute(builder: (context) => GoogleSummerOfCodeScreen()),
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
    MaterialPageRoute(builder: (context) => GoogleSeasonOfDocsScreen()),
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
              onTap: () {
               
              },
            ),
            SizedBox(height: 20),
            ProgramOption(
              title: 'Linux Foundation',
              image: Image.asset(
                'assets/linux_foundation_logo.png',
                width: 50,
                height: 50,
              ),
              onTap: () {
               
              },
            ),
            SizedBox(height: 20),
             ProgramOption(
              title: 'Outreachy',
              image: Image.asset(
                'assets/outreachy.png',
                width: 50,
                height: 50,
              ),
              onTap: () {
               
              },
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
               
              },
            ),
           
          ],
        ),
      ),
    );
  }
}

class ProgramOption extends StatelessWidget {
  final String title;
  final Widget image;
  final VoidCallback onTap;

  const ProgramOption({
    required this.title,
    required this.image,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: Color.fromARGB(255, 237, 237, 239),
          borderRadius: BorderRadius.circular(15),
        ),
        child: Row(
          children: [
            SizedBox(
              width: 60, 
              height: 60,
              child: image,
            ),
            SizedBox(width: 20),
            Expanded(
              child: Text(
                title,
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Icon(Icons.arrow_forward),
          ],
        ),
      ),
    );
  }
}
