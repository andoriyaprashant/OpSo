import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../modals/GSoC/Gsoc.dart';

class GsocProjectWidget extends StatelessWidget {
  final Organization modal;
  final double height;
  final double width;
  final int index;

  const GsocProjectWidget({
    Key? key,
    required this.modal,
    required this.index,
    this.height = 100,
    this.width = 100,
  }) : super(key: key);

  Future<void> _launchUrl(String url) async {
    final Uri uri = Uri.parse(url);
    if (!await launchUrl(uri)) {
      throw 'Could not launch $url';
    }
  }

  @override
  Widget build(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    final textColor = isDarkMode ? Colors.white : Colors.black;
    final cardColor = isDarkMode ? Colors.grey.shade800 : Colors.white;

    return GestureDetector(
      onTap: () async {
        await _launchUrl(modal.url);
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
          color: cardColor,
        ),
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "$index. ${modal.name}",
                style: TextStyle(
                  color: Colors.orange,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 10.0),
                child: Text(
                  "By ${modal.description}",
                  style: TextStyle(
                    color: textColor,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 20.0),
                child: Wrap(
                  spacing: 10,
                  runSpacing: 10,
                  children: [
                    if (modal.contactEmail.isNotEmpty)
                      ElevatedButton.icon(
                        onPressed: () {
                          _launchUrl('mailto:${modal.contactEmail}');
                        },
                        icon: Icon(Icons.email, color: Colors.white),
                        label: Text("Email"),
                        style: ElevatedButton.styleFrom(
                          foregroundColor: Colors.white, backgroundColor: Colors.orange,
                        ),
                      ),
                    if (modal.blogUrl.isNotEmpty)
                      ElevatedButton.icon(
                        onPressed: () {
                          _launchUrl(modal.blogUrl);
                        },
                        icon: Icon(Icons.web, color: Colors.white),
                        label: Text("Blog"),
                        style: ElevatedButton.styleFrom(
                          foregroundColor: Colors.white, backgroundColor: Colors.orange,
                        ),
                      ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 20.0),
                child: Wrap(
                  alignment: WrapAlignment.start,
                  runSpacing: 10,
                  children: List.generate(
                    modal.technologies.length,
                        (index) => Container(
                      margin: const EdgeInsets.only(right: 10),
                      decoration: BoxDecoration(
                        color: const Color.fromARGB(255, 249, 241, 226),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: IntrinsicWidth(
                        stepWidth: 30,
                        child: Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Center(
                            child: Text(
                              modal.technologies[index],
                              style: TextStyle(
                                color: Colors.orange,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}