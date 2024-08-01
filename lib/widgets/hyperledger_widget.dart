import 'package:flutter/material.dart';
import 'package:opso/modals/hyperledger_modal.dart';
import 'package:url_launcher/url_launcher.dart';

class HyperledgerProjectWidget extends StatelessWidget {
  final HyperledgerProjectModal modal;
  final double height;
  final double width;
  final int index;

  const HyperledgerProjectWidget({
    super.key,
    required this.modal,
    required this.index,
    this.height = 100,
    this.width = 100,
  });

  @override
  Widget build(BuildContext context) {
    bool isDarkMode = Theme.of(context).brightness == Brightness.dark;
    return GestureDetector(
      onTap: () async {
        Uri uri = Uri.parse(modal.wiki);
        if (await canLaunch(uri.toString())) {
          await launch(uri.toString());
        } else {
          throw 'Could not launch $uri';
        }
      },
      child: Container(
        width: width,
        constraints: BoxConstraints(minHeight: height),
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
                child: Text("Mentors: ${modal.mentors.join(', ')}"),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 20.0),
                child: Text("Year: ${modal.year}"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
