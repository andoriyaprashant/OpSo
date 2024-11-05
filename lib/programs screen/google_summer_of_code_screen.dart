import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:opso/modals/book_mark_model.dart';
import 'package:opso/programs_info_pages/gsoc_info.dart';
import 'package:opso/widgets/gsoc/GsocProjectWidget.dart';
import 'package:multi_select_flutter/multi_select_flutter.dart';
import '../modals/GSoC/Gsoc.dart';
import '../widgets/year_button.dart';

class GoogleSummerOfCodeScreen extends StatefulWidget {
  const GoogleSummerOfCodeScreen({super.key});

  @override
  State<GoogleSummerOfCodeScreen> createState() =>
      _GoogleSummerOfCodeScreenState();
}

class _GoogleSummerOfCodeScreenState extends State<GoogleSummerOfCodeScreen> {
  bool _isRefreshing = false;

  bool isBookmarked = true;
  String currentPage = "/google_summer_of_code";
  String currentProject = "Google Summer of Code";

  int selectedYear = 2024;
  List<String> selectedProposals = ['All'];

  List<Organization> gsoc2024 = [];
  List<Organization> gsoc2023 = [];
  List<Organization> gsoc2022 = [];
  List<Organization> gsoc2021 = [];

  List<String> languages = [
    'All',
    'js',
    'python',
    'django',
    'Angular',
    'Bootstrap',
    'Firebase',
    'Node',
    'MongoDb',
    'Express',
    'Next',
    'css',
    'html',
    'javascript',
    'flutter',
    'Dart'
  ];

  List<Organization> orgList = [];
  List<String> selectedLanguages = [];

  late Future<void> _dataFetchFuture;

  @override
  void initState() {
    super.initState();
    _dataFetchFuture = initializeProjectLists();
    _checkBookmarkStatus();
  }

  Future<List<Organization>> loadOrganizations(int year) async {
    setState(() {
      _isRefreshing = true;
    });
    String path = 'assets/projects/gsoc_org/gsoc${year}org.json';
    String response = await rootBundle.loadString(path);

    setState(() {
      _isRefreshing = false;
    });
    var decodedResponse = json.decode(response) as List;
    return decodedResponse.map((org) => Organization.fromJson(org)).toList();
  }

  Future<void> _checkBookmarkStatus() async {
    bool bookmarkStatus = await HandleBookmark.isBookmarked(currentProject);
    setState(() {
      isBookmarked = bookmarkStatus;
    });
  }

  void filterProjects() async {
    orgList = await _getOrganizationsByYear(selectedYear);

    if (selectedLanguages.length >= 2) {
      selectedLanguages.removeAt(0);
    }

    if (!selectedLanguages.contains('All')) {
      orgList = orgList
          .where((project) => selectedLanguages.every(
              (language) => project.technologies.contains(language) == true))
          .toList();
    }

    setState(() {});
  }

  Future<List<Organization>> _getOrganizationsByYear(int year) async {
    switch (year) {
      case 2021:
        if (gsoc2021.isEmpty) gsoc2021 = await loadOrganizations(year);
        return gsoc2021;
      case 2022:
        if (gsoc2022.isEmpty) gsoc2022 = await loadOrganizations(year);
        return gsoc2022;
      case 2023:
        if (gsoc2023.isEmpty) gsoc2023 = await loadOrganizations(year);
        return gsoc2023;
      case 2024:
        if (gsoc2024.isEmpty) gsoc2024 = await loadOrganizations(year);
        return gsoc2024;
      default:
        return [];
    }
  }

  Future<void> _refresh() async {
    setState(() {
      initializeProjectLists();
      selectedYear = 2024;
      selectedLanguages = ['All'];
      filterProjects();
    });
  }

