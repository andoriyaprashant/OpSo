import 'dart:convert';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:opso/modals/book_mark_model.dart';
import 'package:opso/modals/linux_foundation_modal.dart';
import 'package:opso/programs_info_pages/linux_info.dart';
import 'package:opso/widgets/linux_foundation_widget.dart';

class LinuxFoundation extends StatefulWidget {
  const LinuxFoundation({super.key});

  @override
  State<LinuxFoundation> createState() => _LinuxFoundationState();
}

class _LinuxFoundationState extends State<LinuxFoundation> {
  bool isBookmarked = true;
  String currectPage = "/linux_foundation";
  String currentProject = "LinuxFoundation";
  List<LinuxFoundationModal> modals = [];
  List<LinuxFoundationModal> projectList = [];
  Future<void>? getProjectListFunction;

  Future<void> initializeProjectLists() async {
    String response = await rootBundle
        .loadString('assets/projects/linux_foundation/linux_foundation.json');

    var jsonList = await json.decode(response);
    for (var data in jsonList) {
      modals.add(LinuxFoundationModal.fromMap(data));
    }
    projectList = List.of(modals);
    // setState(() {});
  }

  @override
  void initState() {
    super.initState();
    getProjectListFunction = initializeProjectLists();
    _checkBookmarkStatus();
  }

  Future<void> _checkBookmarkStatus() async {
    bool bookmarkStatus = await HandleBookmark.isBookmarked(currentProject);
    setState(() {
      isBookmarked = bookmarkStatus;
    });
  }

  void search(String searchText) {
    if (searchText.isEmpty) {
      setState(() {
        projectList = modals;
      });
      return;
    }
    projectList = projectList
        .where((LinuxFoundationModal element) =>
            element.name.toLowerCase().contains(searchText.toLowerCase()))
        .toList();
    setState(() {});
  }

  Future<void> _refresh() async {
    await initializeProjectLists();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    // var height = MediaQuery.sizeOf(context).height;
    // var width = MediaQuery.sizeOf(context).width;
    ScreenUtil.init(context, designSize: Size(360, 690));
    return RefreshIndicator(
      onRefresh: _refresh,
      child: Scaffold(
        appBar: AppBar(
           leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios),
         
          onPressed: () => Navigator.of(context).pop(),
        ),
        centerTitle: true,
          title: const Text('Linux Foundation'), actions: <Widget>[
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
                MaterialPageRoute(builder: (context) => const LINUXInfo()),
              );
            },
          ),
        ]),
        body: FutureBuilder<void>(
          future: getProjectListFunction,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            } else if (snapshot.connectionState == ConnectionState.done) {
              return Padding(
                padding: EdgeInsets.symmetric(
                    horizontal: ScreenUtil().setWidth(46),
                    vertical: ScreenUtil().setHeight(16)),
                child: Column(
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
                        contentPadding: EdgeInsets.symmetric(
                            vertical: ScreenUtil().setHeight(12),
                            horizontal: ScreenUtil().setWidth(40)),
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
                    SizedBox(height: ScreenUtil().setHeight(20)),
                    Expanded(
                      // width: width,
                      child: ListView.builder(
                        itemCount: projectList.length,
                        itemBuilder: (BuildContext context, int index) {
                          return Padding(
                            padding: EdgeInsets.symmetric(
                                vertical: ScreenUtil().setHeight(10)),
                            child: LinuxFoundationWidget(
                              // index: index + 1,
                              modal: projectList[index],
                              height: ScreenUtil().screenHeight * 0.2,
                              width: ScreenUtil().screenWidth,
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                ),
              );
            }
            return Container();
          },
        ),
      ),
    );
  }
}
