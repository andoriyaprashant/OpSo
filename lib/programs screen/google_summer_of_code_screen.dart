import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:opso/widgets/gsoc/GsocProjectWidget.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:multi_select_flutter/multi_select_flutter.dart';
import '../modals/GSoC/Gsoc.dart';
import '../services/ApiService.dart';
import '../widgets/SearchandFilterWidget.dart';
import '../widgets/year_button.dart';


class GoogleSummerOfCodeScreen extends StatefulWidget {
  @override
  State<GoogleSummerOfCodeScreen> createState() =>
      _GoogleSummerOfCodeScreenState();
}


class _GoogleSummerOfCodeScreenState extends State<GoogleSummerOfCodeScreen> {
  bool _isRefreshing = false;
  String selectedOrg = ''; // Ensure this is defined
  List<Organization> gsoc2024 = [];
  List<Organization> gsoc2023 = [];
  List<Organization> gsoc2022 = [];
  List<Organization> gsoc2021 = [];
  int selectedYear = 2024;
  List<String> languages = [
    'js',
    'python',
    'django',
    'Angular',
    'Bootstrap',
    'Firebase',
    'Node',
    'MongoDb',
    'Express',
    'Next',
    'css',
    'html',
    'javascript',
    'flutter',
    'Dart'
  ];
  List<Organization> orgList = [];
  List<String> selectedLanguages = [];
  List<String> allOrganizations = [];
  List<String> selectedOrganizations = [];
  late Future<void> _dataFetchFuture;




  @override
  void initState() {
    super.initState();
    _refresh();
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
        allOrganizations = [...orgList.map((org) => org.name!).toSet()];
      });
    } catch (e) {
      print('Error: $e');
    }
  }




  void filterProjects() {
    orgList = _getOrganizationsByYear(selectedYear);
    if(selectedLanguages.length>=2){
      selectedLanguages.removeAt(0);
    }
    if(selectedOrganizations.length>=2){
      selectedOrganizations.removeAt(0);
    }
    if (!selectedLanguages.contains('All')) {
      orgList = orgList.where((project) =>
          selectedLanguages.every((language) => project.technologies?.contains(language) == true)
      ).toList();
    }






    if (!selectedOrganizations.contains('All')) {
      orgList = orgList
          .where((project) => selectedOrganizations.contains(project.name))
          .toList();
    }




    // Update organization filter based on selected languages
    allOrganizations = [
      ..._getOrganizationsByYear(selectedYear)
          .where((org) =>
      selectedLanguages.contains('All') ||
          org.technologies?.any(selectedLanguages.contains) == true)
          .map((org) => org.name!)
          .toSet()
    ];




    setState(() {});
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




  Future<void> _refresh() async {
    setState(() {
      _isRefreshing = true;
    });
    await getProjectData();
    setState(() {
      selectedYear = 2024;
      selectedLanguages = ['All'];
      selectedOrganizations = ['All'];
      filterProjects();
      _isRefreshing = false;
    });
  }




  // Add this method to the _GoogleSummerOfCodeScreenState class
  void search(String searchText) {
    setState(() {
      selectedOrg = 'All'; // Reset selectedOrg to avoid mismatch
      if (searchText.isEmpty) {
        orgList = _getOrganizationsByYear(selectedYear);
      } else {
        orgList = _getOrganizationsByYear(selectedYear)
            .where((element) =>
        element.name
            ?.toLowerCase()
            .contains(searchText.toLowerCase()) ==
            true)
            .toList();
      }
    });
  }




  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;




    return RefreshIndicator(
      onRefresh: _refresh,
      child: Scaffold(
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
              return SingleChildScrollView(
                child: Padding(
                  padding:
                  const EdgeInsets.symmetric(horizontal: 46, vertical: 16),
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
                                  selectedLanguages = [];
                                  selectedOrganizations = [];
                                  filterProjects();
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
                                  selectedLanguages = [];
                                  selectedOrganizations = [];
                                  filterProjects();
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
                                  selectedLanguages = [];
                                  selectedOrganizations = [];
                                  filterProjects();
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
                                  selectedLanguages = [];
                                  selectedOrganizations = [];
                                  filterProjects();
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
                      _buildMultiSelectField(
                        items: languages,
                        selectedValues: selectedLanguages,
                        title: "Select Languages",
                        buttonText: "Filter by Language",
                        onConfirm: (results) {
                          setState(() {
                            selectedLanguages =
                            results.isNotEmpty ? results : [];
                            print(selectedLanguages);
                            filterProjects();
                          });
                        },
                      ),
                      const SizedBox(height: 20),
                      orgList.isEmpty
                          ? _isRefreshing
                          ? Column(
                        children: const [
                          Center(
                              child: Column(
                                children: [
                                  CircularProgressIndicator(),
                                  SizedBox(height: 10),
                                  Text('Refreshing...'),
                                ],
                              )
                          ),
                          SizedBox(height: 20),
                        ],
                      )
                          : Column(
                        children: [
                          const Center(child: Text('No projects found')),
                          const SizedBox(height: 20),
                          TextButton(
                            onPressed: () {
                              _refresh();
                            },
                            child: const Text('Refresh'),
                          ),
                        ],
                      )
                          : Container(
                        height: height,
                        child: ListView.builder(
                          itemCount: orgList.length,
                          itemBuilder: (context, index) {
                            return Padding(
                              padding: const EdgeInsets.symmetric(vertical: 10),
                              child: Container(
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(20),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.grey.withOpacity(0.5),
                                      spreadRadius: 2,
                                      blurRadius: 5,
                                      offset: Offset(0, 3), // changes position of shadow
                                    ),
                                  ],
                                ),
                                child: GsocProjectWidget(
                                  index: index + 1,
                                  modal: orgList[index],
                                  height: height * 0.2,
                                  width: width,
                                ),
                              ),
                            );
                          },
                        ),
                      ),


                    ],
                  ),
                ),
              );
            }
          },
        ),
      ),
    );
  }




  Widget _buildMultiSelectField({
    required List<String> items,
    required List<String> selectedValues,
    required String title,
    required String buttonText,
    required void Function(List<String>) onConfirm,
  }) {
    bool isDarkMode = Theme.of(context).brightness == Brightness.dark;
    return MultiSelectDialogField(
      backgroundColor: isDarkMode ? Colors.grey.shade100 : Colors.white,
      items: items.map((e) => MultiSelectItem<String>(e, e)).toList(),
      initialValue: selectedValues,
      title: Text(title,
          style: TextStyle(color: isDarkMode ? Colors.black : Colors.black)),
      buttonText: Text(buttonText),
      onConfirm: onConfirm,
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey),
        borderRadius: BorderRadius.circular(10),
      ),
    );
  }
}




void main() {
  runApp(MaterialApp(
    home: GoogleSummerOfCodeScreen(),
  ));
}