  // Add this method to the _GoogleSummerOfCodeScreenState class
  void search(String searchText) async {
    orgList = await _getOrganizationsByYear(selectedYear);

    if (searchText.isNotEmpty) {
      orgList = orgList
          .where((element) =>
              element.name.toLowerCase().contains(searchText.toLowerCase()) ==
              true)
          .toList();
    }

    setState(() {});
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
              onPressed: () => Navigator.of(context).pop()),
          centerTitle: true,
          title: const Text('GSoC'),
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
                  if (kDebugMode) {
                    print("Adding");
                  }
                  HandleBookmark.addBookmark(currentProject, currentPage);
                } else {
                  if (kDebugMode) {
                    print("Deleting");
                  }
                  HandleBookmark.deleteBookmark(currentProject);
                }
              },
            ),
            IconButton(
              icon: const Icon(Icons.info_outline),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const GSOCInfo()),
                );
              },
            ),
          ],
        ),
        body: FutureBuilder<void>(
          future: _dataFetchFuture,
          builder: (context, snapshot) {
            if (snapshot.hasError) {
              return Center(child: Text('Error: ${snapshot.error}'));
            } else {
              return SingleChildScrollView(
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 46, vertical: 16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      TextFormField(
                        decoration: InputDecoration(
                          filled: true,
                          hintText: 'Search',
                          suffixIcon: const Icon(Icons.search),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: const BorderSide(
                              color: Color(0xFFEEEEEE),
                            ),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: const BorderSide(
                              color: Color(0xFFEEEEEE),
                            ),
                          ),
                          disabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: const BorderSide(
                              color: Color(0xFFEEEEEE),
                            ),
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: const BorderSide(
                              color: Color(0xFFEEEEEE),
                            ),
                          ),
                          contentPadding: const EdgeInsets.symmetric(
                              vertical: 12.0, horizontal: 20.0),
                        ),
                        onFieldSubmitted: (value) {
                          search(value.trim());
                        },
                        onChanged: (value) {
                          if (value.isEmpty) {
                            search(value);
                          }
                        },
                      ),
                      const SizedBox(height: 20),
                      SizedBox(
                        height: height * 0.2,
                        width: width,
                        child: GridView(
                          physics: const NeverScrollableScrollPhysics(),
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            childAspectRatio: 1.5 / 0.6,
                            crossAxisSpacing: 15,
                            mainAxisSpacing: 15,
                          ),
                          children: [
                            for (int year = 2021; year <= 2024; year++)
                              YearButton(
                                year: year.toString(),
                                isEnabled: selectedYear == year,
                                onTap: () {
                                  setState(() {
                                    selectedYear = year;
                                    filterProjects();
                                  });
                                },
                                backgroundColor: selectedYear == year
                                    ? Colors.white
                                    : const Color.fromRGBO(255, 183, 77, 1),
                              ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 20),
                      _buildMultiSelectField(
                        items: languages,
                        selectedValues: selectedLanguages,
                        title: "Select Languages",
                        buttonText: "Filter by Language",
                        onConfirm: (results) {
                          setState(() {
                            selectedLanguages =
                                results.isNotEmpty ? results : [];
                            if (kDebugMode) {
                              print(selectedLanguages);
                            }
                            filterProjects();
                          });
                        },
                      ),
                      const SizedBox(height: 20),
                      _isRefreshing
                          ? const Column(
                              children: [
                                SizedBox(height: 50),
                                Center(
                                    child: Column(
                                  children: [
                                    CircularProgressIndicator(),
                                    SizedBox(height: 10),
                                    Text('Loading...'),
                                  ],
                                )),
                                SizedBox(height: 20),
                              ],
                            )
                          : ListView.builder(
                              shrinkWrap: true,
                              physics: const NeverScrollableScrollPhysics(),
                              itemCount: orgList.length,
                              itemBuilder: (context, index) {
                                return Padding(
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 10),
                                  child: Container(
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(20),
                                      boxShadow: [
                                        BoxShadow(
                                          color: Colors.grey.withOpacity(0.5),
                                          spreadRadius: 2,
                                          blurRadius: 5,
                                          offset: const Offset(0,
                                              3), // changes position of shadow
                                        ),
                                      ],
                                    ),
                                    child: Column(
                                      children: [
                                        GsocProjectWidget(
                                          index: index + 1,
                                          modal: orgList[index],
                                          height: height * 0.2,
                                          width: width,
                                        ),
                                      ],
                                    ),
                                  ),
                                );
                              },
                            ),
                    ],
                  ),
                ),
              );
            }
          },
        ),
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

  Future<void> initializeProjectLists() async {
    orgList = await _getOrganizationsByYear(selectedYear);
  }
}
