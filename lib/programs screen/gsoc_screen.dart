import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:opso/modals/gsoc_modal.dart';
import 'package:opso/widgets/gsoc_widgets.dart';
import 'package:opso/widgets/year_button.dart';
import '../widgets/SearchandFilterWidget.dart';

class GsocScreen extends StatefulWidget {
  const GsocScreen({super.key});

  @override
  State<GsocScreen> createState() => _GsocScreenState();
}

class _GsocScreenState extends State<GsocScreen> {
  List<GsocProjectModel> gsoc2024 = [];
  List<GsocProjectModel> gsoc2023 = [];
  List<GsocProjectModel> gsoc2022 = [];
  List<GsocProjectModel> gsoc2021 = [];
  int selectedYear = 2024;

  List<GsocProjectModel> projectList = [];
  Future<void>? getProjectFunction;

  Future<void> initializeProjectLists() async {
    String response =
        await rootBundle.loadString('assets/projects/gsoc/gsoc2024.json');
    var jsonList = await json.decode(response);
    for (var data in jsonList) {
      gsoc2024.add(GsocProjectModel.getDataFromJson(data));
    }
    projectList = List.from(gsoc2024);
    response =
        await rootBundle.loadString('assets/projects/gsoc/gsoc2023.json');
    jsonList = await json.decode(response);
    for (var data in jsonList) {
      gsoc2023.add(GsocProjectModel.getDataFromJson(data));
    }
    response =
        await rootBundle.loadString('assets/projects/gsoc/gsoc2022.json');
    jsonList = await json.decode(response);
    for (var data in jsonList) {
      gsoc2022.add(GsocProjectModel.getDataFromJson(data));
    }
    response =
        await rootBundle.loadString('assets/projects/gsoc/gsoc2021.json');
    jsonList = await json.decode(response);
    for (var data in jsonList) {
      gsoc2021.add(GsocProjectModel.getDataFromJson(data));
    }
  }

  @override
  void initState() {
    getProjectFunction = initializeProjectLists();
    super.initState();
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
          projectList = gsoc2021;
          break;
        case 2022:
          projectList = gsoc2022;
          break;
        case 2023:
          projectList = gsoc2023;
          break;
        case 2024:
          projectList = gsoc2024;
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
    List<String> languages = [
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
    return Scaffold(
      appBar: AppBar(
        title: const Text('Google Summer of Code'),
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
                            isEnabled: selectedYear == 2021,
                            onTap: () {
                              setState(() {
                                projectList = gsoc2021;
                                selectedYear = 2021;
                              });
                            },
                            backgroundColor: selectedYear == 2021
                                ? Colors.white
                                : const Color.fromRGBO(255, 183, 77, 1),
                          ),
                          YearButton(
                            year: "2022",
                            isEnabled: selectedYear == 2022,
                            onTap: () {
                              setState(() {
                                projectList = gsoc2022;
                                selectedYear = 2022;
                              });
                            },
                            backgroundColor: selectedYear == 2022
                                ? Colors.white
                                : const Color.fromRGBO(255, 183, 77, 1),
                          ),
                          YearButton(
                            year: "2023",
                            isEnabled: selectedYear == 2023,
                            onTap: () {
                              setState(() {
                                projectList = gsoc2023;
                                selectedYear = 2023;
                              });
                            },
                            backgroundColor: selectedYear == 2023
                                ? Colors.white
                                : const Color.fromRGBO(255, 183, 77, 1),
                          ),
                          YearButton(
                            isEnabled: selectedYear == 2024,
                            year: "2024",
                            onTap: () {
                              setState(() {
                                projectList = gsoc2024;
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
                    const SizedBox(height: 20),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        const Text(
                          'Filter by Language:',
                          style: TextStyle(fontWeight: FontWeight.w400),
                        ),
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
                                        projectList = gsoc2021;
                                        break;
                                      case 2022:
                                        projectList = gsoc2022;
                                        break;
                                      case 2023:
                                        projectList = gsoc2023;
                                        break;
                                      case 2024:
                                        projectList = gsoc2024;
                                        break;
                                    }
                                    searchTag(newValue);
                                  });
                                },
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    Expanded(
                      child: ListView.builder(
                        itemCount: projectList.length,
                        itemBuilder: (BuildContext context, int index) {
                          return Padding(
                            padding: const EdgeInsets.symmetric(vertical: 10),
                            child: GsocProjectWidget(
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
              return const Center(child: Text("Some error occurred"));
            }
          }),
    );
  }
}
