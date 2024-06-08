import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:opso/modals/book_mark_model.dart';
import 'package:opso/modals/gssoc_project_modal.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:opso/widgets/gssoc_project_widget.dart';
import 'package:opso/widgets/year_button.dart';

import '../widgets/SearchandFilterWidget.dart';

class GSSOCScreen extends StatefulWidget {
  const GSSOCScreen({super.key});

  @override
  State<GSSOCScreen> createState() => _GSSOCScreenState();
}

class _GSSOCScreenState extends State<GSSOCScreen> {
  String currectPage = "/girl_script_summer_of_code";
  String currentProject = "Girl Script Summer of Code";
  List<GssocProjectModal> gssoc2024 = [];
  List<GssocProjectModal> gssoc2023 = [];
  bool isBookmarked = true;
  List<GssocProjectModal> gssoc2022 = [];
  List<GssocProjectModal> gssoc2021 = [];
  int selectedYear = 2024;
  String selectedOrg = "All";
  List<GssocProjectModal> projectList = [];
  Future<void>? getProjectFunction;

  Future<void> initializeProjectLists() async {
    String response =
        await rootBundle.loadString('assets/projects/gssoc/gssoc2024.json');
    var jsonList = await json.decode(response);
    for (var data in jsonList) {
      gssoc2024.add(GssocProjectModal.getDataFromJson(data));
    }
    projectList = List.from(gssoc2024);
    response =
        await rootBundle.loadString('assets/projects/gssoc/gssoc2023.json');
    jsonList = await json.decode(response);
    for (var data in jsonList) {
      gssoc2023.add(GssocProjectModal.getDataFromJson(data));
    }
    response =
        await rootBundle.loadString('assets/projects/gssoc/gssoc2022.json');
    jsonList = await json.decode(response);
    for (var data in jsonList) {
      gssoc2022.add(GssocProjectModal.getDataFromJson(data));
    }
    response =
        await rootBundle.loadString('assets/projects/gssoc/gssoc2021.json');
    jsonList = await json.decode(response);
    for (var data in jsonList) {
      gssoc2021.add(GssocProjectModal.getDataFromJson(data));
    }
  }

  @override
  void initState() {
    getProjectFunction = initializeProjectLists();
    super.initState();
    _checkBookmarkStatus();
  }

  Future<void> _checkBookmarkStatus() async {
    bool bookmarkStatus = await HandleBookmark.isBookmarked(currentProject);
    setState(() {
      isBookmarked = bookmarkStatus;
    });
  }

  void searchTag(String searchTag) {
    projectList = projectList
        .where((element) => element.techstack.contains(searchTag))
        .toList();
    setState(() {});
  }

  void search(String searchText) {
    if (searchText.isEmpty) {
      switch (selectedYear) {
        case 2021:
          projectList = gssoc2021;
          break;
        case 2022:
          projectList = gssoc2022;
          break;
        case 2023:
          projectList = gssoc2023;
          break;
        case 2024:
          projectList = gssoc2024;
          break;
      }
      setState(() {});
      return;
    }
    projectList = projectList
        .where(
          (element) =>
              element.name.toLowerCase().contains(searchText.toLowerCase()) ||
              element.techstack.contains(searchText) ||
              element.hostedBy.toLowerCase().contains(searchText.toLowerCase()),
        )
        .toList();
    setState(() {});
  }

