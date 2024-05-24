import 'package:flutter/material.dart';
import 'package:opso/modals/sob_project_modal.dart';
import 'package:url_launcher/url_launcher.dart';

class SobProjectWidget extends StatelessWidget {
  final SobProjectModal modal;
  final double height;
  final double width;
  final Color color = const Color.fromARGB(255, 247, 147, 26);
  const SobProjectWidget({
    super.key,
    required this.modal,
    this.height = 100,
    this.width = 100,
  });

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

    return Container(
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
              modal.name,
              style: TextStyle(
                color: Colors.orange,
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 10.0),
              child: Text(
                modal.description,
                style: TextStyle(
                  color: textColor,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 20.0),
              child: Container(
                height: 30,
                decoration: BoxDecoration(
                  border: Border.all(color: color),
                  borderRadius: BorderRadius.circular(20),
                  color: Colors.white,
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                      vertical: 5, horizontal: 10),
                  child: Text(
                    modal.organization,
                    style: TextStyle(color: color),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "Mentor",
                    style: TextStyle(color: Colors.grey, fontSize: 14),
                  ),
                  Text(
                    modal.mentor,
                    style: const TextStyle(fontSize: 16),
                  ),
                  const SizedBox(height: 10),
                  const Text(
                    "University",
                    style: TextStyle(color: Colors.grey, fontSize: 14),
                  ),
                  Text(
                    modal.university,
                    style: const TextStyle(fontSize: 16),
                  ),
                  const SizedBox(height: 10),
                  const Text(
                    "Country",
                    style: TextStyle(color: Colors.grey, fontSize: 14),
                  ),
                  Text(
                    modal.country,
                    style: const TextStyle(fontSize: 16),
                  ),
                  const SizedBox(height: 10),
                  const Text(
                    "Projects",
                    style: TextStyle(color: Colors.grey, fontSize: 14),
                  ),
                  Wrap(
                    spacing: 8,
                    runSpacing: 8,
                    children: List.generate(
                      modal.projects.length,
                          (index) => GestureDetector(
                        onTap: () {
                          if (modal.projects[index] != "NA") {
                            _launchUrl(modal.projects[index]);
                          }
                        },
                        child: Container(
                          padding: const EdgeInsets.all(10.0),
                          margin: const EdgeInsets.symmetric(vertical: 5.0),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: isDarkMode
                                ? Colors.white
                                : Colors.grey.shade200,
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.0),
                                spreadRadius: 1,
                                blurRadius: 5,
                                offset: const Offset(0, 3),
                              ),
                            ],
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Icon(
                                Icons.link,
                                color: modal.projects[index] != "NA"
                                    ? Colors.blue
                                    : Colors.black,
                              ),
                              const SizedBox(width: 5),
                              Text(
                                'Project ${index + 1}',
                                style: TextStyle(
                                  fontSize: 16,
                                  color: modal.projects[index] != "NA"
                                      ? Colors.blue
                                      : Colors.black,
                                  decorationColor: modal.projects[index] != "NA"
                                      ? Colors.blue
                                      : Colors.black,
                                  decoration: modal.projects[index] != "NA"
                                      ? TextDecoration.underline
                                      : TextDecoration.none,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}