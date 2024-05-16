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

  @override
  Widget build(BuildContext context) {
    return Container(
      // constraints: BoxConstraints(minHeight: height),
      width: width,
      color: Colors.grey.withOpacity(0.1),
      child: ExpansionTile(
        shape: const Border(),
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            const SizedBox(
              height: 10,
            ),
            Text(
              modal.name,
              style: const TextStyle(fontSize: 16),
            ),
            const SizedBox(
              height: 10,
            ),
            Text(
              modal.description,
              style: const TextStyle(fontSize: 16),
            ),
            const SizedBox(
              height: 10,
            ),
            Container(
              height: 30,
              decoration: BoxDecoration(
                  border: Border.all(color: color),
                  borderRadius: BorderRadius.circular(20),
                  color: Colors.white),
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                child: Text(
                  modal.organization,
                  style: TextStyle(color: color),
                ),
              ),
            ),
            // const SizedBox(
            //   height: 10,
            // ),
          ],
        ),
        expandedCrossAxisAlignment: CrossAxisAlignment.start,
        expandedAlignment: Alignment.centerLeft,
        childrenPadding: const EdgeInsets.only(left: 10, right: 10, bottom: 10),
        children: [
          const Divider(),
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
          Column(
            children: List.generate(
                modal.projects.length,
                (index) => Padding(
                      padding: const EdgeInsets.only(top: 8.0),
                      child: GestureDetector(
                        child: Text(
                          modal.projects[index],
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
                        onTap: () {
                          launchUrl(Uri.parse(modal.projects[index]));
                        },
                      ),
                    )),
          )
        ],
      ),
    );
  }
}
