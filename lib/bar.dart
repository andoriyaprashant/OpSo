import 'package:flutter/material.dart';
import 'package:opso/about.dart';
import 'package:url_launcher/link.dart';
import 'package:opso/widgets/book_mark_screen.dart';

class AppBarWidget extends StatelessWidget implements PreferredSizeWidget {
  const AppBarWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'OpSo',
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: () {
              showSearch(context: context, delegate: CustomSearchDelegate());
             },
           ),
         ],
      ),
      body: Material(
        color: Colors.transparent,
        child: Ink(
          decoration: const BoxDecoration(
            color: Colors.white,
          ),
          child: InkWell(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: ListView(
                children: [

                  MenuOption(
                    title: 'Bookmarks',
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => const BookMarkScreen()),
                      );
                    },
                  ),

                  const Padding(padding: EdgeInsets.only(top: 40)),

                  MenuOption(
                    title: 'About',
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => AboutScreen()),
                      );
                    },
                  ),

                ],
              ),
            ),       
          ),
      ),
    )
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}

class MenuOption extends StatefulWidget {
  final String title;
  final VoidCallback onTap;

  const MenuOption({
    Key? key,
    required this.title,
    required this.onTap,
  }) : super(key: key);

  @override
  _MenuOptionState createState() => _MenuOptionState();
}

class _MenuOptionState extends State<MenuOption> {
  bool _isClicked = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        setState(() {
          _isClicked = !_isClicked;
        });
        widget.onTap();
      },
      child: Material(
        child: Ink(
          decoration: BoxDecoration(
            color: const Color.fromARGB(255, 237, 237, 239),
            borderRadius: BorderRadius.circular(25),
          ),
          child: InkWell(
            borderRadius: BorderRadius.circular(20),
            onTap: () {
              setState(() {
                _isClicked = !_isClicked;
              });
              widget.onTap();
            },
            child: Container(
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Text(
                        widget.title,
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  
                    const Icon(Icons.arrow_forward_ios),
                  ],
                ),
              ),
          ),
        ),
      ),
    )
    );
  }
}

class CustomSearchDelegate extends SearchDelegate {
  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      query.isNotEmpty
          ? IconButton(
        icon: const Icon(Icons.clear),
        onPressed: () {
          query = '';
          showSuggestions(context);
        },
      )
          : Container(),
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.arrow_back),
      onPressed: () {
        close(context, null);
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    // Implement your search results logic here.
    return Center(
      child: Text('Search Result for "$query"'),
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    // Implement your search suggestions logic here.
    return Center(
      child: Text('Suggestions for "$query"'),
    );
  }
}
