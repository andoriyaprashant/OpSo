import 'package:flutter/material.dart';
import 'package:opso/modals/gsoc_modal.dart';
import 'package:url_launcher/url_launcher.dart';

class GsocProjectWidget extends StatelessWidget {
  final GsocProjectModel modal;
  final double height;
  final double width;
  final int index;
  const GsocProjectWidget(
      {super.key,
      required this.modal,
      required this.index,
      this.height = 100,
      this.width = 100});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () async {
        Uri uri = Uri.parse(modal.githubUrl);
        launchUrl(uri);
      },
      child: Container(
        width: width,
        constraints: BoxConstraints(minHeight: height),
        decoration: BoxDecoration(
            color: const Color.fromARGB(255, 251, 248, 246),
            borderRadius: BorderRadius.circular(20)),
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
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
                child: Text("By ${modal.hostedBy}"),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 20.0),
                child: Wrap(
                  alignment: WrapAlignment.start,
                  runSpacing: 10,
                  children: List.generate(
                    modal.techstack.length,
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
                              modal.techstack[index],
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
