import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:opso/modals/linux_foundation_modal.dart';
import 'package:url_launcher/url_launcher.dart';


class LinuxFoundationWidget extends StatelessWidget {
  final LinuxFoundationModal modal;
  final double height;
  final double width;
  const LinuxFoundationWidget(
      {super.key, required this.modal, this.height = 100, this.width = 100});


  @override
  Widget build(BuildContext context) {
    bool isDarkMode = Theme.of(context).brightness == Brightness.dark;


    return GestureDetector(
      onTap: () => launchUrl(Uri.parse(modal.projectUrl)),
      child: Card(
        elevation: 5,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        child: Container(
          width: width,
          constraints: BoxConstraints(minHeight: height),
          decoration: BoxDecoration(
            color: isDarkMode
                ? const Color.fromARGB(255, 48, 48, 48)
                : const Color.fromARGB(255, 255, 255, 255),
            border: Border.all(
              color: isDarkMode ? Colors.orange.shade100 : Colors.orange.shade300,
              width: 1,
            ),
            borderRadius: BorderRadius.circular(20),
          ),
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                modal.imageUrl == ""
                    ? SvgPicture.asset(
                  'assets/logo.png',
                  fit: BoxFit.fitWidth,
                  height: 60,
                )
                    :
                SvgPicture.network(
                  modal.imageUrl,
                  fit: BoxFit.fitWidth,
                  height: 60,
                  placeholderBuilder: (context) => const CircularProgressIndicator(),
                ),
                const SizedBox(height: 10),
                Text(
                  modal.name,
                  style: TextStyle(
                    fontSize: 20,
                    color: Colors.orange,
                    fontWeight: FontWeight.bold,
                    decoration: TextDecoration.underline,
                    decorationColor: Colors.orange,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 10),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

