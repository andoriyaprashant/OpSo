import 'package:flutter/material.dart';

import '../modals/gssoc_project_modal.dart';

class DropdownWidget extends StatefulWidget {
  final List<String> items;
  final String hintText;
  final ValueChanged<String> onChanged;

  DropdownWidget({
    required this.items,
    required this.hintText,
    required this.onChanged,
  });

  @override
  _DropdownWidgetState createState() => _DropdownWidgetState();
}

class _DropdownWidgetState extends State<DropdownWidget> {
  late String selectedItem;

  @override
  void initState() {
    super.initState();
    // Set the initial value to the first item in the list
    selectedItem = widget.items.first;
  }

  @override
  Widget build(BuildContext context) {
    return DropdownButton<String>(
      hint: Text(widget.hintText),
      value: selectedItem,
      onChanged: (newValue) {
        setState(() {
          selectedItem = newValue!;
        });
        widget.onChanged(newValue!);
      },
      items: widget.items.map((item) {
        return DropdownMenuItem<String>(
          value: item,
          child: Text(item),
        );
      }).toList(),
    );
  }
}

class SearchAndFilterWidget extends StatefulWidget {
  final List<GssocProjectModal> projectList;
  SearchAndFilterWidget({ required this.projectList});
  @override
  _SearchAndFilterWidgetState createState() => _SearchAndFilterWidgetState();
}

class _SearchAndFilterWidgetState extends State<SearchAndFilterWidget> {
  late String selectedOrganization;
  late String selectedLanguage;
  List<String> year = ['2022', '2023', '2024'];
  List<String> languages = ['Python', 'JavaScript', 'Java', 'Swift', 'C#'];

  @override
  void initState() {
    super.initState();

    selectedOrganization = year[0];
    selectedLanguage = languages[0];
  }
  String searchQuery = '';

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 0.0, vertical: 8.0),
      child: Column(
        children: [

          SizedBox(width: 10.0),
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
                      selectedLanguage = newValue;
                    });
                    // Perform filtering based on selectedLanguage
                  },
                ),
              ],
            ),
          )

        ],
      ),
    );
  }
}