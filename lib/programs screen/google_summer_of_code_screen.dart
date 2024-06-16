import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:multi_select_flutter/dialog/multi_select_dialog_field.dart';
import 'package:multi_select_flutter/util/multi_select_item.dart';
import 'package:opso/modals/book_mark_model.dart';
import 'package:opso/widgets/year_button.dart';
import 'package:opso/programs_info_pages/gsoc_info.dart';
import 'package:opso/widgets/gsoc/GsocProjectWidget.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:multi_select_flutter/multi_select_flutter.dart';
import '../modals/GSoC/Gsoc.dart';
import '../widgets/gsoc/GsocProjectWidget.dart';


class GoogleSummerOfCodeScreen extends StatefulWidget {
  const GoogleSummerOfCodeScreen({super.key});


  @override
  State<GoogleSummerOfCodeScreen> createState() => _GoogleSummerOfCodeScreenState();
}


class _GoogleSummerOfCodeScreenState extends State<GoogleSummerOfCodeScreen> {
  String currentPage = "/Google_summer_of_code";
  String currentProject = "Google Summer of Code";
  List<GsocModel> gsoc2023 = [];
  List<GsocModel> gsoc2022 = [];
  List<GsocModel> gsoc2021 = [];
  List<GsocModel> gsoc2019 = [];
  List<GsocModel> gsoc2020 = [];
  List<String> allGsocModels = [];
  List<String> allLanguages = [];
  List<String> selectedGsocModels = ['All'];
  List<String> selectedLanguages = ['All'];
  int selectedYear = 2024;
  bool isBookmarked = true;
  List<GsocModel> projectList = [];
  Future<void>? getProjectFunction;


  Future<void> initializeProjectLists() async {
    await _loadProjects('assets/projects/gsod/gsod2019.json', gsoc2019);
    await _loadProjects('assets/projects/gsod/gsod2023.json', gsoc2023);
    await _loadProjects('assets/projects/gsod/gsod2022.json', gsoc2022);
    await _loadProjects('assets/projects/gsod/gsod2021.json', gsoc2021);
    await _loadProjects('assets/projects/gsod/gsod2020.json', gsoc2020);


    // Populate all unique GsocModels and languages
    allGsocModels = _extractUniqueValues((project) => project.organization!);
    allLanguages = languages;
    projectList = List.from(gsoc2023); // Default year
  }


  List<String> languages = [
    'All',
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


  Future<void> _loadProjects(String path, List<GsocModel> list) async {
    String response = await rootBundle.loadString(path);
    var jsonList = json.decode(response) as List;
    list.addAll(jsonList.map((data) => GsocModel.fromJson(data)).toList());
  }


  List<String> _extractUniqueValues(String Function(GsocModel) extractor) {
    return {
      'All',
      ...gsoc2020.map(extractor),
      ...gsoc2023.map(extractor),
      ...gsoc2022.map(extractor),
      ...gsoc2021.map(extractor),
      ...gsoc2019.map(extractor),
    }.toList();
  }


  List<String> _extractUniqueLanguages(List<String> Function(GsocModel) extractor) {
    final allLanguages = [
      for (var project in gsoc2020) ...extractor(project),
      for (var project in gsoc2023) ...extractor(project),
      for (var project in gsoc2022) ...extractor(project),
      for (var project in gsoc2021) ...extractor(project),
      for (var project in gsoc2019) ...extractor(project),
    ];
    return ['All', ...allLanguages.toSet()];
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


  void filterProjects() {
    // Filter projects by year first
    projectList = _getProjectsByYear();


    // Filter projects by selected languages
    if (!selectedLanguages.contains('All')) {
      projectList = projectList.where((project) =>
          selectedLanguages.every((language) => project.organizationUrl!.contains(language))
      ).toList();
    }


    // Update the list of GsocModels based on the filtered projects by language
    _updateGsocModelList();


    // Filter projects by selected GsocModels
    if (!selectedGsocModels.contains('All')) {
      projectList = projectList.where((project) => selectedGsocModels.contains(project.organization)).toList();
    }


    // Ensure state is updated to reflect changes
    setState(() {});
  }




  void _updateGsocModelList() {
    allGsocModels = _extractUniqueValues((project) => project.organization!)
        .where((GsocModel) => projectList.any((project) => project.organization == GsocModel))
        .toList();
    allGsocModels.insert(0, 'All');
  }


  List<GsocModel> _getProjectsByYear() {
    switch (selectedYear) {
      case 2021:
        return gsoc2021;
      case 2022:
        return gsoc2022;
      case 2023:
        return gsoc2023;
      case 2020:
        return gsoc2020;
      case 2019:
        return gsoc2019;
      default:
        return [];
    }
  }


  Future<void> _refresh() async {
    await initializeProjectLists();
    setState(() {
      selectedYear = 2023;
      selectedGsocModels = ['All'];
      selectedLanguages = ['All'];
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
          title: const Text('Google Summer of Code'),
          actions: <Widget>[IconButton(
            icon: const Icon(Icons.info_outline),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const GSOCInfo()),                );
            },
          ),],
        ),
        body: FutureBuilder<void>(
          future: getProjectFunction,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            } else if (snapshot.connectionState == ConnectionState.done) {
              return SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 48, vertical: 8),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      _buildSearchBar(),
                      const SizedBox(height: 20),
                      _buildYearButtons(),
                      const SizedBox(height: 20),
                      _buildMultiSelectField(
                        items: allLanguages,
                        selectedValues: selectedLanguages,
                        title: "Select Languages",
                        buttonText: "Filter by Language",
                        onConfirm: (results) {
                          setState(() {
                            selectedLanguages = results.isNotEmpty ? results : ['All'];
                            print(selectedLanguages);
                            filterProjects();
                          });
                        },
                      ),
                      const SizedBox(height: 20),
                      const SizedBox(height: 20),
                      _buildProjectList(height, width),
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


  Widget _buildSearchBar() {
    return TextFormField(
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
        contentPadding: const EdgeInsets.symmetric(vertical: 12.0, horizontal: 20.0),
      ),
      onFieldSubmitted: (value) {
        setState(() {
          projectList = _getProjectsByYear()
              .where((project) => project.organization!.toLowerCase().contains(value.toLowerCase()))
              .toList();
        });
      },
      onChanged: (value) {
        if (value.isEmpty) {
          setState(() {
            projectList = _getProjectsByYear();
          });
        }
      },
    );
  }


