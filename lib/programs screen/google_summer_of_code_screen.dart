import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import '../modals/GSoC/Gsoc.dart';
import '../services/ApiService.dart';

class GoogleSummerOfCodeScreen extends StatefulWidget {
  @override
  State<GoogleSummerOfCodeScreen> createState() => _GoogleSummerOfCodeScreenState();
}

class _GoogleSummerOfCodeScreenState extends State<GoogleSummerOfCodeScreen> {
  @override
  void initState() {
    getProjectData();
    super.initState();
  }
  void getProjectData() async{
    ApiService apiService = ApiService();
    try {
      Gsoc orgData = await apiService.getOrgByYear('2021');
      print("org data $orgData");
    } catch (e) {
      print('Error: $e');
    }
  }
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
            child: TextField(
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
          ),
          SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              YearButton(
                year: '2021',
                url: 'https://summerofcode.withgoogle.com/archive/2021/organizations', // Replace with actual URL
              ),
              YearButton(
                year: '2022',
                url: 'https://summerofcode.withgoogle.com/archive/2022/organizations', // Replace with actual URL
              ),
            ],
          ),
          SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              YearButton(
                year: '2023',
                url: 'https://summerofcode.withgoogle.com/archive/2023/organizations', // Replace with actual URL
              ),
              YearButton(
                year: '2024',
                url: 'https://summerofcode.withgoogle.com/archive/2024/organizations', // Replace with actual URL
              ),
            ],
          ),
          SizedBox(height: 20),
          ElevatedButton(
            onPressed: () {
              // launch('https://example.com/projects'); // Replace with actual URL
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Color.fromARGB(255, 226, 230, 120), // Set button color
              padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
            ),
            child: Text('View Projects'),
          ),
        ],
      ),
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
        // ignore: deprecated_member_use
        // launch(url);
      },
      style: ElevatedButton.styleFrom(
        backgroundColor: Color.fromARGB(255, 172, 207, 236), // Set button color
      ),
      child: Text(year),
    );
  }
}

void main() {
  runApp(MaterialApp(
    home: GoogleSummerOfCodeScreen(),
  ));
}
