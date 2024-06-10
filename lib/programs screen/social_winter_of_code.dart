import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:multi_select_flutter/dialog/multi_select_dialog_field.dart';
import 'package:multi_select_flutter/util/multi_select_item.dart';
import 'package:opso/modals/book_mark_model.dart';
import 'package:opso/modals/swoc_project_modal.dart';
import 'package:opso/widgets/swoc_project_widget.dart';
import 'package:opso/widgets/year_button.dart';


class SWOCScreen extends StatefulWidget {
  const SWOCScreen({super.key});


  @override
  State<SWOCScreen> createState() => _SWOCScreenState();
}


class _SWOCScreenState extends State<SWOCScreen> {
  String currentPage = "/social_winter_of_code";
  String currentProject = "Social Winter of Code";
  List<SwocProjectModal> swoc2024 = [];
  List<SwocProjectModal> swoc2023 = [];
  List<SwocProjectModal> swoc2021 = [];
  List<SwocProjectModal> swoc2020 = [];
  List<String> allOrganizations = [];
  List<String> allLanguages = [];
  List<String> selectedOrganizations = ['All'];
  List<String> selectedLanguages = ['All'];
  int selectedYear = 2020;
  bool isBookmarked = true;
  List<SwocProjectModal> projectList = [];
  Future<void>? getProjectFunction;


  Future<void> initializeProjectLists() async {
    await _loadProjects('assets/projects/swoc/swoc2024.json', swoc2024);
    await _loadProjects('assets/projects/swoc/swoc2023.json', swoc2023);
    await _loadProjects('assets/projects/swoc/swoc2021.json', swoc2021);
    await _loadProjects('assets/projects/swoc/swoc2020.json', swoc2020);


    // Populate all unique organizations and languages
    allOrganizations = _extractUniqueValues((project) => project.owner);
    allLanguages = languages;
    projectList = List.from(swoc2024); // Default year
  }


  List<String> languages = [
    'All',
    'Js',
    'Python',
    'React',
    'Angular',
    'Bootstrap',
    'Firebase',
    'Node',
    'MongoDb',
    'Express',
    'Next',
    'CSS',
    'HTML',
    'JavaScript',
    'Flutter',
    'Dart'
  ];


  Future<void> _loadProjects(String path, List<SwocProjectModal> list) async {
    try {
      String response = await rootBundle.loadString(path);
      if (response.isNotEmpty) {
        var jsonList = json.decode(response) as List;
        list.addAll(jsonList.map((data) => SwocProjectModal.getDataFromJson(data)).toList());
        print('Loaded projects from $path: ${list.length}');
      } else {
        print('Error: JSON data is null or empty in $path');
      }
    } catch (e) {
      print('Error loading projects from $path: $e');
    }
  }





  List<String> _extractUniqueValues(String Function(SwocProjectModal) extractor) {
    return {
      'All',
      ...swoc2024.map(extractor),
      ...swoc2023.map(extractor),
      ...swoc2021.map(extractor),
      ...swoc2020.map(extractor),
    }.toList();
  }


