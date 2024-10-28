import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:multi_select_flutter/dialog/multi_select_dialog_field.dart';
import 'package:multi_select_flutter/util/multi_select_item.dart';
import 'package:opso/modals/book_mark_model.dart';
import 'package:opso/modals/outreachy_project_modal.dart';
import 'package:opso/programs_info_pages/outreachy_info.dart';
import 'package:opso/widgets/outreachy_project_widget.dart';
import 'package:opso/widgets/year_button.dart';

class OutreachyScreen extends StatefulWidget {
  const OutreachyScreen({Key? key}) : super(key: key);

  @override
  _OutreachyScreenState createState() => _OutreachyScreenState();
}

class _OutreachyScreenState extends State<OutreachyScreen> {
  String currentPage = "/outreachy";
  String currentProject = "Outreachy";
  List<OutreachyProjectModal> outreachy2024 = [];
  List<OutreachyProjectModal> outreachy2023 = [];
  List<OutreachyProjectModal> outreachy2022 = [];
  List<OutreachyProjectModal> outreachy2021 = [];
  bool isBookmarked = false;
  bool isBookmarkEnabled = false;
  List<String> allSkills = [];
  List<String> selectedSkills = ['All'];
  int selectedYear = 2021;

  List<OutreachyProjectModal> projectList = [];

  Future<void>? getProjectFunction;

  Future<void> initializeProjectLists() async {
    await _loadProjects(
        'assets/projects/outreachy/outreachy2024.json', outreachy2024);
    await _loadProjects(
        'assets/projects/outreachy/outreachy2023.json', outreachy2023);
    await _loadProjects(
        'assets/projects/outreachy/outreachy2022.json', outreachy2022);
    await _loadProjects(
        'assets/projects/outreachy/outreachy2021.json', outreachy2021);

    allSkills = _extractUniqueSkills();
    projectList = List.from(outreachy2021);
  }

  Future<void> _loadProjects(
      String path, List<OutreachyProjectModal> list) async {
    try {
      String response = await rootBundle.loadString(path);
      if (response.isNotEmpty) {
        var jsonList = json.decode(response) as List;
        list.addAll(jsonList
            .map((data) => OutreachyProjectModal.fromMap(data))
            .toList());
        print('Loaded projects from $path: ${list.length}');
      } else {
        print('Error: JSON data is null or empty in $path');
      }
    } catch (e) {
      print('Error loading projects from $path: $e');
    }
  }

  List<String> _extractUniqueSkills() {
    return {
      'All',
      ...outreachy2024.expand((project) => project.skills),
      ...outreachy2023.expand((project) => project.skills),
      ...outreachy2022.expand((project) => project.skills),
      ...outreachy2021.expand((project) => project.skills),
    }.toSet().toList();
  }

  List<OutreachyProjectModal> _getProjectsByYear() {
    switch (selectedYear) {
      case 2021:
        return outreachy2021;
      case 2022:
        return outreachy2022;
      case 2023:
        return outreachy2023;
      case 2024:
        return outreachy2024;
      default:
        return [];
    }
  }

  void filterProjects() {
    projectList = _getProjectsByYear();

    if (!selectedSkills.contains('All')) {
      projectList = projectList
          .where((project) =>
              project.skills.any((skill) => selectedSkills.contains(skill)))
          .toList();
    }

    setState(() {});
  }

  void _updateSkillsList() {
    allSkills = _extractUniqueSkills();
    allSkills.insert(0, 'All');
  }

  @override
  void initState() {
    super.initState();
    getProjectFunction = initializeProjectLists();
    _checkBookmarkStatus();
  }

  Future<void> _checkBookmarkStatus() async {
    bool bookmarkStatus = await HandleBookmark.isBookmarked(currentProject);
    setState(() {
      isBookmarked = bookmarkStatus;
    });
  }

  Future<void> _refresh() async {
    await initializeProjectLists();
    setState(() {
      selectedYear = 2021;
      selectedSkills = ['All'];
    });
  }

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;

