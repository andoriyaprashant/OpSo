import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:opso/modals/gsod/gsod_modal_new.dart';
import 'package:url_launcher/url_launcher.dart';

class GsodProjectWidgetNew extends StatelessWidget {
  final GsodModalNew modal;
  final double height;
  final double width;
  final int index;
  final Color primaryColor;
  const GsodProjectWidgetNew({
    super.key,
    this.height = 100,
    this.width = 100,
    required this.index,
    required this.modal,
    this.primaryColor = const Color.fromRGBO(249, 171, 0, 1),
  });
  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: BoxConstraints(
        minHeight: height,
      ),
      width: width,
      decoration: BoxDecoration(
        color: primaryColor.withOpacity(0.05),
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(
              height: 10,
            ),
            GestureDetector(
              child: Text(
                modal.organizationName,
                style: TextStyle(
                  decoration: TextDecoration.underline,
                  decorationColor: primaryColor,
                  color: primaryColor,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              onTap: () {
                launchUrl(Uri.parse(modal.organizationUrl));
              },
            ),
            const SizedBox(
              height: 10,
            ),
            Row(
              children: [
                GestureDetector(
                  child: Container(
                    margin: const EdgeInsets.only(right: 10),
                    decoration: BoxDecoration(
                      color: const Color.fromARGB(255, 249, 241, 226),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: const IntrinsicWidth(
                      stepWidth: 35,
                      child: Padding(
                        padding: EdgeInsets.all(10.0),
                        child: Center(
                          child: Text(
                            "Docs Page",
                            // modal.techstack[index],
                            style: TextStyle(
                              color: Colors.orange,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  onTap: () {
                    launchUrl(Uri.parse(modal.docsPageUrl));
                  },
                ),
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.1,
                ),
                GestureDetector(
                  child: Container(
                    margin: const EdgeInsets.only(right: 10),
                    decoration: BoxDecoration(
                      color: const Color.fromARGB(255, 249, 241, 226),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: const IntrinsicWidth(
                      stepWidth: 30,
                      child: Padding(
                        padding: EdgeInsets.all(10.0),
                        child: Center(
                          child: Text(
                            "Budget",
                            // modal.techstack[index],
                            style: TextStyle(
                              color: Colors.orange,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  onTap: () {
                    launchUrl(Uri.parse(modal.budgetUrl));
                  },
                ),
              ],
            ),
            const SizedBox(
              height: 10,
            ),
            GestureDetector(
              child: Container(
                margin: const EdgeInsets.only(right: 10),
                decoration: BoxDecoration(
                  color: const Color.fromARGB(255, 249, 241, 226),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: const IntrinsicWidth(
                  stepWidth: 30,
                  child: Padding(
                    padding: EdgeInsets.all(10.0),
                    child: Center(
                      child: Text(
                        "Accecpted Proposal",
                        // modal.techstack[index],
                        style: TextStyle(
                          color: Colors.orange,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              onTap: () {
                launchUrl(Uri.parse(modal.acceptedProjectProposalUrl));
              },
            ),
            const SizedBox(
              height: 10,
            ),
            GestureDetector(
              child: Container(
                margin: const EdgeInsets.only(right: 10),
                decoration: BoxDecoration(
                  color: const Color.fromARGB(255, 249, 241, 226),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: const IntrinsicWidth(
                  stepWidth: 30,
                  child: Padding(
                    padding: EdgeInsets.all(10.0),
                    child: Center(
                      child: Text(
                        "Case Study",
                        // modal.techstack[index],
                        style: TextStyle(
                          color: Colors.orange,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              onTap: () {
                launchUrl(Uri.parse(modal.caseStudyUrl));
              },
            ),
            const SizedBox(
              height: 10,
            ),
          ],
        ),
      ),
    );
  }
}
