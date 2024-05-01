import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart' as UrlLauncher;

class AboutScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('About App'),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Image
              Image.asset(
                'assets/girlscript_logo.png', 
                width: 300,
                height: 300,
                fit: BoxFit.contain,
              ),
              SizedBox(height: 20),
              // Version
              Text(
                'Version 1.0.0', 
                style: TextStyle(fontSize: 18),
              ),
              SizedBox(height: 10),
              // App Description
              Text(
                'OpSo',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 16),
              ),
              SizedBox(height: 30),
              // GitHub Button
              ElevatedButton.icon(
                onPressed: () {
                  _launchURL('https://github.com/andoriyaprashant/');
                },
                icon: Icon(Icons.code),
                label: Text('GitHub'),
              ),
              SizedBox(height: 10),
              // Liquid Galaxy Website Link
              ElevatedButton.icon(
                onPressed: () {
                  _launchURL('https://gssoc.girlscript.tech/');
                },
                icon: Icon(Icons.link),
                label: Text('Gssoc Website'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Function to launch URLs
  Future<void> _launchURL(String url) async {
    if (await UrlLauncher.canLaunch(url)) {
      await UrlLauncher.launch(url);
    } else {
      print('Could not launch $url');
    }
  }
}