import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:opso/modals/book_mark_model.dart';
import 'package:opso/modals/fossasia_project_modal.dart';
import 'package:opso/programs_info_pages/fossasia_info.dart';
import 'package:opso/widgets/fossaisa_project_widget.dart';
import 'package:opso/widgets/year_button.dart';

class FOSSASIA extends StatefulWidget {
  const FOSSASIA({super.key});

  @override
  _FOSSASIAState createState() => _FOSSASIAState();
}

class _FOSSASIAState extends State<FOSSASIA> {
  List<FOSSASIAProjectModel> fossasia2020 = [];
  List<FOSSASIAProjectModel> fossasia2019 = [];
  List<FOSSASIAProjectModel> fossasia2018 = [];
  List<FOSSASIAProjectModel> fossasia2017 = [];
  List<FOSSASIAProjectModel> fossasia2016 = [];
  bool isBookmarked = true;
  String currentPage = "/fossasia";
  String currentProject = "FOSSASIA Codeheat";
  int selectedYear = 2020;

  List<FOSSASIAProjectModel> projectList = [];
  late Future<void> getProjectFunction;

  Future<void> initializeProjectLists() async {
    var response = await rootBundle
        .loadString('assets/projects/fossasia/fossasia2020.json');
    var jsonList = await json.decode(response);
    for (var data in jsonList) {
      fossasia2020.add(FOSSASIAProjectModel.fromJson(data));
    }
    projectList = fossasia2020;

    response = await rootBundle
        .loadString('assets/projects/fossasia/fossasia2019.json');
    jsonList = await json.decode(response);
    for (var data in jsonList) {
      fossasia2019.add(FOSSASIAProjectModel.fromJson(data));
    }

    response = await rootBundle
        .loadString('assets/projects/fossasia/fossasia2018.json');
    jsonList = await json.decode(response);
    for (var data in jsonList) {
      fossasia2018.add(FOSSASIAProjectModel.fromJson(data));
    }

    response = await rootBundle
        .loadString('assets/projects/fossasia/fossasia2017.json');
    jsonList = await json.decode(response);
    for (var data in jsonList) {
      fossasia2017.add(FOSSASIAProjectModel.fromJson(data));
    }

    response = await rootBundle
        .loadString('assets/projects/fossasia/fossasia2016.json');
    jsonList = await json.decode(response);
    for (var data in jsonList) {
      fossasia2016.add(FOSSASIAProjectModel.fromJson(data));
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
        case 2020:
          projectList = fossasia2020;
          break;
        case 2019:
          projectList = fossasia2019;
          break;
        case 2018:
          projectList = fossasia2018;
          break;
        case 2017:
          projectList = fossasia2017;
          break;
        case 2016:
          projectList = fossasia2016;
          break;
      }
      setState(() {});
      return;
    }
    searchText = searchText.toLowerCase();
    projectList = projectList
        .where((element) =>
            element.name.toLowerCase().contains(searchText) ||
            element.description.toLowerCase().contains(searchText))
        .toList();
    setState(() {});
  }

  Future<void> _refresh() async {
    fossasia2020.clear();
    fossasia2019.clear();
    fossasia2018.clear();
    fossasia2017.clear();
    fossasia2016.clear();
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
          title: const Text('FOSSASIA Codeheat'),
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
                  MaterialPageRoute(builder: (context) => const FossasiaInfo()),
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
                            borderSide:
                                const BorderSide(color: Color(0xFFEEEEEE)),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide:
                                const BorderSide(color: Color(0xFFEEEEEE)),
                          ),
                          disabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide:
                                const BorderSide(color: Color(0xFFEEEEEE)),
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide:
                                const BorderSide(color: Color(0xFFEEEEEE)),
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
                        height: MediaQuery.of(context).size.height * 0.25,
                        child: GridView(
                          physics: const NeverScrollableScrollPhysics(),
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
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
                                  projectList = fossasia2020;
                                  selectedYear = 2020;
                                });
                              },
                              backgroundColor: selectedYear == 2020
                                  ? Colors.white
                                  : const Color.fromRGBO(255, 183, 77, 1),
                            ),
                            YearButton(
                              year: "2019",
                              isEnabled: selectedYear == 2019,
                              onTap: () {
                                setState(() {
                                  projectList = fossasia2019;
                                  selectedYear = 2019;
                                });
                              },
                              backgroundColor: selectedYear == 2019
                                  ? Colors.white
                                  : const Color.fromRGBO(255, 183, 77, 1),
                            ),
                            YearButton(
                              year: "2018",
                              isEnabled: selectedYear == 2018,
                              onTap: () {
                                setState(() {
                                  projectList = fossasia2018;
                                  selectedYear = 2018;
                                });
                              },
                              backgroundColor: selectedYear == 2018
                                  ? Colors.white
                                  : const Color.fromRGBO(255, 183, 77, 1),
                            ),
                            YearButton(
                              year: "2017",
                              isEnabled: selectedYear == 2017,
                              onTap: () {
                                setState(() {
                                  projectList = fossasia2017;
                                  selectedYear = 2017;
                                });
                              },
                              backgroundColor: selectedYear == 2017
                                  ? Colors.white
                                  : const Color.fromRGBO(255, 183, 77, 1),
                            ),
                            YearButton(
                              year: "2016",
                              isEnabled: selectedYear == 2016,
                              onTap: () {
                                setState(() {
                                  projectList = fossasia2016;
                                  selectedYear = 2016;
                                });
                              },
                              backgroundColor: selectedYear == 2016
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
                              child: FOSSASIAProjectWidget(
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
