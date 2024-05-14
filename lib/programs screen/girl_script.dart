import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:opso/modals/gssoc_project_modal.dart';
import 'package:opso/widgets/book_mark_screen.dart';

import 'package:opso/widgets/gssoc_project_widget.dart';
import 'package:opso/widgets/year_button.dart';

import '../widgets/SearchandFilterWidget.dart';

class GSSOCScreen extends StatefulWidget {
  const GSSOCScreen({super.key});

  @override
  State<GSSOCScreen> createState() => _GSSOCScreenState();
}

class _GSSOCScreenState extends State<GSSOCScreen> {

  List<GssocProjectModal> gssoc2024 = [];
  List<GssocProjectModal> gssoc2023 = [];
  bool flag = true;
  List<GssocProjectModal> gssoc2022 = [];
  List<GssocProjectModal> gssoc2021 = [];
  int selectedYear = 2024;

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
  }
  void searchTag(String searchTag){
    projectList = projectList
        .where(
            (element) =>
            element.techstack.contains(searchTag)
    )
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

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.sizeOf(context).height;
    var width = MediaQuery.sizeOf(context).width;
    List<String> languages = ['Js','Python','React','Angular','Bootstrap','Firebase','Node','MongoDb','Express','Next','CSS', 'HTML', 'JavaScript', 'Flutter','Dart'];
    return Scaffold(

      appBar: AppBar(
        title: const Text('OpSo'),
          actions: <Widget>[
            IconButton(
            icon: (flag)
                ? const Icon(Icons.bookmark_add)
                : const Icon(Icons.bookmark_added),
            onPressed: () {
              setState(() {
                flag = !flag;
                // Show a SnackBar to indicate whether the bookmark was added or removed
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(flag ? 'Bookmark removed' : 'Bookmark added'),
                    duration: const Duration(seconds: 2), // Adjust the duration as needed
                  ),
                );
              });
            },
            )
          ]
        ),

        body: FutureBuilder<void>(
          future: getProjectFunction,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const CircularProgressIndicator();
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
                        fillColor: const Color(0xFFEEEEEE),
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

                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        const Text('Filter by Language:',style: TextStyle(fontWeight: FontWeight.w400),),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              DropdownWidget(
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
                            ],
                          ),
                        )
                      ],
                    ),

                    Expanded(
                      // width: width,
                      child: ListView.builder(
                        itemCount: projectList.length,
                        itemBuilder: (BuildContext context, int index) {
                          return Padding(
                            padding: const EdgeInsets.symmetric(vertical: 10),
                            child: GssocProjectWidget(
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
    );
  }
}