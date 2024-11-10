import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:opso/modals/osoc_modal.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:jovial_svg/jovial_svg.dart';

class OsocWidget extends StatelessWidget {
  final OsocModal modal;
  final double height;
  final double width;
  const OsocWidget(
      {super.key, required this.modal, this.height = 100, this.width = 100});

  @override
  Widget build(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    final textColor = isDarkMode ? Colors.white : Colors.black;
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
            ClipRRect(
              borderRadius: BorderRadius.circular(50),
              child: SizedBox(
                height: 100,
                width: 100,
                child: ScalableImageWidget.fromSISource(
                    si: ScalableImageSource.fromSvgHttpUrl(
                  Uri.parse(modal.image_url),
                )),
              ),
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
