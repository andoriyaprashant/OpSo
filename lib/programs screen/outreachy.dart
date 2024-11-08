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
    await _loadProjects('assets/projects/outreachy/outreachy$selectedYear.json',
        _getProjectsByYear());

    allSkills = _extractUniqueSkills();
    projectList = List.from(_getProjectsByYear());
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
    final skillsSet = <String>{'All'};
    
    for (var project in [
      ...outreachy2021,
      ...outreachy2022,
      ...outreachy2023,
      ...outreachy2024
    ]) {
      skillsSet.addAll(project.skills);
    }

    return skillsSet.toList();
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

  void filterProjects([String query = ""]) {
    projectList = _getProjectsByYear();

    if (!selectedSkills.contains('All')) {
      projectList = projectList
          .where((project) =>
              project.skills.any((skill) => selectedSkills.contains(skill)))
          .toList();
    }

    if (query.isNotEmpty) {
      projectList = projectList
          .where((project) =>
              project.name.toLowerCase().contains(query.toLowerCase()))
          .toList();
    }

    setState(() {});
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
        appBar: AppBar(
            leading: IconButton(
              icon: const Icon(Icons.arrow_back_ios),
              onPressed: () => Navigator.of(context).pop(),
            ),
            centerTitle: true,
            title: const Text('Outreachy'),
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
                      _buildSearchBar(),
                      const SizedBox(height: 20),
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

  Widget _buildSearchBar() {
    return TextFormField(
      decoration: InputDecoration(
        filled: true,
        hintText: 'Search',
        suffixIcon: const Icon(Icons.search),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(color: Color(0xFFEEEEEE)),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(color: Color(0xFFEEEEEE)),
        ),
        disabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(color: Color(0xFFEEEEEE)),
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(color: Color(0xFFEEEEEE)),
        ),
        contentPadding:
            const EdgeInsets.symmetric(vertical: 12.0, horizontal: 20.0),
      ),
      onFieldSubmitted: (value) {
        filterProjects(value);
      },
      onChanged: (value) {
        if (value.isEmpty) {
          filterProjects(value);
        }
      },
    );
  }

  Widget _buildYearButtons() {
    return GridView.count(
      crossAxisCount: 2,
      childAspectRatio: 1.5 / 0.6,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      children: [2021, 2022, 2023, 2024].map((year) {
        bool isSelected = selectedYear == year;
        return Padding(
          padding: const EdgeInsets.all(5.0),
          child: YearButton(
            year: year.toString(),
            isEnabled: isSelected,
            onTap: () async {
              selectedYear = year;

              if (_getProjectsByYear().isEmpty) {
                _loadProjects('assets/projects/outreachy/outreachy$year.json', _getProjectsByYear());
                allSkills = _extractUniqueSkills();
              }

              setState(() {
                filterProjects();
              });
            },
            backgroundColor:
                isSelected ? Colors.white : Color.fromRGBO(255, 183, 77, 1),
          ),
        );
      }).toList(),
    );
  }

  Widget _buildMultiSelectField({
    required List<String> items,
    required List<String> selectedValues,
    required String title,
    required String buttonText,
    required void Function(List<String>) onConfirm,
  }) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    final textColor = isDarkMode ? Colors.white : Colors.black;

    return MultiSelectDialogField<String>(
      backgroundColor: isDarkMode ? Colors.black : Colors.white,
      items: [for (final item in items) MultiSelectItem<String>(item, item)],
      initialValue: selectedValues,
      selectedColor: Colors.orange[500],
      itemsTextStyle: TextStyle(color: textColor),
      selectedItemsTextStyle: TextStyle(color: textColor),
      confirmText: Text('OK', style: TextStyle(color: textColor)),
      cancelText: Text('CANCEL', style: TextStyle(color: textColor)),
      title: Text(
        title,
        style: TextStyle(color: textColor),
      ),
      buttonText: Text(
        buttonText,
        style: TextStyle(color: textColor),
      ),
      onConfirm: onConfirm,
      decoration: BoxDecoration(
        border: Border.all(color: isDarkMode ? Colors.white : Colors.grey),
        borderRadius: const BorderRadius.all(Radius.circular(10)),
      ),
      searchable: true, // Enable search functionality
      searchHint: 'Search skills',
      searchHintStyle: TextStyle(color: textColor),
    );
  }

  List<Widget> _projectListItems(double height, double width) {
    return [
      ListView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: projectList.length,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 10),
            child: OutreachyProjectWidget(
              modal: projectList[index],
              index: index + 1,
              height: height * 0.2,
              width: width,
            ),
          );
        },
      )
    ];
  }
}