  Future<void> _refresh() async {
    setState(() {
      initializeProjectLists();
      selectedYear = 2024;
    });
  }

  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context);
    // var height = MediaQuery.sizeOf(context).height;
    // var width = MediaQuery.sizeOf(context).width;
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
    return RefreshIndicator(
        onRefresh: _refresh,
        child: Scaffold(
          appBar: AppBar(title: const Text('GSSoC'), actions: <Widget>[
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
                  print("Adding");
                  HandleBookmark.addBookmark(currentProject, currectPage);
                } else {
                  print("Deleting");
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
                  return (ScreenUtil().orientation == Orientation.portrait)
                      ? Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: ScreenUtil().setWidth(46),
                              vertical: ScreenUtil().setHeight(16)),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              searchbar(),
                              const SizedBox(height: 20),
                              yearFilterWidget(),
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
                              SizedBox(
                                height: ScreenUtil().setHeight(20),
                              ),

                              languageFilterWidget(languages),

                              projectsListView(),
                            ],
                          ),
                        )
                      : Padding(
                          padding: const EdgeInsets.symmetric(
                            vertical: 8.0,
                            horizontal: 16.0,
                          ),
                          child: Row(
                            children: [
                              Expanded(
                                child: SingleChildScrollView(
                                  child: Column(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      SizedBox(
                                        width: ScreenUtil().screenWidth * 0.4,
                                        child: searchbar(),
                                      ),
                                      const SizedBox(height: 20),
                                      yearFilterWidget(),
                                      languageFilterWidget(languages),
                                    ],
                                  ),
                                ),
                              ),
                              const SizedBox(width: 20),
                              projectsListView(),
                            ],
                          ),
                        );
                } else {
                  return const Center(child: Text("Some error occured"));
                }
              }),
        ));
  }

  Row languageFilterWidget(List<String> languages) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Text(
          'Filter by Language:',
          style: TextStyle(
              fontWeight: FontWeight.w400,
              fontSize: ScreenUtil().setSp(
                  (ScreenUtil().orientation == Orientation.portrait) ? 14 : 8)),
        ),
        Padding(
          padding: EdgeInsets.all(ScreenUtil().setHeight(8)),
          child: DropdownWidget(
            items: languages,
            hintText: 'Language',
            onChanged: (newValue) {
              setState(() {
                switch (selectedYear) {
                  case 2021:
                    projectList = gssoc2021;
                    break;
                  case 2022:
                    projectList = gssoc2022;
                    break;
                  case 2023:
                    projectList = gssoc2023;
                    break;
                  case 2024:
                    projectList = gssoc2024;
                    break;
                }
                searchTag(newValue);
              });
              // Perform filtering based on selectedLanguage
            },
          ),
        )
      ],
    );
  }

  SizedBox yearFilterWidget() {
    return SizedBox(
      height: ScreenUtil().screenHeight *
          ((ScreenUtil().orientation == Orientation.portrait) ? 0.2 : 0.4),
      width: ScreenUtil().screenWidth * 0.4,
      child: GridView(
        physics: const NeverScrollableScrollPhysics(),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 1.5 / 0.6,
          crossAxisSpacing: 15,
          mainAxisSpacing: 15,
        ),
        children: [
          YearButton(
            year: "2021",
            isEnabled: selectedYear == 2021 ? true : false,
            onTap: () {
              setState(() {
                projectList = gssoc2021;
                selectedYear = 2021;
              });
            },
            backgroundColor: selectedYear == 2021
                ? Colors.white
                : const Color.fromRGBO(255, 183, 77, 1),
          ),
          YearButton(
            year: "2022",
            isEnabled: selectedYear == 2022 ? true : false,
            onTap: () {
              setState(() {
                projectList = gssoc2022;
                selectedYear = 2022;
              });
            },
            backgroundColor: selectedYear == 2022
                ? Colors.white
                : const Color.fromRGBO(255, 183, 77, 1),
          ),
          YearButton(
            year: "2023",
            isEnabled: selectedYear == 2023 ? true : false,
            onTap: () {
              setState(() {
                projectList = gssoc2023;
                selectedYear = 2023;
              });
            },
            backgroundColor: selectedYear == 2023
                ? Colors.white
                : const Color.fromRGBO(255, 183, 77, 1),
          ),
          YearButton(
            isEnabled: selectedYear == 2024 ? true : false,
            year: "2024",
            onTap: () {
              setState(() {
                projectList = gssoc2024;
                selectedYear = 2024;
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

  TextFormField searchbar() {
    return TextFormField(
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
        contentPadding: EdgeInsets.symmetric(
            vertical: ScreenUtil().setHeight(12),
            horizontal: ScreenUtil().setWidth(20)),
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
    );
  }

  Expanded projectsListView() {
    return Expanded(
      // width: width,
      child: ListView.builder(
        itemCount: projectList.length,
        itemBuilder: (BuildContext context, int index) {
          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 10),
            child: GssocProjectWidget(
              index: index + 1,
              modal: projectList[index],
              height: ScreenUtil().screenHeight * 0.2,
              width: ScreenUtil().screenWidth,
            ),
          );
        },
      ),
    );
  }
}
