import 'package:flutter/material.dart';
import 'package:opso/modals/gsod/gsod_modal_new.dart';
import 'package:url_launcher/url_launcher.dart';

class GsodProjectWidgetNew extends StatelessWidget {
  final GsodModalNew modal;
  final double height;
  final double width;
  final int index;
  final Color primaryColor;
  final Color secondaryColor = Colors.white;
  final Color tertiaryColor = Colors.black87;
  final Color linkColor = const Color(0xff0000FF);
  final Color linkColorDark = const Color(0xff3f84e4);

  const GsodProjectWidgetNew({
    super.key,
    this.height = 100,
    this.width = 100,
    required this.index,
    required this.modal,
    this.primaryColor = const Color.fromRGBO(249, 171, 0, 1),
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
    final linkColor = isDarkMode ? Colors.white : primaryColor;

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
            GestureDetector(
              onTap: () {
                _launchUrl(modal.organizationUrl);
              },
              child: Text(
                modal.organizationName,
                style: TextStyle(
                  decorationColor: primaryColor,
                  color: primaryColor,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const SizedBox(height: 10),
            _buildLinkTile(
              context,
              title: 'Docs Page',
              value: modal.docsPage,
              url: modal.docsPageUrl,
              isDarkMode: isDarkMode,
            ),
            const SizedBox(height: 10),
            _buildLinkTile(
              context,
              title: 'Budget',
              value: modal.budget,
              url: modal.budgetUrl,
              isDarkMode: isDarkMode,
            ),
            const SizedBox(height: 10),
            _buildLinkTile(
              context,
              title: 'Accepted Proposal',
              value: modal.acceptedProjectProposal,
              url: modal.acceptedProjectProposalUrl,
              isDarkMode: isDarkMode,
            ),
            const SizedBox(height: 10),
            _buildLinkTile(
              context,
              title: 'Case Study',
              value: modal.caseStudy,
              url: modal.caseStudyUrl,
              isDarkMode: isDarkMode,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildLinkTile(BuildContext context, {required String title, required String value, required String url, required bool isDarkMode}) {
    return GestureDetector(
      onTap: () {
        _launchUrl(url);
      },
      child: MouseRegion(
        cursor: SystemMouseCursors.click,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: TextStyle(
                      color: Colors.grey,
                      fontSize: 14,
                      fontWeight: FontWeight.normal,
                    ),
                  ),
                  Text(
                    value,
                    maxLines: 1, // Limiting to one line
                    overflow: TextOverflow.ellipsis, // Adding ellipsis if text overflows
                    style: TextStyle(
                      color: isDarkMode ? secondaryColor : tertiaryColor,
                      fontSize: 16,
                      decoration: TextDecoration.none, // Removing underline
                    ),
                  ),
                ],
              ),
            ),
            Icon(
              Icons.link,
              color: isDarkMode ? linkColorDark : linkColor,
              size: 16,
            ),
          ],
        ),
      ),
    );
  }

}