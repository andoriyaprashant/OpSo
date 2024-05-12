import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:opso/Functions/screenNavigation.dart';
import 'package:opso/widgets/SearchWidget.dart';
import 'package:opso/Screens/girl_script.dart';
import 'package:opso/Screens/mlh.dart';
import 'package:opso/Screens/google_season_of_docs_screen.dart';
import 'package:opso/Screens/google_summer_of_code_screen.dart';
import 'package:opso/Screens/summer_of_bitcoin.dart';
import 'package:opso/models/Contributor.dart';
import 'package:opso/widgets/ProgramOption.dart';

import 'bar.dart';
import 'dart:convert';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Contributor> contributors = [];
  Future<void> _dataEntry() async {
    String file = "assets/contributor.json";
    final String response = await rootBundle.loadString(file);
    final List<dynamic> jsonData = await json.decode(response);
    setState(() {
      contributors = jsonData
          .map((data) => Contributor(
                name: data['Name'],
                image: data['Image'],
              ))
          .toList();
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _dataEntry();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('OpSa'),
        actions: [
          IconButton(
            icon: const Icon(Icons.search_sharp),
            onPressed: () {
              showSearch(context: context, delegate: ProgramSearchDelegate());
            },
          ),
          IconButton(
            icon: const Icon(Icons.menu),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => AppBarWidget()),
              );
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(6.0),
        child: ListView.builder(
          itemCount: contributors.length,
          itemBuilder: (context, index) {
            String title = contributors[index].name;
            String imageAssetPath = contributors[index].image;

            return Container(
              padding: const EdgeInsets.all(10),
              child: ProgramOption(
                  title: title,
                  imageAssetPath: imageAssetPath,
                  onTap: () {
                    screenNavigation().navigateToScreen(context, title);
                  }),
            );
          },
        ),
      ),
    );
  }
}
