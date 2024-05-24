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
  final GlobalKey<AnimatedListState> _listKey = GlobalKey<AnimatedListState>();

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
      _populateAnimatedList(orgList);
    } catch (e) {
      print('Error: $e');
    }
  }

  void _clearAnimatedList() {
    for (var i = orgList.length - 1; i >= 0; i--) {
      _listKey.currentState?.removeItem(
        i,
            (context, animation) => SizedBox.shrink(),
        duration: Duration.zero,
      );
    }
  }

  void _populateAnimatedList(List<Organization> organizations) {
    for (var i = 0; i < organizations.length; i++) {
      _listKey.currentState?.insertItem(i);
    }
  }

  void searchTag(String searchTag) {
    setState(() {
      _clearAnimatedList();
      orgList = _getOrganizationsByYear(selectedYear)
          .where((element) => element.technologies?.contains(searchTag) == true || element.topics?.contains(searchTag) == true)
          .toList();
      _populateAnimatedList(orgList);
    });
  }

  void search(String searchText) {
    setState(() {
      _clearAnimatedList();
      if (searchText.isEmpty) {
        orgList = _getOrganizationsByYear(selectedYear);
      } else {
        orgList = _getOrganizationsByYear(selectedYear)
            .where((element) => element.name?.toLowerCase().contains(searchText.toLowerCase()) == true)
            .toList();
      }
      _populateAnimatedList(orgList);
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
                              _clearAnimatedList();
                              orgList = gsoc2021;
                            });
                            _populateAnimatedList(gsoc2021);
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
                              _clearAnimatedList();
                              orgList = gsoc2022;
                            });
                            _populateAnimatedList(gsoc2022);
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
                              _clearAnimatedList();
                              orgList = gsoc2023;
                            });
                            _populateAnimatedList(gsoc2023);
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
                              _clearAnimatedList();
                              orgList = gsoc2024;
                            });
                            _populateAnimatedList(gsoc2024);
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
                    child: AnimatedList(
                      key: _listKey,
                      initialItemCount: orgList.length,
                      itemBuilder: (context, index, animation) {
                        return _buildAnimatedItem(context, index, animation, height, width);
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

  Widget _buildAnimatedItem(BuildContext context, int index, Animation<double> animation, double height, double width) {
    return SizeTransition(
      sizeFactor: animation,
      axis: Axis.vertical,
      child: Padding(
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
        ),
      ),
    );
  }
}

void main() {
  runApp(MaterialApp(
    home: GoogleSummerOfCodeScreen(),
  ));
}