import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../modals/GSoC/Gsoc.dart';

class GsocProjectWidget extends StatelessWidget {
  final GsocModel modal;
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
        if (modal.projectUrl != null) {
          await _launchUrl(modal.projectUrl!);
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
          color: cardColor,
        ),
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "$index. ${modal.organization}",
                style: TextStyle(
                  color: Colors.orange,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              if (modal.originalProjectProposal != null) ...[
                Padding(
                  padding: const EdgeInsets.only(top: 10.0),
                  child: Text(
                    "Description : ${modal.originalProjectProposal}",
                    style: TextStyle(
                      color: textColor,
                    ),
                  ),
                ),
              ],
              if (modal.mentor != null) ...[
                Padding(
                  padding: const EdgeInsets.only(top: 10.0),
                  child: Text(
                    "Mentor: ${modal.mentor}",
                    style: TextStyle(
                      color: textColor,
                    ),
                  ),
                ),
              ],
              if (modal.technicalWriter != null) ...[
                Padding(
                  padding: const EdgeInsets.only(top: 10.0),
                  child: Text(
                    "Technical Writer: ${modal.technicalWriter}",
                    style: TextStyle(
                      color: textColor,
                    ),
                  ),
                ),
              ],
              Padding(
                padding: const EdgeInsets.only(top: 20.0),
                child: Wrap(
                  spacing: 10,
                  runSpacing: 10,
                  children: [
                    if (modal.organizationUrl != null &&
                        modal.organizationUrl!.isNotEmpty)
                      ElevatedButton.icon(
                        onPressed: () {
                          _launchUrl(modal.organizationUrl!);
                        },
                        icon: Icon(Icons.web, color: Colors.white),
                        label: Text("Org Website"),
                        style: ElevatedButton.styleFrom(
                          foregroundColor: Colors.white,
                          backgroundColor: Colors.orange,
                        ),
                      ),
                    if (modal.reportUrl != null && modal.reportUrl!.isNotEmpty)
                      ElevatedButton.icon(
                        onPressed: () {
                          _launchUrl(modal.reportUrl!);
                        },
                        icon: Icon(Icons.description, color: Colors.white),
                        label: Text("Report"),
                        style: ElevatedButton.styleFrom(
                          foregroundColor: Colors.white,
                          backgroundColor: Colors.orange,
                        ),
                      ),
                    if (modal.acceptedProjectProposalUrl != null &&
                        modal.acceptedProjectProposalUrl!.isNotEmpty)
                      ElevatedButton.icon(
                        onPressed: () {
                          _launchUrl(modal.acceptedProjectProposalUrl!);
                        },
                        icon: Icon(Icons.file_present, color: Colors.white),
                        label: Text("Proposal"),
                        style: ElevatedButton.styleFrom(
                          foregroundColor: Colors.white,
                          backgroundColor: Colors.orange,
                        ),
                      ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}