import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:opso/modals/book_mark_model.dart';
import 'package:opso/modals/rsoc_project_modal.dart';
import 'package:opso/programs_info_pages/rsoc_info.dart';
import 'package:opso/widgets/rsoc_project_widget.dart';

class RsocPage extends StatefulWidget {
  const RsocPage({super.key});

  @override
  _RsocPageState createState() => _RsocPageState();
}

class _RsocPageState extends State<RsocPage> {
  List<RsocProjectModal> projectList = [];
  String currectPage = "/rsoc";
  String currentProject = "RSoC";
  bool isBookmarked = true;
  late Future<void> getProjectFunction;

  Future<void> initializeProjectLists() async {
    var response =
        await rootBundle.loadString('assets/projects/redox/redox.json');
    var jsonList = await json.decode(response);
    for (var data in jsonList) {
      projectList.add(RsocProjectModal.fromJson(data));
    }
    print(projectList);
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
      setState(() {});
      return;
    }
    searchText = searchText.toLowerCase();
    projectList = projectList
        .where((element) =>
            element.name.toLowerCase().contains(searchText) ||
            element.contributor.toLowerCase().contains(searchText))
        .toList();
    setState(() {});
  }

  Future<void> _refresh() async {
    projectList.clear();
    await initializeProjectLists();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: _refresh,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Redox Summer of Code'),
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
                  MaterialPageRoute(builder: (context) => const RsocInfo()),
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
                        height: MediaQuery.of(context).size.height * 0.8,
                        child: ListView.builder(
                          itemCount: projectList.length,
                          itemBuilder: (BuildContext context, int index) {
                            return Padding(
                              padding: const EdgeInsets.symmetric(vertical: 10),
                              child: RsocProjectWidget(
                                modal: projectList[index],
                                height: ScreenUtil().screenHeight * 0.3,
                                width: ScreenUtil().screenWidth,
                                index: index,
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
