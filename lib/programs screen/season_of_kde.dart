import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:opso/modals/book_mark_model.dart';
import 'package:opso/modals/sokde_project_modal.dart';
import 'package:opso/programs_info_pages/sokde_info.dart';
import 'package:opso/widgets/sokde_project_widget.dart';
import 'package:opso/widgets/small_year_button.dart';

class SeasonOfKDE extends StatefulWidget {
  const SeasonOfKDE({super.key});

  @override
  _SeasonOfKDEState createState() => _SeasonOfKDEState();
}

class _SeasonOfKDEState extends State<SeasonOfKDE> {
  List<SokdeProjectModal> sokde2024 = [];
  List<SokdeProjectModal> sokde2023 = [];
  List<SokdeProjectModal> sokde2022 = [];
  String currectPage = "/season_of_kde";
  String currentProject = "Season of KDE";
  bool isBookmarked = true;
  int selectedYear = 2024;

  List<SokdeProjectModal> projectList = [];
  late Future<void> getProjectFunction;

  Future<void> initializeProjectLists() async {
    var response =
        await rootBundle.loadString('assets/projects/sokde/sokde2024.json');
    var jsonList = await json.decode(response);
    for (var data in jsonList) {
      sokde2024.add(SokdeProjectModal.fromJson(data));
    }
    projectList = sokde2024;
    print(projectList);
    response =
        await rootBundle.loadString('assets/projects/sokde/sokde2023.json');
    jsonList = await json.decode(response);
    for (var data in jsonList) {
      sokde2023.add(SokdeProjectModal.fromJson(data));
    }
    response =
        await rootBundle.loadString('assets/projects/sokde/sokde2022.json');
    jsonList = await json.decode(response);
    for (var data in jsonList) {
      sokde2022.add(SokdeProjectModal.fromJson(data));
    }
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

  void searchTag(String searchTag) {
    projectList = projectList
        .where((element) => element.name.toLowerCase().contains(searchTag))
        .toList();
    setState(() {});
  }

  void search(String searchText) {
    if (searchText.isEmpty) {
      switch (selectedYear) {
        case 2024:
          projectList = sokde2024;
          break;
        case 2023:
          projectList = sokde2023;
          break;
        case 2022:
          projectList = sokde2022;
          break;
      }
      setState(() {});
      return;
    }
    searchText = searchText.toLowerCase();
    projectList = projectList
        .where((element) =>
            element.name.toLowerCase().contains(searchText) ||
            element.mentors.contains(searchText))
        .toList();
    setState(() {});
  }

  Future<void> _refresh() async {
    sokde2023.clear();
    sokde2024.clear();
    sokde2022.clear();
    await initializeProjectLists();

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: _refresh,
      child: Scaffold(
        appBar: AppBar(
           leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios),
         
          onPressed: () => Navigator.of(context).pop(),
        ),
        centerTitle: true,
          title: const Text('Season of KDE'),
          actions: <Widget>[
            IconButton(
              icon: Icon(
                isBookmarked
                    ? Icons.bookmark_add_rounded
                    : Icons.bookmark_add_outlined,
              ),
              onPressed: () {
                setState(() {
                  isBookmarked = !isBookmarked;
                });
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(
                      isBookmarked ? 'Bookmark added' : 'Bookmark removed',
                    ),
                    duration: const Duration(seconds: 2),
                  ),
                );
                if (isBookmarked) {
                  HandleBookmark.addBookmark(currentProject, currectPage);
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
                  MaterialPageRoute(builder: (context) => const SOKDEInfo()),
                );
              },
            ),
          ],
        ),
        body: FutureBuilder<void>(
          future: getProjectFunction,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              return Center(child: Text("Error: ${snapshot.error}"));
            } else if (snapshot.connectionState == ConnectionState.done) {
              return Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: ScreenUtil().setWidth(46),
                  vertical: ScreenUtil().setHeight(16),
                ),
                child: SingleChildScrollView(
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
                          contentPadding: EdgeInsets.symmetric(
                            vertical: ScreenUtil().setHeight(12),
                            horizontal: ScreenUtil().setWidth(20),
                          ),
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
                      SizedBox(height: ScreenUtil().setHeight(20)),
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.1,
                        child: GridView(
                          physics: const NeverScrollableScrollPhysics(),
                          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 3,
                            childAspectRatio: 1.3,
                            crossAxisSpacing: 15,
                            mainAxisSpacing: 15,
                          ),
                          children: [
                            YearButton(
                              year: "2024",
                              isEnabled: selectedYear == 2024,
                              onTap: () {
                                setState(() {
                                  projectList = sokde2024;
                                  selectedYear = 2024;
                                });
                              },
                              backgroundColor: selectedYear == 2024
                                  ? Colors.white
                                  : const Color.fromRGBO(255, 183, 77, 1),
                            ),
                            YearButton(
                              year: "2023",
                              isEnabled: selectedYear == 2023,
                              onTap: () {
                                setState(() {
                                  projectList = sokde2023;
                                  selectedYear = 2023;
                                });
                              },
                              backgroundColor: selectedYear == 2023
                                  ? Colors.white
                                  : const Color.fromRGBO(255, 183, 77, 1),
                            ),
                            YearButton(
                              year: "2022",
                              isEnabled: selectedYear == 2022,
                              onTap: () {
                                setState(() {
                                  projectList = sokde2022;
                                  selectedYear = 2022;
                                });
                              },
                              backgroundColor: selectedYear == 2022
                                  ? Colors.white
                                  : const Color.fromRGBO(255, 183, 77, 1),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: ScreenUtil().setHeight(20)),
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.6,
                        child: ListView.builder(
                          itemCount: projectList.length,
                          itemBuilder: (BuildContext context, int index) {
                            return Padding(
                              padding: const EdgeInsets.symmetric(vertical: 10),
                              child: SokdeProjectWidget(
                                modal: projectList[index],
                                height: ScreenUtil().screenHeight * 0.2,
                                width: ScreenUtil().screenWidth,
                                index: index+1,
                              ),
                            );
                          },
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
}