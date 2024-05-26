import 'dart:convert';


import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:opso/modals/book_mark_model.dart';
import 'package:opso/modals/gsod/gsod_modal_new.dart';
import 'package:opso/modals/gsod/gsod_modal_old.dart';
import 'package:opso/widgets/gsod/gsod_project_widget_new.dart';
import 'package:opso/widgets/gsod/gsod_project_widget_old.dart';
import 'package:opso/widgets/year_button.dart';


class GoogleSeasonOfDocsScreen extends StatefulWidget {
  @override
  State<GoogleSeasonOfDocsScreen> createState() =>
      _GoogleSeasonOfDocsScreenState();
}


class _GoogleSeasonOfDocsScreenState extends State<GoogleSeasonOfDocsScreen> {
  String currentProgram = "Google Season of Docs";
  bool isBookmarked = true;
  String currentPage = "/google_season_of_docs";
  List<GsodModalNew> gsod2023 = [];
  List<GsodModalNew> gsod2022 = [];
  List<GsodModalNew> gsod2021 = [];
  List<GsodModalOld> gsod2020 = [];
  List<GsodModalOld> gsod2019 = [];
  bool flag = true;
  int selectedYear = 2023;


  List projectList = [];
  Future<void>? getProjectFunction;


  Future<void> initializeProjectLists() async {
    String response =
    await rootBundle.loadString('assets/projects/gsod/gsod2023.json');
    var jsonList = await json.decode(response);
    for (var data in jsonList) {
      gsod2023.add(GsodModalNew.fromMap(data));
    }
    print(gsod2023.length);
    projectList = List.from(gsod2023);
    response =
    await rootBundle.loadString('assets/projects/gsod/gsod2022.json');
    jsonList = await json.decode(response);


    for (var data in jsonList) {
      print(data["organization_name"]);
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
      switch (selectedYear) {
        case 2021:
          projectList = gsod2021;
          break;
        case 2022:
          projectList = gsod2022;
          break;
        case 2023:
          projectList = gsod2023;
          break;
        case 20202:
          projectList = gsod2020;
          break;
        case 2019:
          projectList = gsod2019;
          break;
      }
      setState(() {});
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


    setState(() {});
  }
  Future<void> _refresh() async {
    // Fetch data for the next year based on the currently selected year
    setState(() {
      initializeProjectLists();
      selectedYear = 2023;
      if (selectedYear > 2023) selectedYear = 2019; // Reset to the beginning if it exceeds 2023
    });
  }
  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.sizeOf(context).height;
    var width = MediaQuery.sizeOf(context).width;
    return RefreshIndicator(
      onRefresh: _refresh,
      child: Scaffold(
        appBar: AppBar(title: const Text('OpSo'), actions: <Widget>[
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
                  content:
                  Text(isBookmarked ? 'Bookmark added' : 'Bookmark removed'),
                  duration:
                  const Duration(seconds: 2), // Adjust the duration as needed
                ),
              );
              if (isBookmarked) {
                print("Adding");
                HandleBookmark.addBookmark(currentProgram, currentPage);
              } else {
                print("Deleting");
                HandleBookmark.deleteBookmark(currentProgram);
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
                return Padding(
                  padding:
                  const EdgeInsets.symmetric(horizontal: 46, vertical: 16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      TextFormField(
                        decoration: InputDecoration(
                          filled: true,
                          // fillColor: const Color(0xFFEEEEEE),
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
                          print("value is $value");
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
                              isEnabled: selectedYear == 2019 ? true : false,
                              onTap: () {
                                setState(() {
                                  projectList = gsod2019;
                                  selectedYear = 2019;
                                });
                              },
                              backgroundColor: selectedYear == 2019
                                  ? Colors.white
                                  : const Color.fromRGBO(249, 171, 0, 1),
                            ),
                            YearButton(
                              year: "2020",
                              isEnabled: selectedYear == 2020 ? true : false,
                              onTap: () {
                                setState(() {
                                  projectList = gsod2020;
                                  selectedYear = 2020;
                                });
                              },
                              backgroundColor: selectedYear == 2020
                                  ? Colors.white
                                  : const Color.fromRGBO(249, 171, 0, 1),
                            ),
                            YearButton(
                              year: "2021",
                              isEnabled: selectedYear == 2021 ? true : false,
                              onTap: () {
                                setState(() {
                                  projectList = gsod2021;
                                  selectedYear = 2021;
                                });
                              },
                              backgroundColor: selectedYear == 2021
                                  ? Colors.white
                                  : const Color.fromRGBO(249, 171, 0, 1),
                            ),
                            YearButton(
                              year: "2022",
                              isEnabled: selectedYear == 2022 ? true : false,
                              onTap: () {
                                setState(() {
                                  projectList = gsod2022;
                                  selectedYear = 2022;
                                });
                              },
                              backgroundColor: selectedYear == 2022
                                  ? Colors.white
                                  : const Color.fromRGBO(249, 171, 0, 1),
                            ),
                            YearButton(
                              year: "2023",
                              isEnabled: selectedYear == 2023 ? true : false,
                              onTap: () {
                                setState(() {
                                  projectList = gsod2023;
                                  selectedYear = 2023;
                                });
                              },
                              backgroundColor: selectedYear == 2023
                                  ? Colors.white
                                  : const Color.fromRGBO(249, 171, 0, 1),
                            ),
                          ],
                        ),
                      ),
                      // const SizedBox(height: 20),
                      // SizedBox(
                      //   height: 50,
                      //   child: ElevatedButton(
                      //     onPressed: () {},
                      //     style: ElevatedButton.styleFrom(
                      //       shape: const RoundedRectangleBorder(
                      //         borderRadius: BorderRadius.zero,
                      //       ),
                      //       backgroundColor: const Color.fromARGB(
                      //           255, 253, 214, 115), // Set button color
                      //       padding: const EdgeInsets.symmetric(
                      //           vertical: 10.0, horizontal: 20.0),
                      //     ),
                      //     child: const Text(
                      //       'View Projects',
                      //       style: TextStyle(color: Colors.white, fontSize: 18),
                      //     ),
                      //   ),
                      // ),
                      const SizedBox(
                        height: 20,
                      ),


                      Expanded(
                        // width: width,
                        child: ListView.builder(
                          itemCount: projectList.length,
                          itemBuilder: (BuildContext context, int index) {
                            return Padding(
                              padding: const EdgeInsets.symmetric(vertical: 10),
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
                        ),
                      ),
                    ],
                  ),
                );
              } else {
                return const Center(child: Text("Some error occured"));
              }
            }),
      ),
    );
  }
}

