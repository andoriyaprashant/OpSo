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
    return GestureDetector(
      onTap: () => launchUrl(Uri.parse(modal.projectUrl)),
      child: Container(
        constraints: BoxConstraints(
          minHeight: height,
        ),
        width: width,
        decoration: const BoxDecoration(
          color: Color.fromARGB(255, 153, 152, 152),
        ),
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              // const SizedBox(height: 20),
              SvgPicture.network(
                modal.imageUrl,
                fit: BoxFit.fitWidth,
                height: 60,
                placeholderBuilder: (context) =>
                    const CircularProgressIndicator(),
              ),
              const SizedBox(height: 10),
              Text(
                modal.name,
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  decoration: TextDecoration.underline,
                ),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
