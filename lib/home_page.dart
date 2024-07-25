import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:adaptive_theme/adaptive_theme.dart';
import 'package:opso/ChatBotpage.dart';
import 'package:opso/opso_timeline.dart';
import 'package:opso/services/notificationService.dart';
import 'package:opso/widgets/book_mark_screen.dart';
import 'package:opso/widgets/faq.dart';
import 'about.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0; // To track the selected tab
  int _initialLabelIndex = 0;

  @override
  void initState() {
    showNotification();
    _getInitialThemeMode();
    super.initState();
  }

  void _getInitialThemeMode() async {
    final savedThemeMode = await AdaptiveTheme.getThemeMode();
    setState(() {
      _initialLabelIndex = savedThemeMode == AdaptiveThemeMode.dark ? 1 : 0;
    });
  }

  void showNotification() async {
    await NotificationService.showNotification(
      title: "OpSo",
      body: "Explore various Open-Source Programs",
    );
  }

  List<Program> programs = [
    Program(title: 'Google Summer of Code', imageAssetPath: 'assets/gsoc_logo.png'),
    Program(title: 'Google Season of Docs', imageAssetPath: 'assets/Google_season_of_docs.png'),
    Program(title: 'Major League Hacking Fellowship', imageAssetPath: 'assets/mlh_logo.jpg'),
    Program(title: 'Summer of Bitcoin', imageAssetPath: 'assets/summer_of_bitcoin_logo.png'),
    Program(title: 'Linux Foundation', imageAssetPath: 'assets/linux_foundation_logo.png'),
    Program(title: 'Outreachy', imageAssetPath: 'assets/outreachy.png'),
    Program(title: 'GirlScript Summer of Code', imageAssetPath: 'assets/girlscript_logo.png'),
    Program(title: 'Social Winter of Code', imageAssetPath: 'assets/swoc.png'),
    Program(title: 'Season of KDE', imageAssetPath: 'assets/sokde.png'),
    Program(title: 'Open Summer of Code', imageAssetPath: 'assets/open_summer_of_code.png'),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context);
    final double appBarFontSize = ScreenUtil().setSp(18);

    Widget _getBody(int index) {
      switch (index) {
        case 0:
          return ListView.builder(
            itemCount: programs.length,
            itemBuilder: (context, index) {
              final program = programs[index];
              return ProgramCard(program: program);
            },
          );
        case 1:
          return const BookMarkScreen();
        case 2:
          return  FAQPage();
        case 3:
          return const OpsoTimeLineScreen();
        case 4:
          return  AboutScreen();
        default:
          return Container();
      }
    }

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(
            AdaptiveTheme.of(context).mode.isDark
                ? FontAwesomeIcons.solidSun
                : FontAwesomeIcons.solidMoon,
          ),
          onPressed: () {
            setState(() {
              AdaptiveTheme.of(context).toggleThemeMode(useSystem: false);
            });
          },
        ),
        title: Text(
          'OpSo',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: appBarFontSize),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.search_sharp),
            onPressed: () {
              showSearch(
                context: context,
                delegate: ProgramSearchDelegate(programs: programs),
              );
            },
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const ChatBotPage(),
            ),
          );
        },
        child: const Icon(Icons.chat_bubble_outline),
      ),
      body: _getBody(_selectedIndex),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        backgroundColor: Colors.blueGrey[900],
        selectedItemColor: Colors.white,
        unselectedItemColor: Colors.white70,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.bookmark),
            label: 'Bookmarks',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.help),
            label: 'FAQ',
          ),
          BottomNavigationBarItem(
            icon: Icon(FontAwesomeIcons.timeline),
            label: 'Timeline',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.info_outline),
            label: 'About',
          ),
        ],
      ),
    );
  }
}

class Program {
  final String title;
  final String imageAssetPath;

  Program({required this.title, required this.imageAssetPath});
}

class ProgramCard extends StatelessWidget {
  final Program program;

  const ProgramCard({required this.program});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      child: ListTile(
        leading: Image.asset(program.imageAssetPath, width: 50, height: 50),
        title: Text(program.title),
      ),
    );
  }
}

class ProgramSearchDelegate extends SearchDelegate {
  final List<Program> programs;

  ProgramSearchDelegate({required this.programs});

  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        icon: const Icon(Icons.clear),
        onPressed: () {
          query = '';
        },
      ),
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.arrow_back),
      onPressed: () {
        Navigator.of(context).pop();
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    final results = programs.where((program) => program.title.toLowerCase().contains(query.toLowerCase()));

    return ListView(
      children: results.map((program) => ListTile(
        title: Text(program.title),
        leading: Image.asset(program.imageAssetPath),
      )).toList(),
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    final suggestions = programs.where((program) => program.title.toLowerCase().contains(query.toLowerCase()));

    return ListView(
      children: suggestions.map((program) => ListTile(
        title: Text(program.title),
        leading: Image.asset(program.imageAssetPath),
      )).toList(),
    );
  }
}
