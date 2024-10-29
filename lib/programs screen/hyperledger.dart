import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:opso/modals/book_mark_model.dart';
import 'package:opso/modals/hyperledger_modal.dart';
import 'package:opso/programs_info_pages/hyperledger_info.dart';
import 'package:opso/widgets/hyperledger_widget.dart';
import 'package:opso/widgets/year_button.dart';

class Hyperledger extends StatefulWidget {
  const Hyperledger({super.key});

  @override
  _HyperledgerState createState() => _HyperledgerState();
}

class _HyperledgerState extends State<Hyperledger> {
  List<HyperledgerProjectModal> hyperledger2024 = [];
  List<HyperledgerProjectModal> hyperledger2023 = [];
  List<HyperledgerProjectModal> hyperledger2022 = [];
  List<HyperledgerProjectModal> hyperledger2021 = [];
  String currectPage = "/hyperledger";
  String currentProject = "Hyperledger";
  bool isBookmarked = true;
  int selectedYear = 2024;

  List<HyperledgerProjectModal> projectList = [];
  late Future<void> getProjectFunction;

  Future<void> initializeProjectLists() async {
    var response = await rootBundle
        .loadString('assets/projects/hyperledger/hyperledger2024.json');
    var jsonList = await json.decode(response);
    for (var data in jsonList) {
      hyperledger2024.add(HyperledgerProjectModal.fromJson(data));
    }
    projectList = hyperledger2024;
    print(projectList);
    response = await rootBundle
        .loadString('assets/projects/hyperledger/hyperledger2023.json');
    jsonList = await json.decode(response);
    for (var data in jsonList) {
      hyperledger2023.add(HyperledgerProjectModal.fromJson(data));
    }
    response = await rootBundle
        .loadString('assets/projects/hyperledger/hyperledger2022.json');
    jsonList = await json.decode(response);
    for (var data in jsonList) {
      hyperledger2022.add(HyperledgerProjectModal.fromJson(data));
    }
    response = await rootBundle
        .loadString('assets/projects/hyperledger/hyperledger2021.json');
    jsonList = await json.decode(response);
    for (var data in jsonList) {
      hyperledger2021.add(HyperledgerProjectModal.fromJson(data));
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
          projectList = hyperledger2024;
          break;
        case 2023:
          projectList = hyperledger2023;
          break;
        case 2022:
          projectList = hyperledger2022;
          break;
        case 2021:
          projectList = hyperledger2021;
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
    hyperledger2023.clear();
    hyperledger2024.clear();
    hyperledger2022.clear();
    hyperledger2021.clear();
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
          title: const Text('Hyperledger'),
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
                  MaterialPageRoute(
                      builder: (context) => const HYPERLEDGERInfo()),
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
              return SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 46, vertical: 16),
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
                      Container(
                          constraints: BoxConstraints(
                            maxHeight: MediaQuery.sizeOf(context).height * 0.2,
                          ),
                          width: MediaQuery.sizeOf(context).width,
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
                                year: "2024",
                                isEnabled: selectedYear == 2024,
                                onTap: () {
                                  setState(() {
                                    projectList = hyperledger2024;
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
                                    projectList = hyperledger2023;
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
                                    projectList = hyperledger2022;
                                    selectedYear = 2022;
                                  });
                                },
                                backgroundColor: selectedYear == 2022
                                    ? Colors.white
                                    : const Color.fromRGBO(255, 183, 77, 1),
                              ),
                              YearButton(
                                year: "2021",
                                isEnabled: selectedYear == 2021,
                                onTap: () {
                                  setState(() {
                                    projectList = hyperledger2021;
                                    selectedYear = 2021;
                                  });
                                },
                                backgroundColor: selectedYear == 2021
                                    ? Colors.white
                                    : const Color.fromRGBO(255, 183, 77, 1),
                              )
                            ],
                          )),
                      ListView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: projectList.length,
                        itemBuilder: (BuildContext context, int index) {
                          return Padding(
                            padding: const EdgeInsets.symmetric(vertical: 10),
                            child: HyperledgerProjectWidget(
                              modal: projectList[index],
                              height: ScreenUtil().screenHeight * 0.2,
                              width: ScreenUtil().screenWidth,
                              index: index + 1,
                            ),
                          );
                        },
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