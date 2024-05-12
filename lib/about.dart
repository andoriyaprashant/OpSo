import 'package:flutter/material.dart';
import 'package:url_launcher/link.dart';

class AboutScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
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
              Link(
                uri: Uri.parse('https://github.com/andoriyaprashant/'),
                target: LinkTarget.self,
                builder: (context, followlink) => ElevatedButton.icon(
                  onPressed: followlink,
                  icon: Icon(Icons.code),
                  label: Text('GitHub'),
                ),
              ),
              SizedBox(height: 10),

              Link(
                uri: Uri.parse('https://gssoc.girlscript.tech/'),
                target: LinkTarget.self,
                builder: (context, followlink) => ElevatedButton.icon(
                  onPressed: followlink,
                  icon: Icon(Icons.link),
                  label: Text('Gssoc Website'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
