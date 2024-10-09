import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:opso/about.dart';
import 'package:opso/widgets/book_mark_screen.dart';

class AppBarWidget extends StatelessWidget implements PreferredSizeWidget {
  const AppBarWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(
      context,
      designSize: const Size(360, 690),
    );

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          'OpSo',
          style: TextStyle(
              fontSize: ScreenUtil().setSp(20), fontWeight: FontWeight.bold),
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
          decoration: BoxDecoration(
            color: Colors.white,
          ),
          child: InkWell(
            child: Padding(
              padding: EdgeInsets.all(ScreenUtil().setWidth(16)),
              child: ListView(
                children: [
                  MenuOption(
                    title: 'Bookmarks',
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const BookMarkScreen()),
                      );
                    },
                  ),
                  Padding(
                      padding:
                          EdgeInsets.only(top: ScreenUtil().setHeight(40))),
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
      ),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
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
            borderRadius: BorderRadius.circular(ScreenUtil().setWidth(25)),
          ),
          child: InkWell(
            borderRadius: BorderRadius.circular(ScreenUtil().setWidth(20)),
            onTap: () {
              setState(() {
                _isClicked = !_isClicked;
              });
              widget.onTap();
            },
            child: Container(
              child: Padding(
                padding: EdgeInsets.all(ScreenUtil().setWidth(10)),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Padding(
                      padding: EdgeInsets.all(ScreenUtil().setWidth(10)),
                      child: Text(
                        widget.title,
                        style: TextStyle(
                          fontSize: ScreenUtil().setSp(18),
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
      ),
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
