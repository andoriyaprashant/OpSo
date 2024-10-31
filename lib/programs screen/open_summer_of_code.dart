import 'dart:convert';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:opso/modals/osoc_modal.dart';
import 'package:opso/widgets/osoc_widget.dart';
import 'package:opso/widgets/year_button.dart';
import 'package:opso/programs_info_pages/osoc_info.dart';
import '../modals/book_mark_model.dart';

class OpenSummerOfCode extends StatefulWidget {
  const OpenSummerOfCode({super.key});

  @override
  State<OpenSummerOfCode> createState() => _OpenSummerOfCodeState();
}

class _OpenSummerOfCodeState extends State<OpenSummerOfCode> {
  List<OsocModal> osoc2022 = [];
  List<OsocModal> osoc2021 = [];
  String currectPage = "/open_summer_of_code";
  String currentProject = "Open Summer of Code";
  bool isBookmarked = true;
  int selectedYear = 2022;

  List<OsocModal> projectList = [];
  Future<void>? getProjectFunction;

  Future<void> initializeProjectLists() async {
    var response =
        await rootBundle.loadString('assets/projects/osoc/osoc2022.json');
    var jsonList = await json.decode(response);
    for (var data in jsonList) {
      osoc2022.add(OsocModal.fromMap(data));
    }
    projectList = osoc2022;
    print(projectList);
    response =
        await rootBundle.loadString('assets/projects/osoc/osoc2021.json');
    jsonList = await json.decode(response);
    for (var data in jsonList) {
      osoc2021.add(OsocModal.fromMap(data));
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
        .where((OsocModal element) => element.name.contains(searchTag))
        .toList();
    setState(() {});
  }

  void search(String searchText) {
    if (searchText.isEmpty) {
      switch (selectedYear) {
        case 2021:
          projectList = osoc2021;
          break;
        case 2022:
          projectList = osoc2022;
          break;
      }
      setState(() {});
      return;
    }
    searchText = searchText.toLowerCase();
    projectList = projectList
        .where((OsocModal element) =>
            element.name.toLowerCase().contains(searchText) ||
            element.description.toLowerCase().contains(searchText))
        .toList();
    setState(() {});
  }

  // List<String> languages = [
  //   'Rust miniscript',
  //   'Core Lightning',
  //   'LDK',
  //   'Bitcoin Core',
  //   'Alby',
  //   'Eye of Satoshi',
  //   'Ledger Bitcoin App',
  //   'Galoy',
  //   'Fedimint',
  //   'VLS',
  //   'StratumV2',
  //   'bcoin',
  //   'LND',
  //   'Eclair'
  // ];

  Future<void> _refresh() async {
    osoc2021.clear();
    osoc2022.clear();
    await initializeProjectLists();

    selectedYear = 2022;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.sizeOf(context).height;
    var width = MediaQuery.sizeOf(context).width;
    const ScreenUtilInit(
      designSize: Size(360, 690),
    );
    return RefreshIndicator(
      onRefresh: _refresh,
      child: Scaffold(
        appBar: AppBar(
            leading: IconButton(
              icon: const Icon(Icons.arrow_back_ios),
              onPressed: () => Navigator.of(context).pop(),
            ),
            centerTitle: true,
            title: const Text('Open Summer of Code'),
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
              ),
              IconButton(
                icon: const Icon(Icons.info_outline),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const OSOCInfo()),
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
                  padding: const EdgeInsets.symmetric(horizontal: 46, vertical: 6),
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
                          contentPadding: EdgeInsets.symmetric(
                              vertical: ScreenUtil().setHeight(12),
                              horizontal: ScreenUtil().setWidth(20)),
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
                      LayoutBuilder(
                        builder: (context, constraints) {
                          return Wrap(
                            spacing: 15,
                            runSpacing: 15,
                            alignment: WrapAlignment.spaceBetween,
                            children: [
                              YearButton(
                                year: "2021",
                                isEnabled: selectedYear == 2021 ? true : false,
                                onTap: () {
                                  setState(() {
                                    projectList = osoc2021;
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
                                    projectList = osoc2022;
                                    selectedYear = 2022;
                                  });
                                },
                                backgroundColor: selectedYear == 2022
                                    ? Colors.white
                                    : const Color.fromRGBO(255, 183, 77, 1),
                      
                              ),
                            ],
                          );
                        },
                      ),
                      SizedBox(height: ScreenUtil().setHeight(20)),                     
                      ListView.builder(
                        itemCount: projectList.length,
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemBuilder: (BuildContext context, int index) {
                          return Padding(
                            padding: const EdgeInsets.symmetric(vertical: 10),
                            child: OsocWidget(
                              modal: projectList[index],
                              height: ScreenUtil().screenHeight * 0.2,
                              width: ScreenUtil().screenWidth,
                            ),
                          );
                        },
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
