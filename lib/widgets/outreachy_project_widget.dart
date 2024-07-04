import 'package:flutter/material.dart';
import 'package:opso/modals/outreachy_project_modal.dart';

class OutreachyProjectWidget extends StatelessWidget {
  final OutreachyProjectModal modal;
  final double height;
  final double width;
  final int index;

  const OutreachyProjectWidget({
    super.key,
    required this.modal,
    required this.index,
    this.height = 100,
    this.width = 100,
  });

  @override
  Widget build(BuildContext context) {
    bool isDarkMode = Theme.of(context).brightness == Brightness.dark;
    return GestureDetector(
      child: Container(
        width: width,
        constraints: BoxConstraints(minHeight: height),
        decoration: BoxDecoration(
          border: Border.all(
            color: isDarkMode ? Colors.orange.shade100 : Colors.orange.shade300,
            width: 1,
          ),
          borderRadius: BorderRadius.circular(20),
        ),
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
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
                child: Text(modal.description),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 10.0),
                child: Text("Spots: ${modal.spots}"),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 10.0),
                child: Text("Year: ${modal.year}"),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 20.0),
                child: Wrap(
                  alignment: WrapAlignment.start,
                  runSpacing: 10,
                  children: List.generate(
                    modal.skills.length,
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
                              modal.skills[index],
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
              ),
            ],
          ),
        ),
      ),
    );
  }
}
