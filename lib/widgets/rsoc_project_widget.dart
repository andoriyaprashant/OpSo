import 'package:flutter/material.dart';
import 'package:opso/modals/rsoc_project_modal.dart';
import 'package:url_launcher/url_launcher.dart';

class RsocProjectWidget extends StatelessWidget {
  final RsocProjectModal modal;
  final int index;

  const RsocProjectWidget({
    super.key,
    required this.modal,
    required this.index,
  });

  @override
  Widget build(BuildContext context) {
    bool isDarkMode = Theme.of(context).brightness == Brightness.dark;
    return GestureDetector(
      onTap: () async {
        Uri uri = Uri.parse(modal.githubUrl);
        if (await canLaunch(uri.toString())) {
          await launch(uri.toString());
        } else {
          throw 'Could not launch $uri';
        }
      },
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(
            color: isDarkMode ? Colors.orange.shade100 : Colors.orange.shade300,
            width: 1,
          ),
          borderRadius: BorderRadius.circular(20),
        ),
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "$index. ${modal.name}",
                style: const TextStyle(
                  color: Colors.orange,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 10.0),
                child: Text("Contributor: ${modal.contributor}"),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 5.0),
                child: Text("Description: ${modal.description}"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