  Widget _buildYearButtons() {
    var height = MediaQuery.sizeOf(context).height;
    return SizedBox(
      height: height * 0.3,
      child: GridView(
        physics: const NeverScrollableScrollPhysics(),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          childAspectRatio: 1.5 / 0.6,
          crossAxisCount: 2,
          crossAxisSpacing: 15,
          mainAxisSpacing: 15,
        ),
        children: [
          YearButton(
            year: "2019",
            isEnabled: selectedYear == 2019,
            onTap: () {
              setState(() {
                selectedYear = 2019;
                filterProjects();
              });
            },
            backgroundColor: selectedYear == 2019 ? Colors.white : const Color.fromRGBO(255, 183, 77, 1),
          ),
          YearButton(
            year: "2020",
            isEnabled: selectedYear == 2020,
            onTap: () {
              setState(() {
                selectedYear = 2020;
                filterProjects();
              });
            },
            backgroundColor: selectedYear == 2020 ? Colors.white : const Color.fromRGBO(255, 183, 77, 1),
          ),
          YearButton(
            year: "2021",
            isEnabled: selectedYear == 2021,
            onTap: () {
              setState(() {
                selectedYear = 2021;
                filterProjects();
              });
            },
            backgroundColor: selectedYear == 2021 ? Colors.white : const Color.fromRGBO(255, 183, 77, 1),
          ),
          YearButton(
            year: "2022",
            isEnabled: selectedYear == 2022,
            onTap: () {
              setState(() {
                selectedYear = 2022;
                filterProjects();
              });
            },
            backgroundColor: selectedYear == 2022 ? Colors.white : const Color.fromRGBO(255, 183, 77, 1),
          ),
          YearButton(
            year: "2023",
            isEnabled: selectedYear == 2023,
            onTap: () {
              setState(() {
                selectedYear = 2023;
                filterProjects();
              });
            },
            backgroundColor: selectedYear == 2023 ? Colors.white : const Color.fromRGBO(255, 183, 77, 1),
          ),
        ],
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
      title: Text(title,style: TextStyle(color: isDarkMode ? Colors.black : Colors.black)),
      buttonText: Text(buttonText),
      onConfirm: onConfirm,
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey),
        borderRadius: BorderRadius.circular(10),
      ),
    );
  }


  Widget _buildProjectList(double height, double width) {
    return Container(
      height: double.maxFinite, // Set a specific height here
      child: ListView.builder(
        physics: NeverScrollableScrollPhysics(),
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
    );
  }
}

