import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

Widget ArticleButton(int index, BuildContext context) {
  return GestureDetector(
    onTap: () {
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) =>
                  ArticlePage(data: programSummaries[index])));
    },
    child: Icon(FontAwesomeIcons.circleInfo),
  );
}

class ProgramSummary {
  final String title;
  final String description;
  final String imageAssetPath;
  final String link;

  ProgramSummary(
      {required this.title,
      required this.imageAssetPath,
      required this.description,
      required this.link});
}

final List<ProgramSummary> programSummaries = [
  ProgramSummary(
    title: 'Google Summer of Code',
    imageAssetPath: 'assets/gsoc_logo.png',
    link: '',
    description:
        'An annual program by Google offering stipends to students for contributing to open-source projects.',
  ),
  ProgramSummary(
    title: 'Google Season of Docs',
    imageAssetPath: 'assets/Google_season_of_docs.png',
    link: '',
    description:
        'Focuses on documentation improvement for various open-source projects, with technical writers collaborating with organizations.',
  ),
  ProgramSummary(
    title: 'Major League Hacking Fellowship',
    imageAssetPath: 'assets/mlh_logo.jpg',
    link: '',
    description:
        'Offers remote internships for aspiring developers to work on open-source projects with mentorship.',
  ),
  ProgramSummary(
    title: 'Summer of Bitcoin',
    imageAssetPath: 'assets/summer_of_bitcoin_logo.png',
    link: '',
    description:
        'Fosters development in the Bitcoin ecosystem by supporting projects like core protocol improvements and wallet development.',
  ),
  ProgramSummary(
    title: 'Linux Foundation',
    imageAssetPath: 'assets/linux_foundation_logo.png',
    link: '',
    description:
        'Supports various open-source projects and communities, including the Linux kernel, providing resources and collaboration platforms.',
  ),
  ProgramSummary(
    title: 'Outreachy',
    imageAssetPath: 'assets/outreachy.png',
    link: '',
    description:
        'Provides internships for underrepresented groups in tech to work on open-source projects across different domains.',
  ),
  ProgramSummary(
    title: 'GirlScript Summer of Code',
    imageAssetPath: 'assets/girlscript_logo.png',
    link: '',
    description:
        'Encourages women to participate in open-source development by collaborating on projects spanning software development, documentation, and community building.',
  ),
];

class ArticlePage extends StatelessWidget {
  ProgramSummary data;
  ArticlePage({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    var media = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        elevation: 10,
        title: Text(data.title),
        centerTitle: true,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(Icons.arrow_back),
        ),
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            children: [
              SizedBox(
                height: media * 0.2,
              ),
              Image.asset(
                data.imageAssetPath,
                width: 300,
                height: 300,
                fit: BoxFit.contain,
              ),
              Text(
                data.title,
                textAlign: TextAlign.center,
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30),
              ),
              SizedBox(
                height: media * 0.1,
              ),
              Padding(
                padding: const EdgeInsets.all(20),
                child: Text(data.description,
                    textAlign: TextAlign.center,
                    style:
                        TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
              ),
              ElevatedButton(
                onPressed: () {},
                child: Text('View Website'),
              )
            ],
          ),
        ),
      ),
    );
  }
}
