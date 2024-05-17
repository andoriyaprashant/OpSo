import 'package:flutter/material.dart';
import 'package:opso/modals/book_mark_model.dart';

import '../modals/GSoC/Gsoc.dart';
import '../services/ApiService.dart';
import '../widgets/SearchandFilterWidget.dart';
import '../widgets/gsoc/GsocProjectWidget.dart';
import '../widgets/year_button.dart';

class GoogleSummerOfCodeScreen extends StatefulWidget {
  const GoogleSummerOfCodeScreen({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _GoogleSummerOfCodeScreenState createState() => _GoogleSummerOfCodeScreenState();
}

class _GoogleSummerOfCodeScreenState extends State<GoogleSummerOfCodeScreen> {
  bool flag = true;
  String currectPage = "/google_summer_of_code";
  String currentProject = "Google Summer of Code";
  bool isBookmarked = true;


@override
  void initState() {
    super.initState();
    _checkBookmarkStatus();
    getProjectData();
  }

  Future<void> _checkBookmarkStatus() async {
    bool bookmarkStatus = await HandleBookmark.isBookmarked(currentProject);
    setState(() {
      isBookmarked = bookmarkStatus;
    });
  }
  List<Organization> gssoc2024 = [];
  List<Organization> gssoc2023 = [];
  List<Organization> gssoc2022 = [];
  List<Organization> gssoc2021 = [];
  int selectedYear = 2024;
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
  List<Gsoc> projectList = [];
  List<Organization> orgList = [];

  void searchTag(String searchTag) {
    orgList = orgList
        .where((element) =>
    element.technologies.contains(searchTag) ||
        element.topics.contains(searchTag))
        .toList();
    setState(() {});
  }

  void search(String searchText) {
    if (searchText.isEmpty) {
      switch (selectedYear) {
        case 2021:
          orgList = gssoc2021;
          break;
        case 2022:
          orgList = gssoc2022;
          break;
        case 2023:
          orgList = gssoc2023;
          break;
        case 2024:
          orgList = gssoc2024;
          break;
      }
      setState(() {});
      return;
    }
    orgList = orgList
        .where((element) =>
        element.name.toLowerCase().contains(searchText.toLowerCase()))
        .toList();
    setState(() {});
  }
  void getProjectData() async{
    ApiService apiService = ApiService();
    try {
      Gsoc orgData = await apiService.getOrgByYear('2021');
      gssoc2021 = orgData.organizations;
      Gsoc orgData1 = await apiService.getOrgByYear('2022');
      gssoc2022 = orgData1.organizations;
      Gsoc orgData2 = await apiService.getOrgByYear('2023');
      gssoc2023 = orgData2.organizations;
      Gsoc orgData3 = await apiService.getOrgByYear('2024');
      gssoc2024 = orgData3.organizations;
      print("org data $gssoc2021");
    } catch (e) {
      print('Error: $e');
    }
  }
  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.sizeOf(context).height;
    var width = MediaQuery.sizeOf(context).width;
    return Scaffold(

      appBar: AppBar(
        title: const Text('OpSo'),
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
                    content: Text(isBookmarked ? 'Bookmark added' : 'Bookmark removed'),
                    duration: const Duration(seconds: 1), // Adjust the duration as needed
                  ),
                );
              if(isBookmarked){
                print("Adding");
                HandleBookmark.addBookmark(currentProject, currectPage);
              }
              else{
                print("Deleting");
                HandleBookmark.deleteBookmark(currentProject);
              }
            },
            )
          ]
        ),

      body: FutureBuilder(
        future: ApiService().getOrgByYear('2021'), // Fetch organization data
        builder: (context, AsyncSnapshot<Gsoc> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else {
            print("project length: ${snapshot.data!.organizations.length}");
            final List<Organization> organizations = snapshot.data!.organizations;
            orgList = organizations;
            projectList.add(snapshot.data!);
            print("project list ${projectList.length}");
            return
              Padding(
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
                                orgList = gssoc2021;
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
                                orgList = gssoc2022;
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
                                orgList = gssoc2023;
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
                                orgList = gssoc2024;
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
                                        orgList = gssoc2021;
                                        break;
                                      case 2022:
                                        orgList = gssoc2022;
                                        break;
                                      case 2023:
                                        orgList = gssoc2023;
                                        break;
                                      case 2024:
                                        orgList = gssoc2024;
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
                      child: ListView.builder(
                        itemCount : orgList.length,
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