import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../modals/GSoC/Gsoc.dart';

class GsocProjectWidget extends StatelessWidget {
  final Organization modal;
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
        await _launchUrl(modal.url);
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
                "$index. ${modal.name}",
                style: TextStyle(
                  color: Colors.orange,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                modal.description,
                style: TextStyle(
                  color: textColor,
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Wrap(
                alignment: WrapAlignment.start,
                runSpacing: 10,
                children: List.generate(
                  modal.technologies.length,
                  (index) => Container(
                    margin: const EdgeInsets.only(right: 5),
                    decoration: BoxDecoration(
                      color: const Color.fromARGB(255, 249, 241, 226),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: IntrinsicWidth(
                      stepWidth: 30,
                      child: Padding(
                        padding: const EdgeInsets.all(5.0),
                        child: Center(
                          child: Text(
                            modal.technologies[index],
                            style: TextStyle(
                              color: Colors.orange,
                              fontSize: 10,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                      onPressed: () {
                        showModalBottomSheet(
                          backgroundColor: Colors.white,
                          showDragHandle: true,
                          context: context,
                          isScrollControlled: true,
                          useSafeArea: true,
                          builder: (BuildContext context) {
                            return SingleChildScrollView(
                              child: Padding(
                                padding:
                                    const EdgeInsets.fromLTRB(16, 16, 16, 16),
                                child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Container(
                                        padding: EdgeInsets.all(20),
                                        color: Colors.grey[100],
                                        child: Center(
                                          child: Image.network(
                                            modal.imageUrl,
                                            width: 80,
                                            height: 80,
                                          ),
                                        ),
                                      ),
                                      SizedBox(
                                        height: 10,
                                      ),
                                      Text(modal.description),
                                      Divider(
                                        thickness: 2,
                                        color: Colors.grey[200],
                                      ),
                                      ListView.builder(
                                        physics: NeverScrollableScrollPhysics(),
                                        shrinkWrap: true,
                                        itemCount: modal.projects.length,
                                        itemBuilder: (context, projectIndex) {
                                          return _buildProjectCard(
                                              modal.projects[projectIndex]);
                                        },
                                      )
                                    ]),
                              ),
                            );
                          },
                        );
                      },
                      style: ButtonStyle(
                          backgroundColor:
                              WidgetStateProperty.all(Colors.orange),
                          foregroundColor:
                              WidgetStateProperty.all(Colors.white)),
                      child: Text('View Projects')))
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildProjectCard(Project project) {
    return Card(
      color: Colors.grey[100],
      elevation: 0,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              project.title,
              style: TextStyle(fontWeight: FontWeight.w600),
            ),
            SizedBox(
              height: 10,
            ),
            Text(project.shortDescription,
                style: TextStyle(color: Colors.grey[700])),
            SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: ElevatedButton(
                    onPressed: () async {
                      await _launchUrl(project.projectUrl);
                    },
                    style: ButtonStyle(
                      backgroundColor: WidgetStateProperty.all(Colors.orange),
                      foregroundColor: WidgetStateProperty.all(Colors.white),
                      shape: WidgetStateProperty.all(RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8))),
                      padding: WidgetStateProperty.all(
                          EdgeInsets.symmetric(vertical: 8, horizontal: 16)),
                    ),
                    child: Text('View Project Details'),
                  ),
                ),
                SizedBox(width: 8),
                SizedBox(
                  width: 100, // Reduced width of the button
                  child: OutlinedButton(
                    onPressed: () async {
                      await _launchUrl(project.codeUrl);
                    },
                    style: ButtonStyle(
                      side: WidgetStateProperty.all(
                        BorderSide(
                            color: Colors.orange,
                            width: 1), // Outline color and width
                      ),
                      foregroundColor: WidgetStateProperty.all(Colors.orange),
                      shape: WidgetStateProperty.all(RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8))),
                      padding: WidgetStateProperty.all(
                          EdgeInsets.symmetric(vertical: 8, horizontal: 8)),
                    ),
                    child: Text('View Code'),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
