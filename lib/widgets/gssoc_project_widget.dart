import 'package:flutter/material.dart';
import 'package:opso/modals/gssoc_project_modal.dart';
import 'package:url_launcher/url_launcher.dart';

class GssocProjectWidget extends StatelessWidget {
  final GssocProjectModal modal;
  final double height;
  final double width;
  final int index;
  const GssocProjectWidget(
      {super.key,
      required this.modal,
      required this.index,
      this.height = 100,
      this.width = 100});

  @override
  Widget build(BuildContext context) {
    bool isDarkMode = Theme.of(context).brightness == Brightness.dark;
    return GestureDetector(
      onTap: () async {
        Uri uri = Uri.parse(modal.githubUrl);
        // if (await canLaunchUrl(uri)) {
        //   launchUrl(uri);
        // }
        launchUrl(uri);
      },
      child: Container(
        width: width,
        constraints: BoxConstraints(minHeight: height),
        decoration: BoxDecoration(
            // color: const Color.fromARGB(255, 251, 248, 246),
            border: Border.all(
              color:
                  isDarkMode ? Colors.orange.shade100 : Colors.orange.shade300,
              width: 1,
            ),
            borderRadius: BorderRadius.circular(20)),
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
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
                child: Text("By ${modal.hostedBy}"),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 20.0),
                child: Wrap(
                  alignment: WrapAlignment.start,
                  runSpacing: 10,
                  children: List.generate(
                    modal.techstack.length,
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
                              modal.techstack[index],
                              style: const TextStyle(
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
              )
            ],
          ),
        ),
      ),
    );
  }
}
