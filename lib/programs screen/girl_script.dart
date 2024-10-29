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

class GSSOCScreen extends StatefulWidget {
  const GSSOCScreen({super.key});

  @override
  State<GSSOCScreen> createState() => _GSSOCScreenState();
}

class _GSSOCScreenState extends State<GSSOCScreen> {
  String currentPage = "/girl_script_summer_of_code";
  String currentProject = "Girl Script Summer of Code";

  List<String> allLanguages = [];
  List<String> selectedLanguages = ['All'];

  int selectedYear = 2024;
  bool isBookmarked = true;
  Future<void>? getProjectFunction;

  /* List for each ear */
  List<GssocProjectModal> gssoc2024 = [],
      gssoc2023 = [],
      gssoc2022 = [],
      gssoc2021 = [];
  /* actual list to show */
  List<GssocProjectModal> projectList = [];

  /* for pagination */
  int itemsPerPage = 50;
  int pageNumber = 0;

  ScrollController _scrollController = ScrollController();

  Future<void> initializeProjectLists() async {
    projectList = await _getProjectsByYear(selectedYear);
    allLanguages = languages;

    setState(() {});
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

  Future<List<GssocProjectModal>> _getProjectsByYear(int year) async {
    switch (year) {
      case 2021:
        return gssoc2021.isEmpty ? await loadProjects(2021) : gssoc2021;
      case 2022:
        return gssoc2022.isEmpty ? await loadProjects(2022) : gssoc2022;
      case 2023:
        return gssoc2023.isEmpty ? await loadProjects(2023) : gssoc2023;
      case 2024:
        return gssoc2024.isEmpty ? await loadProjects(2024) : gssoc2024;
      default:
        return [];
    }
  }

  Future<List<GssocProjectModal>> loadProjects(int year) async {
    String path = 'assets/projects/gssoc/gssoc${year}.json';
    String response = await rootBundle.loadString(path);

    var jsonList = json.decode(response) as List;
    return jsonList
        .map((data) => GssocProjectModal.getDataFromJson(data))
        .toList();
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

  void filterProjects([String query = '']) async {
    projectList = await _getProjectsByYear(selectedYear);

    if (!selectedLanguages.contains('All')) {
      projectList = projectList
          .where((project) => selectedLanguages
              .every((language) => project.techstack.contains(language)))
          .toList();
    }

    if (query.isNotEmpty) {
      projectList = projectList
          .where((project) =>
              project.name.toLowerCase().contains(query.toLowerCase()))
          .toList();
    }

    pageNumber = 0;
    setState(() {});
  }

  Future<void> _refresh() async {
    await initializeProjectLists();
    setState(() {
      selectedYear = 2024;
      selectedLanguages = ['All'];
    });
  }

  List<GssocProjectModal> _getPaginatedProjects() {
    int startIndex = pageNumber * itemsPerPage;
    int endIndex = startIndex + itemsPerPage;
    return projectList.sublist(startIndex,
        endIndex > projectList.length ? projectList.length : endIndex);
  }

  void _nextPage() {
    if ((pageNumber + 1) * itemsPerPage < projectList.length) {
      setState(() {
        pageNumber++;
      });
      // Animate scrolling to the top of the list
      _scrollController.animateTo(
        0, // Scroll to the top
        duration:
            const Duration(milliseconds: 300), // Duration of the animation
        curve: Curves.easeInOut, // Animation curve for smoothness
      );
    }
  }

  void _previousPage() {
    if (pageNumber > 0) {
      setState(() {
        pageNumber--;
      });
      // Animate scrolling to the top of the list
      _scrollController.animateTo(
        0, // Scroll to the top
        duration:
            const Duration(milliseconds: 300), // Duration of the animation
        curve: Curves.easeInOut, // Animation curve for smoothness
      );
    }
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
                controller: _scrollController, // Attach ScrollController
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
                      _buildMultiSelectField(
                        items: allLanguages,
                        selectedValues: selectedLanguages,
                        title: "Select Languages",
                        buttonText: "Filter by Language",
                        onConfirm: (results) {
                          setState(() {
                            selectedLanguages =
                                results.isNotEmpty ? results : ['All'];

                            filterProjects();
                          });
                        },
                      ),
                      const SizedBox(height: 20),
                      _buildProjectList(),
                      const SizedBox(height: 10),
                      _buildPaginationControls(),
                      const SizedBox(height: 10),
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
          filterProjects(value);
        });
      },
      onChanged: (value) {
        if (value.isEmpty) {
          setState(() {
            filterProjects();
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
        itemCount: _getPaginatedProjects().length,
        itemBuilder: (BuildContext context, int index) {
          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 10),
            child: GssocProjectWidget(
              index: index +
                  1 +
                  (pageNumber * itemsPerPage), // Adjust index for pagination
              modal: _getPaginatedProjects()[index],
            ),
          );
        },
      ),
    );
  }

  Widget _buildPaginationControls() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        ElevatedButton(
          onPressed: pageNumber > 0 ? _previousPage : null,
          child: const Text('Previous', style: TextStyle(color: Colors.orange)),
        ),
        Text('Page ${pageNumber + 1}'),
        ElevatedButton(
          onPressed: (pageNumber + 1) * itemsPerPage < projectList.length
              ? _nextPage
              : null,
          child: const Text('Next', style: TextStyle(color: Colors.orange)),
        ),
      ],
    );
  }
}
