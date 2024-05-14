import 'package:beautiful_soup_dart/beautiful_soup.dart';
import 'package:flutter/material.dart';
import 'package:opso/services/card_service.dart';
import 'package:opso/services/data_service.dart';
import 'package:opso/webview_screen.dart';

// class GSSOCScreen extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Girl Script Summer of Code'),
//         actions: [
//           IconButton(onPressed: (){
//             Navigator.push(context, MaterialPageRoute(builder: (context){
//               return WebviewScreen("https://gssoc.girlscript.tech/");
//             }));
//           }, icon: Icon(Icons.link))
//         ],
//       ),
//       body: Column(
//         crossAxisAlignment: CrossAxisAlignment.stretch,
//         children: [
//           Padding(
//             padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
//             child: TextField(
//               decoration: InputDecoration(
//                 hintText: 'Search',
//                 prefixIcon: Icon(Icons.search),
//                 border: OutlineInputBorder(
//                   borderRadius: BorderRadius.circular(30.0),
//                 ),
//                 contentPadding: EdgeInsets.symmetric(vertical: 12.0, horizontal: 20.0),
//               ),
//               onChanged: (value) {
//                 // Handle search input
//               },
//             ),
//           ),
//           SizedBox(height: 20),
//           Row(
//             mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//             children: [
//               YearButton(
//                 year: '2021',
//                 url: 'https://gssoc.girlscript.tech/project', // Replace with actual URL
//               ),
//               YearButton(
//                 year: '2022',
//                 url: 'https://gssoc.girlscript.tech/project', // Replace with actual URL
//               ),
//             ],
//           ),
//           SizedBox(height: 20),
//           Row(
//             mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//             children: [
//               YearButton(
//                 year: '2023',
//                 url: 'https://gssoc.girlscript.tech/project', // Replace with actual URL
//               ),
//               YearButton(
//                 year: '2024',
//                 url: 'https://gssoc.girlscript.tech/project', // Replace with actual URL
//               ),
//             ],
//           ),
//           SizedBox(height: 20),
//           ElevatedButton(
//             onPressed: () {
//               // launch('https://example.com/projects'); // Replace with actual URL
//             },
//             style: ElevatedButton.styleFrom(
//               backgroundColor: Color.fromARGB(255, 226, 230, 120), // Set button color
//               padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 30.0),
//             ),
//             child: Text('View Projects'),
//           ),
//         ],
//       ),
//     );
//   }
// }
//
// class YearButton extends StatelessWidget {
//   final String year;
//   final String url;
//
//   const YearButton({required this.year, required this.url});
//
//   @override
//   Widget build(BuildContext context) {
//     return ElevatedButton(
//       onPressed: () {
//         // ignore: deprecated_member_use
//         // launch(url);
//         // Navigator.push(context, MaterialPageRoute(builder: (context){
//         //   return WebScrapScreen("https://gssoc.girlscript.tech/project");
//         // }));
//
//         String html = DataService.data["GirlScriptSummerOfCode"]![year].toString();
//         print(html);
//         BeautifulSoup beautifulSoup = BeautifulSoup(html);
//         final list = beautifulSoup.find("div",class_: "flex flex-row justify-center flex-wrap items-center gap-x-10 gap-y-10 mt-9");
//         print(list!.children);
//         for(var e in list.children){
//           print(e.text);
//         }
//
//
//       },
//       style: ElevatedButton.styleFrom(
//         backgroundColor: Color.fromARGB(255, 172, 207, 236), // Set button color
//       ),
//       child: Text(year),
//     );
//   }
// }

class GSSOCScreen extends StatefulWidget {
  const GSSOCScreen({super.key});

  @override
  State<GSSOCScreen> createState() => _GSSOCScreenState();
}

class _GSSOCScreenState extends State<GSSOCScreen> {

  List<Widget> widgetList = [];

  Widget YearButton(String year){
    return ElevatedButton(
        onPressed: (){
          String html = DataService.data["GirlScriptSummerOfCode"]![year].toString();
          print(html);
          BeautifulSoup beautifulSoup = BeautifulSoup(html);
          final list = beautifulSoup.find("div",class_: "flex flex-row justify-center flex-wrap items-center gap-x-10 gap-y-10 mt-9");
          print(list!.children);
          List<Widget> temp = [];
          for(var e in list.children){
            String projectName = e.find("div",class_: "font-bold text-primary_orange-0 md:text-xl")!.a!.text;
            String projectLink = e.find("div",class_: "font-bold text-primary_orange-0 md:text-xl")!.a!["href"].toString();
            String projectOwner = e.find("div",class_: "mb-3 text-sm dark:text-white md:text-md md:mb-4")!.text;
            List<String> tags = e.findAll("button",class_: "bg-orange-50 dark:hover:bg-slate-700 dark:bg-stone-800 rounded-2xl w-full py-1 text-orange-600 drop-shadow-md font-semibold").map((e) => e.text).toList();
            temp.add(getProjectCard(context, projectName, projectLink, tags, projectOwner));
          }
          setState(() {
            widgetList = temp;
          });
        },
        child: Text(year),
      style: ElevatedButton.styleFrom(
        backgroundColor: Color.fromARGB(255, 172, 207, 236), // Set button color
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Girl Script Summer of Code'),
        actions: [
          IconButton(onPressed: (){
            Navigator.push(context, MaterialPageRoute(builder: (context){
              return WebviewScreen("https://gssoc.girlscript.tech/");
            }));
          }, icon: Icon(Icons.link))
        ],
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        physics: NeverScrollableScrollPhysics(),
        child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                child: TextField(
                  decoration: InputDecoration(
                    hintText: 'Search',
                    prefixIcon: Icon(Icons.search),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30.0),
                    ),
                    contentPadding: EdgeInsets.symmetric(vertical: 12.0, horizontal: 20.0),
                  ),
                  onChanged: (value) {
                    // Handle search input
                  },
                ),
              ),
              SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  YearButton(
                    '2021'
                    //url: 'https://gssoc.girlscript.tech/project', // Replace with actual URL
                  ),
                  YearButton(
                    '2022'
                    //url: 'https://gssoc.girlscript.tech/project', // Replace with actual URL
                  ),
                ],
              ),
              SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  YearButton(
                    '2023'
                    //url: 'https://gssoc.girlscript.tech/project', // Replace with actual URL
                  ),
                  YearButton(
                    '2024'
                    //url: 'https://gssoc.girlscript.tech/project', // Replace with actual URL
                  ),
                ],
              ),
              SizedBox(height: 20),
              // ElevatedButton(
              //   onPressed: () {
              //     // launch('https://example.com/projects'); // Replace with actual URL
              //   },
              //   style: ElevatedButton.styleFrom(
              //     backgroundColor: Color.fromARGB(255, 226, 230, 120), // Set button color
              //     padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 30.0),
              //   ),
              //   child: Text('View Projects'),
              // ),

              Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height,
                child: ListView.builder(
                  shrinkWrap: true,
                  scrollDirection: Axis.vertical,
                  physics: AlwaysScrollableScrollPhysics(),
                  itemCount: widgetList.length,
                  itemBuilder: (context,index){
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: widgetList[index],
                    );
                }
                ),
              ),
            ],
          ),
      ),
      );
  }
}


void main() {
  runApp(MaterialApp(
    home: GSSOCScreen(),
  ));
}


