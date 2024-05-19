import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

import 'package:opso/modals/gssoc_project_modal.dart';
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

  @override
  Widget build(BuildContext context) {
    bool isDarkMode = Theme.of(context).brightness == Brightness.dark;
    return GestureDetector(
      onTap: () async {
        Uri uri = Uri.parse(modal.url);
        launchUrl(uri);
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
                child: Text("By ${modal.description}"),
              ),

              Padding(
                padding: const EdgeInsets.only(top: 10.0),
                child: modal.contactEmail.isNotEmpty
                    ? RichText(
                  text: TextSpan(
                    text: "Contact Mail: ",
                    style: TextStyle(color: Colors.black), // style for "Contact Mail: "
                    children: [
                      TextSpan(
                        text: modal.contactEmail,
                        style: TextStyle(
                          color: Colors.blue,
                          decoration: TextDecoration.underline,
                        ),
                        recognizer: TapGestureRecognizer()
                          ..onTap = () {
                            launchUrl(Uri.parse('mailto:${modal.contactEmail}'));
                          },
                      ),
                    ],
                  ),
                )
                    : SizedBox.shrink(), // Use SizedBox.shrink() to render an empty widget if the condition is false
              ),

              Padding(
                padding: const EdgeInsets.only(top: 10.0),
                child: modal.blogUrl.isNotEmpty
                    ? RichText(
                  text: TextSpan(
                    text: "Blog Url: ",
                    style: TextStyle(color: Colors.black), // style for "Blog Url: "
                    children: [
                      TextSpan(
                        text: modal.blogUrl,
                        style: TextStyle(
                          color: Colors.blue,
                          decoration: TextDecoration.underline,
                        ),
                        recognizer: TapGestureRecognizer()
                          ..onTap = () {
                            launchUrl(Uri.parse(modal.blogUrl));
                          },
                      ),
                    ],
                  ),
                )
                    : SizedBox.shrink(), // Use SizedBox.shrink() to render an empty widget if the condition is false
              ),
              Padding(
                padding: const EdgeInsets.only(top: 10.0),
                child: modal.category.isNotEmpty
                    ? RichText(
                  text: TextSpan(
                    text: "Category: ",
                    style: TextStyle(color: Colors.black), // style for "Contact Mail: "
                    children: [
                      TextSpan(
                        text: modal.category,
                        style: TextStyle(
                          color: Colors.blue,
                          decoration: TextDecoration.underline,
                        ),
                        recognizer: TapGestureRecognizer()
                          ..onTap = () {
                            launchUrl(Uri.parse('category :${modal.category}'));
                          },
                      ),
                    ],
                  ),
                )
                    : SizedBox.shrink(), // Use SizedBox.shrink() to render an empty widget if the condition is false
              ),



              // Add more Text widgets for other properties if needed
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