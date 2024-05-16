import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:opso/modals/sob_project_modal.dart';
import 'package:opso/widgets/sob_project_widget.dart';
import 'package:opso/widgets/year_button.dart';

class BitcoinSummer extends StatefulWidget {
  const BitcoinSummer({Key? key}) : super(key: key);

  @override
  State<BitcoinSummer> createState() => _BitcoinSummerState();
}

class _BitcoinSummerState extends State<BitcoinSummer> {
  bool isBookmarked = true;
  String currectPage = "/summer_of_bitcoin";
  String currentProject = "Summer of Bitcoin";
  List<SobProjectModal> sob2023 = [];
  List<SobProjectModal> sob2022 = [];
  List<SobProjectModal> sob2021 = [];
  int selectedYear = 2023;

  List<SobProjectModal> projectList = [];
  late Future<void> getProjectFunction;

  Future<void> initializeProjectLists() async {
    String response =
        await rootBundle.loadString('assets/projects/sob/sob2023.json');
    var jsonList = await json.decode(response);
    for (var data in jsonList) {
      sob2023.add(SobProjectModal.fromMap(data));
    }
    projectList = sob2023;

    response = await rootBundle.loadString('assets/projects/sob/sob2022.json');
    jsonList = await json.decode(response);
    for (var data in jsonList) {
      sob2022.add(SobProjectModal.fromMap(data));
    }
    response = await rootBundle.loadString('assets/projects/sob/sob2021.json');
    jsonList = await json.decode(response);
    for (var data in jsonList) {
      sob2021.add(SobProjectModal.fromMap(data));
    }
  }

  @override
  void initState() {
    getProjectFunction = initializeProjectLists();
    _checkBookmarkStatus();
    super.initState();
  }

  Future<void> _checkBookmarkStatus() async {
    bool bookmarkStatus = await HandleBookmark.isBookmarked(currentProject);
    setState(() {
      isBookmarked = bookmarkStatus;
    });
  }

  void search(String searchText) {
    if (searchText.isEmpty) {
      switch (selectedYear) {
        case 2021:
          projectList = sob2021;
          break;
        case 2022:
          projectList = sob2022;
          break;
        case 2023:
          projectList = sob2023;
          break;
      }
      setState(() {});
      return;
    }
    searchText = searchText.toLowerCase();
    projectList = projectList
        .where((element) =>
            element.name.toLowerCase().contains(searchText) ||
            element.mentor.toLowerCase().contains(searchText) ||
            element.organization.toLowerCase().contains(searchText) ||
            element.description.toLowerCase().contains(searchText) ||
            element.university.toLowerCase().contains(searchText))
        .toList();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        title: const Text('OpSo'),
        actions: <Widget>[
          IconButton(
            icon: (isBookmarked)
                ? const Icon(Icons.bookmark_add_rounded)
                : const Icon(Icons.bookmark_add_outlined),
            onPressed: () {
              setState(() {
                isBookmarked = !isBookmarked;
              });
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(isBookmarked
                      ? 'Bookmark added'
                      : 'Bookmark removed'),
                  duration: const Duration(seconds: 2),
                ),
              );
              if (isBookmarked) {
                print("Adding");
                HandleBookmark.addBookmark(currentProject, currectPage);
              } else {
                print("Deleting");
                HandleBookmark.deleteBookmark(currentProject);
              }
            },
          )
        ],
      ),
      body: FutureBuilder<void>(
        future: getProjectFunction,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.connectionState == ConnectionState.done) {
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  TextFormField(
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: const Color(0xFFEEEEEE),
                      hintText: 'Search',
                      suffixIcon: const Icon(Icons.search),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: const BorderSide(
                          color: Color(0xFFEEEEEE),
                        ),
                      ),
                      contentPadding: const EdgeInsets.symmetric(
                        vertical: 12.0,
                        horizontal: 20.0,
                      ),
                    ),
                    onChanged: (value) {
                      search(value);
                    },
                  ),
                  const SizedBox(height: 20),
                  Expanded(
                    child: ListView.builder(
                      itemCount: projectList.length,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: const EdgeInsets.symmetric(vertical: 10),
                          child: SobProjectWidget(
                            modal: projectList[index],
                            height: height * 0.2,
                            width: width,
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            );
          } else {
            return const Center(child: Text("Some error occurred"));
          }
        },
      ),
    );
  }
}
