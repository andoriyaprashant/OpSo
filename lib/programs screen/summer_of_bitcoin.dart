import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:opso/modals/sob_project_modal.dart';
import 'package:opso/widgets/sob_project_widget.dart';
import 'package:opso/widgets/year_button.dart';

class SummerOfBitcoin extends StatefulWidget {
  const SummerOfBitcoin({super.key});

  @override
  State<SummerOfBitcoin> createState() => _SummerOfBitcoinState();
}

class _SummerOfBitcoinState extends State<SummerOfBitcoin> {
  List<SobProjectModal> sob2023 = [];
  List<SobProjectModal> sob2022 = [];
  List<SobProjectModal> sob2021 = [];
  int selectedYear = 2023;

  List<SobProjectModal> projectList = [];
  Future<void>? getProjectFunction;

  Future<void> initializeProjectLists() async {
    String response =
        await rootBundle.loadString('assets/projects/sob/sob2023.json');
    var jsonList = await json.decode(response);
    for (var data in jsonList) {
      sob2023.add(SobProjectModal.fromMap(data));
    }
    projectList = sob2023;

    response = await rootBundle.loadString('assets/projects/sob/sob2022.json');
    jsonList = await json.decode(response);
    for (var data in jsonList) {
      sob2022.add(SobProjectModal.fromMap(data));
    }
    response = await rootBundle.loadString('assets/projects/sob/sob2021.json');
    jsonList = await json.decode(response);
    for (var data in jsonList) {
      sob2021.add(SobProjectModal.fromMap(data));
    }
  }

  @override
  void initState() {
    getProjectFunction = initializeProjectLists();
    super.initState();
  }

  void search(String searchText) {
    if (searchText.isEmpty) {
      switch (selectedYear) {
        case 2021:
          projectList = sob2021;
          break;
        case 2022:
          projectList = sob2022;
          break;
        case 2023:
          projectList = sob2023;
          break;
      }
      setState(() {});
      return;
    }
    searchText = searchText.toLowerCase();
    projectList = projectList
        .where((SobProjectModal element) =>
            element.name.toLowerCase().contains(searchText) ||
            element.mentor.toLowerCase().contains(searchText) ||
            element.organization.toLowerCase().contains(searchText) ||
            element.description.toLowerCase().contains(searchText) ||
            element.university.toLowerCase().contains(searchText))
        .toList();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.sizeOf(context).height;
    var width = MediaQuery.sizeOf(context).width;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Summer of Bitcoin'),
      ),
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
                                projectList = sob2021;
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
                                projectList = sob2022;
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
                                projectList = sob2023;
                                selectedYear = 2023;
                              });
                            },
                            backgroundColor: selectedYear == 2023
                                ? Colors.white
                                : const Color.fromRGBO(255, 183, 77, 1),
                          ),
                        ],
                      ),
                    ),
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
                            child: SobProjectWidget(
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
