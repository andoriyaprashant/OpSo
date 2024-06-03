import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart' as UrlLauncher;

class AboutScreen extends StatelessWidget {
  const AboutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('About App'),
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
              const SizedBox(height: 20),
              // Version
              const Text(
                'Version 1.0.0',
                style: TextStyle(fontSize: 18),
              ),
              const SizedBox(height: 10),
              // App Description
              const Text(
                'OpSo',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 16),
              ),
              const SizedBox(height: 30),
              // GitHub Button
              ElevatedButton.icon(
                onPressed: () {
                  _launchURL('https://github.com/andoriyaprashant/');
                },
                icon: const Icon(Icons.code),
                label: const Text('GitHub'),
              ),
              const SizedBox(height: 10),
              // Liquid Galaxy Website Link
              ElevatedButton.icon(
                onPressed: () {
                  _launchURL('https://gssoc.girlscript.tech/');
                },
                icon: const Icon(Icons.link),
                label: const Text('Gssoc Website'),
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
      if (kDebugMode) {
        print('Could not launch $url');
      }
    }
  }
}