import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:opso/widgets/gsoc/GsocProjectWidget.dart';
import 'package:url_launcher/url_launcher.dart';

import '../modals/GSoC/Gsoc.dart';
import '../services/ApiService.dart';
import '../widgets/SearchandFilterWidget.dart';
import '../widgets/year_button.dart';

class GoogleSummerOfCodeScreen extends StatefulWidget {
  @override
  State<GoogleSummerOfCodeScreen> createState() => _GoogleSummerOfCodeScreenState();
}

class _GoogleSummerOfCodeScreenState extends State<GoogleSummerOfCodeScreen> {
  List<Organization> gsoc2024 = [];
  List<Organization> gsoc2023 = [];
  List<Organization> gsoc2022 = [];
  List<Organization> gsoc2021 = [];
  int selectedYear = 2024;
  List<String> languages = [
    'js',
    'python',
    'React',
    'Angular',
    'Bootstrap',
    'Firebase',
    'Node',
    'MongoDb',
    'Express',
    'Next',
    'css',
    'html',
    'javaScript',
    'flutter',
    'Dart'
  ];
  List<Organization> orgList = [];
  late Future<void> _dataFetchFuture;

  @override
  void initState() {
    super.initState();
    _dataFetchFuture = getProjectData();
  }

  Future<void> getProjectData() async {
    ApiService apiService = ApiService();
    try {
      Gsoc orgData2021 = await apiService.getOrgByYear('2021');
      Gsoc orgData2022 = await apiService.getOrgByYear('2022');
      Gsoc orgData2023 = await apiService.getOrgByYear('2023');
      Gsoc orgData2024 = await apiService.getOrgByYear('2024');

      setState(() {
        gsoc2021 = orgData2021.organizations ?? [];
        gsoc2022 = orgData2022.organizations ?? [];
        gsoc2023 = orgData2023.organizations ?? [];
        gsoc2024 = orgData2024.organizations ?? [];
        orgList = gsoc2024; // Default to the latest year
      });
    } catch (e) {
      print('Error: $e');
    }
  }

  void searchTag(String searchTag) {
    setState(() {
      orgList = _getOrganizationsByYear(selectedYear)
          .where((element) => element.technologies?.contains(searchTag) == true || element.topics?.contains(searchTag) == true)
          .toList();
    });
  }

  void search(String searchText) {
    setState(() {
      if (searchText.isEmpty) {
        orgList = _getOrganizationsByYear(selectedYear);
      } else {
        orgList = _getOrganizationsByYear(selectedYear)
            .where((element) => element.name?.toLowerCase().contains(searchText.toLowerCase()) == true)
            .toList();
      }
    });
  }

  List<Organization> _getOrganizationsByYear(int year) {
    switch (year) {
      case 2021:
        return gsoc2021;
      case 2022:
        return gsoc2022;
      case 2023:
        return gsoc2023;
      case 2024:
        return gsoc2024;
      default:
        return [];
    }
  }

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        title: Text('Google Summer of Code'),
      ),
      body: FutureBuilder<void>(
        future: _dataFetchFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else {
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 46, vertical: 16),
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
                              selectedYear = 2021;
                              orgList = gsoc2021;
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
                              selectedYear = 2022;
                              orgList = gsoc2022;
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
                              selectedYear = 2023;
                              orgList = gsoc2023;
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
                              selectedYear = 2024;
                              orgList = gsoc2024;
                            });
                          },
                          backgroundColor: selectedYear == 2024
                              ? Colors.white
                              : const Color.fromRGBO(255, 183, 77, 1),
                        ),
                      ],
                    ),
                  ),
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
                                searchTag(newValue);
                              },
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                  Expanded(
                    child: ListView.builder(
                      itemCount: orgList.length,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: const EdgeInsets.symmetric(vertical: 10),
                          child: Column(
                            children: [
                              GsocProjectWidget(
                                index: index + 1,
                                modal: orgList[index],
                                height: height * 0.2,
                                width: width,
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            );
          }
        },
      ),
    );
  }
}

void main() {
  runApp(MaterialApp(
    home: GoogleSummerOfCodeScreen(),
  ));
}
