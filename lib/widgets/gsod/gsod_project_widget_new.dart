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
            GestureDetector(
              child: Wrap(
                children: [
                  const Text(
                    "Docs Page : ",
                    style: TextStyle(
                      color: Colors.deepPurple,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    modal.docsPage,
                    style: TextStyle(
                      decoration: TextDecoration.underline,
                      decorationColor: primaryColor,
                      color: primaryColor,
                    ),
                  ),
                ],
              ),
              onTap: () {
                launchUrl(Uri.parse(modal.docsPageUrl));
              },
            ),
            const SizedBox(
              height: 10,
            ),
            GestureDetector(
              child: Wrap(
                children: [
                  const Text(
                    "Budget : ",
                    style: TextStyle(
                      color: Colors.deepPurple,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    modal.budget,
                    style: TextStyle(
                      decoration: TextDecoration.underline,
                      decorationColor: primaryColor,
                      color: primaryColor,
                    ),
                  ),
                ],
              ),
              onTap: () {
                launchUrl(Uri.parse(modal.budgetUrl));
              },
            ),
            const SizedBox(
              height: 10,
            ),
            GestureDetector(
              child: Wrap(
                children: [
                  const Text(
                    "Accecpted Proposal : ",
                    style: TextStyle(
                      color: Colors.deepPurple,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    modal.acceptedProjectProposal,
                    style: TextStyle(
                      decoration: TextDecoration.underline,
                      decorationColor: primaryColor,
                      color: primaryColor,
                    ),
                  ),
                ],
              ),
              onTap: () {
                launchUrl(Uri.parse(modal.acceptedProjectProposalUrl));
              },
            ),
            const SizedBox(
              height: 10,
            ),
            GestureDetector(
              child: Wrap(
                children: [
                  const Text(
                    "Case Study: ",
                    style: TextStyle(
                      color: Colors.deepPurple,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    modal.caseStudy,
                    style: TextStyle(
                      decoration: TextDecoration.underline,
                      decorationColor: primaryColor,
                      color: primaryColor,
                    ),
                  ),
                ],
              ),
              onTap: () {
                launchUrl(Uri.parse(modal.caseStudyUrl));
              },
            ),
          ],
        ),
      ),
    );
  }
}
