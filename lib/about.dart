import 'package:flutter/material.dart';
import 'package:url_launcher/link.dart';

class AboutScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('About App'),
      ),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(50, 0, 40, 70),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Image
            Image.asset(
              'assets/logo.png',
              width: 300,
              height: 300,
              fit: BoxFit.contain,
            ),
            SizedBox(height: 5),
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
            SizedBox(height: 20),
            // GitHub Button
            Link(
              uri: Uri.parse('https://github.com/andoriyaprashant/OpSo'),
              target: LinkTarget.self,
              builder: (context, followlink) => ElevatedButton.icon(
                onPressed: followlink,
                icon: Icon(Icons.code),
                label: Text('GitHub'),
              ),
            ),
            SizedBox(height: 10),

            // Link(
            //   uri: Uri.parse('https://gssoc.girlscript.tech/'),
            //   target: LinkTarget.self,
            //   builder: (context, followlink) => ElevatedButton.icon(
            //     onPressed: followlink,
            //     icon: Icon(Icons.link),
            //     label: Text('Gssoc Website'),
            //   ),
            // ),
          ],
        ),
      ),
    );
  }
}
