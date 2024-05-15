import 'package:flutter/material.dart';
import 'package:opso/modals/gsod/gsod_modal_old.dart';
import 'package:url_launcher/url_launcher.dart';

class GsodProjectWidgetOld extends StatelessWidget {
  final GsodModalOld modal;
  final double height;
  final double width;
  final int index;
  final Color primaryColor;
  const GsodProjectWidgetOld({
    super.key,
    this.height = 100,
    this.width = 100,
    required this.index,
    required this.modal,
    this.primaryColor = const Color.fromRGBO(249, 171, 0, 1),
  });

  /* 
    String organization;
  String organizationUrl;
  String technicalWriter;
  String mentor;
  String project;
  String projectUrl;
  String report;
  String reportUrl;
  String originalProjectProposal;
  String originalProjectProposalUrl;
  */

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
                modal.organization,
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
            Wrap(
              children: [
                const Text(
                  "Technical Writer: ",
                  style: TextStyle(
                    color: Colors.deepPurple,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  modal.technicalWriter,
                  style: TextStyle(
                    decorationColor: primaryColor,
                    color: primaryColor,
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 10,
            ),
            Wrap(
              children: [
                const Text(
                  "Mentor : ",
                  style: TextStyle(
                    color: Colors.deepPurple,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  modal.mentor,
                  style: TextStyle(
                    decorationColor: primaryColor,
                    color: primaryColor,
                  ),
                ),
              ],
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
                      stepWidth: 30,
                      child: Padding(
                        padding: EdgeInsets.all(10.0),
                        child: Center(
                          child: Text(
                            "Project",
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
                    launchUrl(Uri.parse(modal.projectUrl));
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
                            "Report",
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
                    launchUrl(Uri.parse(modal.reportUrl));
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
                        "Original project proposal",
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
                launchUrl(Uri.parse(modal.originalProjectProposalUrl));
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
