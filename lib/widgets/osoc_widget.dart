import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:opso/modals/osoc_modal.dart';
import 'package:url_launcher/url_launcher.dart';

class OsocWidget extends StatelessWidget {
  final OsocModal modal;
  final double height;
  final double width;
  const OsocWidget(
      {super.key, required this.modal, this.height = 100, this.width = 100});

  @override
  Widget build(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    final cardColor = isDarkMode ? Colors.grey.shade800 : Colors.white;
    return GestureDetector(
      onTap: () => launchUrl(
        Uri.parse(modal.project_url),
      ),
      child: Container(
        constraints: BoxConstraints(
          minHeight: height,
        ),
        padding: const EdgeInsets.all(10),
        width: width,
        decoration: BoxDecoration(
          color: cardColor,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            SvgPicture.network(
              modal.image_url,
              height: height * 0.5,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: Text(
                modal.name,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                ),
                textAlign: TextAlign.center,
              ),
            ),
            Text(modal.description),
          ],
        ),
      ),
    );
  }
}
