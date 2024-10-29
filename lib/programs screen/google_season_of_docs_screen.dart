import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:multi_select_flutter/multi_select_flutter.dart';
import 'package:opso/modals/book_mark_model.dart';
import 'package:opso/modals/gsod/gsod_modal_new.dart';
import 'package:opso/modals/gsod/gsod_modal_old.dart';
import 'package:opso/widgets/gsod/gsod_project_widget_new.dart';
import 'package:opso/widgets/gsod/gsod_project_widget_old.dart';
import 'package:opso/widgets/year_button.dart';
import 'package:opso/programs_info_pages/gsod_info.dart';

class GoogleSeasonOfDocsScreen extends StatefulWidget {
  @override
  State<GoogleSeasonOfDocsScreen> createState() =>
      _GoogleSeasonOfDocsScreenState();
}

class _GoogleSeasonOfDocsScreenState extends State<GoogleSeasonOfDocsScreen> {
  List<String> selectedOrganizations = [];
  List<String> selectedProposals = ['All'];
  String currentProgram = "Google Season of Docs";
  bool isBookmarked = true;
  String currentPage = "/google_season_of_docs";
  List<GsodModalNew> gsod2023 = [];
  List<GsodModalNew> gsod2022 = [];
  List<GsodModalNew> gsod2021 = [];
  List<GsodModalOld> gsod2020 = [];
  List<GsodModalOld> gsod2019 = [];
  int selectedYear = 2023;

  List projectList = [];
  List allProjectList = [];
  Future<void>? getProjectFunction;

  Future<void> initializeProjectLists() async {
    String response =
        await rootBundle.loadString('assets/projects/gsod/gsod2023.json');
    var jsonList = await json.decode(response);
    for (var data in jsonList) {
      gsod2023.add(GsodModalNew.fromMap(data));
    }
    projectList = List.from(gsod2023);
    allProjectList = List.from(gsod2023);

    response =
        await rootBundle.loadString('assets/projects/gsod/gsod2022.json');
    jsonList = await json.decode(response);
    for (var data in jsonList) {
      gsod2022.add(GsodModalNew.fromMap(data));
    }

    response =
        await rootBundle.loadString('assets/projects/gsod/gsod2021.json');
    jsonList = await json.decode(response);
    for (var data in jsonList) {
      gsod2021.add(GsodModalNew.fromMap(data));
    }

    response =
        await rootBundle.loadString('assets/projects/gsod/gsod2020.json');
    jsonList = await json.decode(response);
    for (var data in jsonList) {
      gsod2020.add(GsodModalOld.fromMap(data));
    }

    response =
        await rootBundle.loadString('assets/projects/gsod/gsod2019.json');
    jsonList = await json.decode(response);
    for (var data in jsonList) {
      gsod2019.add(GsodModalOld.fromMap(data));
    }
  }

  @override
  void initState() {
    getProjectFunction = initializeProjectLists();
    _checkBookmarkStatus();
    super.initState();
  }

  Future<void> _checkBookmarkStatus() async {
    bool bookmarkStatus = await HandleBookmark.isBookmarked(currentProgram);
    setState(() {
      isBookmarked = bookmarkStatus;
    });
  }

  void search(String searchText) {
    if (searchText.isEmpty) {
      resetProjectsByLanguage();
      return;
    }
    if (selectedYear > 2020) {
      projectList = projectList
          .where(
            (element) =>
                element.organizationName
                    .toLowerCase()
                    .contains(searchText.toLowerCase()) ||
                element.budget
                    .toLowerCase()
                    .contains(searchText.toLowerCase()) ||
                element.acceptedProjectProposal
                    .toLowerCase()
                    .contains(searchText.toLowerCase()) ||
                element.caseStudy
                    .toLowerCase()
                    .contains(searchText.toLowerCase()) ||
                element.docsPage
                    .toLowerCase()
                    .contains(searchText.toLowerCase()),
          )
          .toList();
    } else {
      projectList = projectList
          .where(
            (element) =>
                element.organization
                    .toLowerCase()
                    .contains(searchText.toLowerCase()) ||
                element.technicalWriter
                    .toLowerCase()
                    .contains(searchText.toLowerCase()) ||
                element.mentor
                    .toLowerCase()
                    .contains(searchText.toLowerCase()) ||
                element.project
                    .toLowerCase()
                    .contains(searchText.toLowerCase()) ||
                element.originalProjectProposal
                    .toLowerCase()
                    .contains(searchText.toLowerCase()) ||
                element.report.toLowerCase().contains(searchText.toLowerCase()),
          )
          .toList();
    }

    setState(() {
      _resetValueIfNotValid();
    });
  }

