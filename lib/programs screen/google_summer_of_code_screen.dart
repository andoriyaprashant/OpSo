import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

void main() {
  runApp(MaterialApp(
    home: GoogleSummerOfCodeScreen(),
  ));
}

class GoogleSummerOfCodeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Google Summer of Code'),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
            child: Padding(
              padding: const EdgeInsets.only(top: 22, bottom: 14),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TextField(
                    decoration: InputDecoration(
                      hintText: 'Search',
                      prefixIcon: Icon(Icons.search),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30.0),
                      ),
                      contentPadding: EdgeInsets.symmetric(vertical: 12.0, horizontal: 20.0),
                    ),
                    onChanged: (value) {
                      // Handle search input
                    },
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 20),
                    child: SizedBox(height: 10),
                  ), // Adjust as needed
                  Text(
                    'Google Summer of Code is a global, online program focused on bringing new contributors into open source software development.',
                    style: TextStyle(fontSize: 19,fontWeight: FontWeight.w600, color: const Color.fromARGB(255, 75, 40, 136)),
                    
                  ),
                ],
              ),
            ),
          ),
          SizedBox(height: 20),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton.icon(
              onPressed: () {
                launch('https://summerofcode.withgoogle.com/programs/2024/projects');
              },
              style: ElevatedButton.styleFrom(
                padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 40.0),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
              ),
              icon: Icon(Icons.assignment),
              label: Text('View Projects(2024)'),
            ),
          ),
          SizedBox(height: 20),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton.icon(
              onPressed: () {
                launch('https://summerofcode.withgoogle.com/programs/2024/organizations');
              },
              style: ElevatedButton.styleFrom(
                padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 40.0),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
              ),
              icon: Icon(Icons.business),
              label: Text('View Organizations(2024)'),
            ),
          ),
          buildPastProgramsText(),
          SizedBox(height: 10),
          buildYearButtonsRow(['2020', '2021']),
          SizedBox(height: 30),
          buildYearButtonsRow(['2022', '2023']),
        ],
      ),
    );
  }

  Widget buildPastProgramsText() {
    return Container(
      margin: EdgeInsets.only(left: 55, top: 30, bottom: 15),
      child: Text(
        'Past Programs:',
        textAlign: TextAlign.left,
        style: TextStyle(
          fontSize: 22,
          fontWeight: FontWeight.bold,
          color: Colors.blue.shade900,
        ),
      ),
    );
  }

  Widget buildYearButtonsRow(List<String> years) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: years.map((year) {
        return YearButton(
          year: year,
          url: 'https://summerofcode.withgoogle.com/archive/$year/organizations',
        );
      }).toList(),
    );
  }
}


class YearButton extends StatelessWidget {
  final String year;
  final String url;

  const YearButton({required this.year, required this.url});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        launch(url);
      },
      style: ElevatedButton.styleFrom(
        backgroundColor: Color.fromARGB(255, 172, 207, 236),
        padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 50.0),
      ),
      child: Text(
        year,
        style: TextStyle(fontSize: 18), 
      ),
    );
  }
}

