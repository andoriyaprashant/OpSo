import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:multi_select_flutter/dialog/multi_select_dialog_field.dart';
import 'package:multi_select_flutter/util/multi_select_item.dart';
import 'package:opso/modals/book_mark_model.dart';
import 'package:opso/modals/gssoc_project_modal.dart';
import 'package:opso/programs_info_pages/gssoc_info.dart';
import 'package:opso/widgets/gssoc_project_widget.dart';
import 'package:opso/widgets/year_button.dart';
import '../widgets/SearchandFilterWidget.dart';

class GSSOCScreen extends StatefulWidget {
  const GSSOCScreen({super.key});

  @override
  State<GSSOCScreen> createState() => _GSSOCScreenState();
}

class _GSSOCScreenState extends State<GSSOCScreen> {
  String currentPage = "/girl_script_summer_of_code";
  String currentProject = "Girl Script Summer of Code";
  List<GssocProjectModal> gssoc2024 = [];
  List<GssocProjectModal> gssoc2023 = [];
  List<GssocProjectModal> gssoc2022 = [];
  List<GssocProjectModal> gssoc2021 = [];
  List<String> allOrganizations = [];
  List<String> allLanguages = [];
  List<String> selectedOrganizations = ['All'];
  List<String> selectedLanguages = ['All'];
  int selectedYear = 2024;
  bool isBookmarked = true;
  List<GssocProjectModal> projectList = [];
  Future<void>? getProjectFunction;

  Future<void> initializeProjectLists() async {
    await _loadProjects('assets/projects/gssoc/gssoc2024.json', gssoc2024);
    await _loadProjects('assets/projects/gssoc/gssoc2023.json', gssoc2023);
    await _loadProjects('assets/projects/gssoc/gssoc2022.json', gssoc2022);
    await _loadProjects('assets/projects/gssoc/gssoc2021.json', gssoc2021);

    // Populate all unique organizations and languages
    allOrganizations = _extractUniqueValues((project) => project.hostedBy);
    allLanguages = languages;
    projectList = List.from(gssoc2024); // Default year
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

  Future<void> _loadProjects(String path, List<GssocProjectModal> list) async {
    String response = await rootBundle.loadString(path);
    var jsonList = json.decode(response) as List;
    list.addAll(jsonList
        .map((data) => GssocProjectModal.getDataFromJson(data))
        .toList());
  }

  List<String> _extractUniqueValues(
      String Function(GssocProjectModal) extractor) {
    return {
      'All',
      ...gssoc2024.map(extractor),
      ...gssoc2023.map(extractor),
      ...gssoc2022.map(extractor),
      ...gssoc2021.map(extractor),
    }.toList();
  }

  List<String> _extractUniqueLanguages(
      List<String> Function(GssocProjectModal) extractor) {
    final allLanguages = [
      for (var project in gssoc2024) ...extractor(project),
      for (var project in gssoc2023) ...extractor(project),
      for (var project in gssoc2022) ...extractor(project),
      for (var project in gssoc2021) ...extractor(project),
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
      projectList = projectList
          .where((project) => selectedLanguages
              .every((language) => project.techstack.contains(language)))
          .toList();
    }

    // Update the list of organizations based on the filtered projects by language
    _updateOrganizationList();

    // Filter projects by selected organizations
    if (!selectedOrganizations.contains('All')) {
      projectList = projectList
          .where((project) => selectedOrganizations.contains(project.hostedBy))
          .toList();
    }

    // Ensure state is updated to reflect changes
    setState(() {});
  }

  void _updateOrganizationList() {
    allOrganizations = _extractUniqueValues((project) => project.hostedBy)
        .where((organization) =>
            projectList.any((project) => project.hostedBy == organization))
        .toList();
    allOrganizations.insert(0, 'All');
  }

  List<GssocProjectModal> _getProjectsByYear() {
    switch (selectedYear) {
      case 2021:
        return gssoc2021;
      case 2022:
        return gssoc2022;
      case 2023:
        return gssoc2023;
      case 2024:
        return gssoc2024;
      default:
        return [];
    }
  }

  Future<void> _refresh() async {
    await initializeProjectLists();
    setState(() {
      selectedYear = 2024;
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
        appBar: AppBar(
            leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios),
         
          onPressed: () => Navigator.of(context).pop(),
        ),
        centerTitle: true,
          title: const Text('GSSoC'), actions: <Widget>[
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
            icon: const Icon(Icons.info_outline),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const GSSOCInfo()),
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
                      const EdgeInsets.symmetric(horizontal: 48, vertical: 8),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
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
                            selectedLanguages =
                                results.isNotEmpty ? results : ['All'];
                            print(selectedLanguages);
                            filterProjects();
                          });
                        },
                      ),
                      const SizedBox(height: 20),
                      const SizedBox(height: 20),
                      _buildProjectList(),
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
        setState(() {
          projectList = _getProjectsByYear()
              .where((project) =>
                  project.name.toLowerCase().contains(value.toLowerCase()))
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
      height: MediaQuery.of(context).size.height * 0.25,
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
                : const Color.fromRGBO(255, 183, 77, 1),
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
                : const Color.fromRGBO(255, 183, 77, 1),
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
                : const Color.fromRGBO(255, 183, 77, 1),
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
                : const Color.fromRGBO(255, 183, 77, 1),
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
      title: Text(title,
          style: TextStyle(color: isDarkMode ? Colors.black : Colors.black)),
      buttonText: Text(buttonText),
      onConfirm: onConfirm,
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey),
        borderRadius: BorderRadius.circular(10),
      ),
    );
  }

  Widget _buildProjectList() {
    return Container(
      child: ListView.builder(
        shrinkWrap: true,
        physics: NeverScrollableScrollPhysics(),
        itemCount: projectList.length,
        itemBuilder: (BuildContext context, int index) {
          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 10),
            child: GssocProjectWidget(
              index: index + 1,
              modal: projectList[index],
            ),
          );
        },
      ),
    );
  }
}