  List<String> _extractUniqueLanguages(List<String> Function(SwocProjectModal) extractor) {
    final allLanguages = [
      for (var project in swoc2024) ...extractor(project),
      for (var project in swoc2023) ...extractor(project),
      for (var project in swoc2021) ...extractor(project),
      for (var project in swoc2020) ...extractor(project),
    ];
    return ['All', ...allLanguages.toSet()];
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


  void filterProjects() {
    // Filter projects by year first
    projectList = _getProjectsByYear();


    // Filter projects by selected languages
    if (!selectedLanguages.contains('All')) {
      projectList = projectList.where((project) =>
          selectedLanguages.every((language) => project.techstack.contains(language))
      ).toList();
    }


    // Update the list of organizations based on the filtered projects by language
    _updateOrganizationList();


    // Filter projects by selected organizations
    if (!selectedOrganizations.contains('All')) {
      projectList = projectList.where((project) => selectedOrganizations.contains(project.owner)).toList();
    }


    // Ensure state is updated to reflect changes
    setState(() {});
  }




  void _updateOrganizationList() {
    allOrganizations = _extractUniqueValues((project) => project.owner)
        .where((organization) => projectList.any((project) => project.owner == organization))
        .toList();
    allOrganizations.insert(0, 'All');
  }


  List<SwocProjectModal> _getProjectsByYear() {
    switch (selectedYear) {
      case 2020:
        return swoc2020;
      case 2021:
        return swoc2021;
      case 2023:
        return swoc2023;
      case 2024:
        return swoc2024;
      default:
        return [];
    }
  }


  Future<void> _refresh() async {
    await initializeProjectLists();
    setState(() {
      selectedYear = 2020;
      selectedOrganizations = ['All'];
      selectedLanguages = ['All'];
    });
  }


  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;


    return RefreshIndicator(
      onRefresh: _refresh,
      child: Scaffold(
        appBar: AppBar(title: const Text('SWoC'), actions: <Widget>[
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
                  content: Text(isBookmarked ? 'Bookmark added' : 'Bookmark removed'),
                  duration: const Duration(seconds: 2),
                ),
              );
              if (isBookmarked) {
                HandleBookmark.addBookmark(currentProject, currentPage);
              } else {
                HandleBookmark.deleteBookmark(currentProject);
              }
            },
          )
        ]),
        body: FutureBuilder<void>(
          future: getProjectFunction,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            } else if (snapshot.connectionState == ConnectionState.done) {
              return SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 48, vertical: 8),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      _buildSearchBar(),
                      const SizedBox(height: 20),
                      _buildYearButtons(),
                      const SizedBox(height: 20),
                      _buildMultiSelectField(
                        items: allLanguages,
                        selectedValues: selectedLanguages,
                        title: "Select Languages",
                        buttonText: "Filter by Language",
                        onConfirm: (results) {
                          setState(() {
                            selectedLanguages = results.isNotEmpty ? results : ['All'];
                            filterProjects();
                          });
                        },
                      ),
                      const SizedBox(height: 20),
                      const SizedBox(height: 20),
                      _buildProjectList(height, width),
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
        contentPadding: const EdgeInsets.symmetric(vertical: 12.0, horizontal: 20.0),
      ),
      onFieldSubmitted: (value) {
        setState(() {
          projectList = _getProjectsByYear()
              .where((project) => project.name.toLowerCase().contains(value.toLowerCase()))
              .toList();
        });
      },
      onChanged: (value) {
        if (value.isEmpty) {
          setState(() {
            projectList = _getProjectsByYear();
          });
        }
      },
    );
  }


  Widget _buildYearButtons() {
    return SizedBox(
      height: MediaQuery.sizeOf(context).height * 0.2,
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
            year: "2020",
            isEnabled: selectedYear == 2020,
            onTap: () {
              setState(() {
                selectedYear = 2020;
                filterProjects();
              });
            },
            backgroundColor: selectedYear == 2020 ? Colors.white : const Color.fromRGBO(255, 183, 77, 1),
          ),
          YearButton(
            year: "2021",
            isEnabled: selectedYear == 2021,
            onTap: () {
              setState(() {
                selectedYear = 2021;
                filterProjects();
              });
            },
            backgroundColor: selectedYear == 2021 ? Colors.white : const Color.fromRGBO(255, 183, 77, 1),
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
            backgroundColor: selectedYear == 2023 ? Colors.white : const Color.fromRGBO(255, 183, 77, 1),
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
            backgroundColor: selectedYear == 2024 ? Colors.white : const Color.fromRGBO(255, 183, 77, 1),
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
      title: Text(title,style: TextStyle(color: isDarkMode ? Colors.black : Colors.black)),
      buttonText: Text(buttonText),
      onConfirm: onConfirm,
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey),
        borderRadius: BorderRadius.circular(10),
      ),
    );
  }


  Widget _buildProjectList(double height, double width) {
    return SizedBox(
      height: height,
      child: ListView.builder(
        itemCount: projectList.length,
        itemBuilder: (BuildContext context, int index) {
          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 10),
            child: SwocProjectWidget(
              index: index + 1,
              modal: projectList[index],
              height: height * 0.2,
              width: width,
            ),
          );
        },
      ),
    );
  }
}