  Future<void> _refresh() async {
    setState(() {
      initializeProjectLists();
      selectedOrganizations = ['All'];
      selectedProposals = ['All'];
      selectedYear = 2023;
      if (selectedYear > 2023)
        selectedYear = 2019; // Reset to the beginning if it exceeds 2023
    });
  }

  void resetProjectsByLanguage() {
    switch (selectedYear) {
      case 2019:
        projectList = gsod2019;
        allProjectList = gsod2019;
        break;
      case 2020:
        projectList = gsod2020;
        allProjectList = gsod2020;
        break;
      case 2021:
        projectList = gsod2021;
        allProjectList = gsod2021;
        break;
      case 2022:
        projectList = gsod2022;
        allProjectList = gsod2022;
        break;
      case 2023:
        projectList = gsod2023;
        allProjectList = gsod2023;
        break;
      case 2024:
        projectList = gsod2023;
        allProjectList = gsod2023;
        break;
    }
    filterProjects();
  }

  void filterProjects() {
    var filteredProjects = List.from(projectList);
    print("!@# $selectedOrganizations");

    // Filter by organizations
    if (!selectedOrganizations.contains('All')) {
      filteredProjects = filteredProjects.where((project) {
        return selectedOrganizations
            .every((org) => project.organizationName.contains(org));
      }).toList();
    } else {
      filteredProjects = gsod2023;
    }

    // Filter by proposals
    if (!selectedProposals.contains('All')) {
      filteredProjects = filteredProjects.where((project) {
        return selectedProposals.contains(project.acceptedProjectProposal);
      }).toList();
    }

    setState(() {
      projectList = filteredProjects;
      /*_resetValueIfNotValid();*/
    });
  }

  void _resetValueIfNotValid() {
    // Reset selectedOrganizations if they are not valid
    var validOrganizations =
        projectList.map((project) => project.organizationName).toSet();
    selectedOrganizations = selectedOrganizations
        .where((org) => validOrganizations.contains(org) || org == 'All')
        .toList();
    /* if (selectedOrganizations.isEmpty) {
     selectedOrganizations = ['All'];
   }*/
  }