    return RefreshIndicator(
      onRefresh: _refresh,
      child: Scaffold(
        appBar: AppBar(title: const Text('Outreachy',
                    style: TextStyle(
              fontFamily: 'Outfit',
                fontWeight: FontWeight.w500, 
                ),
        ), actions: <Widget>[
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
                  content: Text(
                      isBookmarked ? 'Bookmark added' : 'Bookmark removed'),
                  duration: const Duration(seconds: 2),
                ),
              );
              if (isBookmarked) {
                HandleBookmark.addBookmark(currentProject, currentPage);
              } else {
                HandleBookmark.deleteBookmark(currentProject);
              }
            },
          ),
          IconButton(
            icon: Icon(Icons.info_outline),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => OUTREACHYInfo()),
              );
            },
          ),
        ]),
        body: FutureBuilder<void>(
          future: getProjectFunction,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            } else if (snapshot.connectionState == ConnectionState.done) {
              return SingleChildScrollView(
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      _buildYearButtons(),
                      const SizedBox(height: 20),
                      _buildMultiSelectField(
                        items: allSkills,
                        selectedValues: selectedSkills,
                        title: "Select Skills",
                        buttonText: "Filter by Skill",
                        onConfirm: (results) {
                          setState(() {
                            selectedSkills =
                                results.isNotEmpty ? results : ['All'];
                            filterProjects();
                          });
                        },
                      ),
                      const SizedBox(height: 20),
                      ..._projectListItems(height, width),
                    ],
                  ),
                ),
              );
            } else {
              return const Center(child: Text("Some error occurred"));
            }
          },
        ),
      ),
    );
  }

  Widget _buildYearButtons() {
    return SizedBox(
      height: MediaQuery.of(context).size.height * 0.2,
      child: GridView(
        physics: const NeverScrollableScrollPhysics(),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          childAspectRatio: 1.5 / 0.6,
          crossAxisCount: 2,
          crossAxisSpacing: 15,
          mainAxisSpacing: 15,
        ),
        children: [
          YearButton(
            year: "2021",
            isEnabled: selectedYear == 2021,
            onTap: () {
              setState(() {
                selectedYear = 2021;
                filterProjects();
              });
            },
            backgroundColor: selectedYear == 2021
                ? Colors.white
                : Color.fromRGBO(255, 183, 77, 1),
          ),
          YearButton(
            year: "2022",
            isEnabled: selectedYear == 2022,
            onTap: () {
              setState(() {
                selectedYear = 2022;
                filterProjects();
              });
            },
            backgroundColor: selectedYear == 2022
                ? Colors.white
                : Color.fromRGBO(255, 183, 77, 1),
          ),
          YearButton(
            year: "2023",
            isEnabled: selectedYear == 2023,
            onTap: () {
              setState(() {
                selectedYear = 2023;
                filterProjects();
              });
            },
            backgroundColor: selectedYear == 2023
                ? Colors.white
                : Color.fromRGBO(255, 183, 77, 1),
          ),
          YearButton(
            year: "2024",
            isEnabled: selectedYear == 2024,
            onTap: () {
              setState(() {
                selectedYear = 2024;
                filterProjects();
              });
            },
            backgroundColor: selectedYear == 2024
                ? Colors.white
                : Color.fromRGBO(255, 183, 77, 1),
          ),
        ],
      ),
    );
  }

  Widget _buildMultiSelectField({
    required List<String> items,
    required List<String> selectedValues,
    required String title,
    required String buttonText,
    required void Function(List<String>) onConfirm,
  }) {
    bool isDarkMode = Theme.of(context).brightness == Brightness.dark;
    return MultiSelectDialogField(
      backgroundColor: isDarkMode ? Colors.grey.shade100 : Colors.white,
      items: items.map((e) => MultiSelectItem<String>(e, e)).toList(),
      initialValue: selectedValues,
      title: Text(title),
      buttonText: Text(buttonText),
      onConfirm: onConfirm,
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey),
        borderRadius: BorderRadius.circular(10),
      ),
    );
  }

  List _projectListItems(double height, double width) {
    return List.generate(
      projectList.length,
      (index) => Padding(
        padding: const EdgeInsets.symmetric(vertical: 10),
        child: OutreachyProjectWidget(
          modal: projectList[index],
          index: index + 1,
          height: height * 0.2,
          width: width,
        ),
      ),
    );
  }
}