  @override
  Widget build(BuildContext context) {
    bool isDarkMode = Theme.of(context).brightness == Brightness.dark;
    var height = MediaQuery.sizeOf(context).height;
    var width = MediaQuery.sizeOf(context).width;
    return RefreshIndicator(
      onRefresh: _refresh,
      child: Scaffold(
        appBar: AppBar(
           leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios),
         
          onPressed: () => Navigator.of(context).pop(),
        ),
        centerTitle: true,
          title: const Text('GSoD'), actions: <Widget>[
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
                  duration: const Duration(
                      seconds: 2), // Adjust the duration as needed
                ),
              );
              if (isBookmarked) {
                HandleBookmark.addBookmark(currentProgram, currentPage);
              } else {
                HandleBookmark.deleteBookmark(currentProgram);
              }
            },
          ),
          IconButton(
            icon: const Icon(Icons.info_outline),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const GSODInfo()),
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
                      const EdgeInsets.symmetric(horizontal: 46, vertical: 16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    mainAxisSize: MainAxisSize.min,
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
                      Container(
                        constraints: BoxConstraints(
                          maxHeight: height * 0.3,
                        ),
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
                            YearButton(
                              year: "2019",
                              isEnabled: selectedYear == 2019,
                              onTap: () {
                                setState(() {
                                  projectList = gsod2019;
                                  selectedYear = 2019;
                                  _resetValueIfNotValid();
                                });
                              },
                              backgroundColor: selectedYear == 2019
                                  ? Colors.white
                                  : const Color.fromRGBO(249, 171, 0, 1),
                            ),
                            YearButton(
                              year: "2020",
                              isEnabled: selectedYear == 2020,
                              onTap: () {
                                setState(() {
                                  projectList = gsod2020;
                                  selectedYear = 2020;
                                  _resetValueIfNotValid();
                                });
                              },
                              backgroundColor: selectedYear == 2020
                                  ? Colors.white
                                  : const Color.fromRGBO(249, 171, 0, 1),
                            ),
                            YearButton(
                              year: "2021",
                              isEnabled: selectedYear == 2021,
                              onTap: () {
                                setState(() {
                                  projectList = gsod2021;
                                  selectedYear = 2021;
                                  _resetValueIfNotValid();
                                });
                              },
                              backgroundColor: selectedYear == 2021
                                  ? Colors.white
                                  : const Color.fromRGBO(249, 171, 0, 1),
                            ),
                            YearButton(
                              year: "2022",
                              isEnabled: selectedYear == 2022,
                              onTap: () {
                                setState(() {
                                  projectList = gsod2022;
                                  selectedYear = 2022;
                                  _resetValueIfNotValid();
                                });
                              },
                              backgroundColor: selectedYear == 2022
                                  ? Colors.white
                                  : const Color.fromRGBO(249, 171, 0, 1),
                            ),
                            YearButton(
                              year: "2023",
                              isEnabled: selectedYear == 2023,
                              onTap: () {
                                setState(() {
                                  projectList = gsod2023;
                                  selectedYear = 2023;
                                  _resetValueIfNotValid();
                                });
                              },
                              backgroundColor: selectedYear == 2023
                                  ? Colors.white
                                  : const Color.fromRGBO(249, 171, 0, 1),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 20),
                      _buildMultiSelectField(
                        items: [
                          'All',
                          ...projectList
                              .map((project) => project.organizationName)
                              .toSet(),
                        ],
                        selectedValues: selectedOrganizations,
                        title: "Select Organizations",
                        buttonText: "Filter by Organization",
                        onConfirm: (results) {
                          setState(() {
                            selectedOrganizations =
                                results.isNotEmpty ? results : ['All'];
                            print(
                                "this is selected organization $selectedOrganizations");
                            filterProjects();
                          });
                        },
                      ),
                      const SizedBox(height: 20),
                      const SizedBox(height: 20),
                      projectList.isNotEmpty
                          ? ListView.builder(
                              shrinkWrap: true,
                              physics: NeverScrollableScrollPhysics(),
                              itemCount: projectList.length,
                              itemBuilder: (BuildContext context, int index) {
                                return Padding(
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 10),
                                  child: selectedYear <= 2020
                                      ? GsodProjectWidgetOld(
                                          index: index + 1,
                                          modal: projectList[index],
                                          height: height * 0.2,
                                          width: width,
                                        )
                                      : GsodProjectWidgetNew(
                                          index: index + 1,
                                          modal: projectList[index],
                                          height: height * 0.2,
                                          width: width,
                                        ),
                                );
                              },
                            )
                          : Center(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text('No projects available.'),
                                  SizedBox(height: 20),
                                  ElevatedButton(
                                    onPressed: () {
                                      // Call the refresh function
                                      _refresh();
                                    },
                                    child: Text('Refresh'),
                                  ),
                                ],
                              ),
                            ),
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
      title: Text(
        title,
        style: TextStyle(color: isDarkMode ? Colors.black : Colors.black),
      ),
      buttonText: Text(buttonText),
      onConfirm: onConfirm,
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey),
        borderRadius: BorderRadius.circular(10),
      ),
    );
  }
}
