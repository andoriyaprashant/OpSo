// import 'package:flutter/material.dart';
// import 'package:http/http.dart' as http;
// import 'package:html/parser.dart' as parser;
// import 'package:html/dom.dart' as dom;

// class Article {
//   final String url;
//   final String title;
//   final String urlImage;

//   const Article({
//     required this.url,
//     required this.title,
//     required this.urlImage,
//   });
// }

// class GoogleSummerOfCodeScreen extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     Future<void> getWebsiteData() async {
//       final url = Uri.parse("https://summerofcode.withgoogle.com/programs/2023/organizations");
//       final response = await http.get(url);
//       dom.Document html = dom.Document.html(response.body);

//       final titles =html 
//       .querySelectorAll('h2 > a > span')
//       .map((element) => element.innerHtml.trim())
//       .toList();
      
//       // if (response.statusCode == 200) {
//       //   final document = parser.parse(response.body);
//       //   final titles = document.querySelectorAll('.organization-card__name');

//         print('Count: ${titles.length}');
//         // for (final title in titles) {
//         //   debugPrint(title);

//         setState(() {
//           articles = List.generate(titles.length, (index) => Article(
//            title: titles[index],
//             url: '',
//             urlImage: '',
//   ),
//   );    
//   });
// }
    
//     getWebsiteData(); // Call the function to fetch data
    
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Google Summer of Code'),
//       ),
//     //   body: Center(
//     //     child: Text('Fetching data from website...'),
//     //   ),
//     // );
//     body:  ListView.builder(padding: const EdgeInsets.all(12),
//     itemCount:  articles.lenght,
//     itemBuilder:  (context,index) {
//       final article = articles[index];
      
//     },
//     ),
//   }
// }


// import 'package:flutter/material.dart';
// import 'package:http/http.dart' as http;
// import 'package:html/parser.dart' as parser;
// import 'package:html/dom.dart' as dom;

// class GoogleSummerOfCodeScreen extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Google Summer of Code'),
//       ),
//       body: FutureBuilder(
//         future: getWebsiteData(),
//         builder: (context, snapshot) {
//           if (snapshot.connectionState == ConnectionState.waiting) {
//             return Center(
//               child: CircularProgressIndicator(),
//             );
//           } else if (snapshot.hasError) {
//             return Center(
//               child: Text('Error: ${snapshot.error}'),
//             );
//           } else if (snapshot.hasData) {
//             List<String>? organizations = snapshot.data;
//             return ListView.builder(
//               itemCount: organizations?.length,
//               itemBuilder: (context, index) {
//                 return ListTile(
//                   title: Text(organizations![index]),
//                 );
//               },
//             );
//           } else {
//             return Center(
//               child: Text('No data available'),
//             );
//           }
//         },
//       ),
//     );
//   }

//   Future<List<String>> getWebsiteData() async {
//     final url = Uri.parse("https://summerofcode.withgoogle.com/programs/2023/organizations");
//     final response = await http.get(url);

//     if (response.statusCode == 200) {
//       final document = parser.parse(response.body);
//       final titles = document.querySelectorAll('.organization-card__name');

//       List<String> organizations = [];
//       for (final title in titles) {
//         organizations.add(title.text);
//       }

//       return organizations;
//     } else {
//       throw Exception('Failed to fetch data');
//     }
//   }
// }


// import 'package:flutter/material.dart';
// import 'package:http/http.dart' as http;
// import 'package:html/parser.dart' as parser;
// import 'package:html/dom.dart' as dom;

// class GoogleSummerOfCodeScreen extends StatefulWidget {
//   @override
//   _GoogleSummerOfCodeScreenState createState() => _GoogleSummerOfCodeScreenState();
// }

// class _GoogleSummerOfCodeScreenState extends State<GoogleSummerOfCodeScreen> {
//   late List<String> organizationNames;

//   @override
//   void initState() {
//     super.initState();
//     fetchOrganizations();
//   }

//   Future<void> fetchOrganizations() async {
//     final url = Uri.parse("https://summerofcode.withgoogle.com/programs/2023/organizations");
//     final response = await http.get(url);

//     if (response.statusCode == 200) {
//       final document = parser.parse(response.body);
//       final elements = document.querySelectorAll('.organization-card__name');

//       setState(() {
//         organizationNames = elements.map((element) => element.text.trim()).toList();
//       });
//     } else {
//       // Handle error, e.g., show error message
//       print("Failed to fetch organizations: ${response.statusCode}");
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Google Summer of Code'),
//       ),
//       body: organizationNames == null
//           ? Center(
//               child: CircularProgressIndicator(),
//             )
//           : ListView.builder(
//               itemCount: organizationNames.length,
//               itemBuilder: (context, index) {
//                 return ListTile(
//                   title: Text(organizationNames[index]),
//                 );
//               },
//             ),
//     );
//   }
// }

// import 'package:flutter/material.dart';
// import 'package:http/http.dart' as http;
// import 'package:html/parser.dart' as parser;
// import 'package:html/dom.dart' as dom;

// class GoogleSummerOfCodeScreen extends StatefulWidget {
//   @override
//   _GoogleSummerOfCodeScreenState createState() => _GoogleSummerOfCodeScreenState();
// }

// class _GoogleSummerOfCodeScreenState extends State<GoogleSummerOfCodeScreen> {
//   late List<String> organizationNames = [];

//   @override
//   void initState() {
//     super.initState();
//     fetchOrganizations();
//   }

//   Future<void> fetchOrganizations() async {
//     try {
//       final url = Uri.parse("https://summerofcode.withgoogle.com/programs/2023/organizations");
//       final response = await http.get(url);

//       if (response.statusCode == 200) {
//         final document = parser.parse(response.body);
//         final elements = document.querySelectorAll('.organization-card__name');

//         setState(() {
//           organizationNames = elements.map((element) => element.text.trim()).toList();
//         });
//       } else {
//         // Handle error, e.g., show error message
//         print("Failed to fetch organizations: ${response.statusCode}");
//       }
//     } catch (e) {
//       // Handle other exceptions, e.g., network errors
//       print("Error fetching organizations: $e");
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Google Summer of Code'),
//       ),
//       body: organizationNames.isEmpty
//           ? Center(
//               child: CircularProgressIndicator(),
//             )
//           : ListView.builder(
//               itemCount: organizationNames.length,
//               itemBuilder: (context, index) {
//                 return ListTile(
//                   title: Text(organizationNames[index]),
//                 );
//               },
//             ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:html/parser.dart' as parser;

class GoogleSummerOfCodeScreen extends StatefulWidget {
  const GoogleSummerOfCodeScreen ({super.key});

  @override
  _GoogleSummerOfCodeScreen createState() => _GoogleSummerOfCodeScreen();
}

class _GoogleSummerOfCodeScreen extends State<GoogleSummerOfCodeScreen > {
bool isLoading = false;
late List<String> blogs = [];

Future<List<String>> extractData() async{
   List<String>titles = [];
   final response = await http.Client().get(Uri.parse('https://summerofcode.withgoogle.com/programs/2024/organizations'));
   if(response.statusCode==200) {
    var doc = parser.parse(response.body);
    try{
      for(int i=0; i<15; i++){
        if(i==3 || i==2) continue;

        var respl = doc.getElementsByClassName('org list')[0]
        .children[i]
        .children[0]
        .children[0];

        titles.add(respl.text.toString());
      }
      return titles;

    }catch(e) {
      return ['error'];
    }
   }else{
    return['error'];
   }
}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Gsoc'),
      ),
      body: Center(
        child: Padding(padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            ElevatedButton(onPressed: ()async{
             setState(() {
               isLoading = true;
             });
             blogs = await extractData();
             setState(() {
               isLoading = false;
             });
            }, child: Text('Org data'),), isLoading
            ? CircularProgressIndicator() : Expanded(child: ListView.builder(itemCount: blogs.length
            ,itemBuilder: (BuildContext context, int index){
              return Material(
                elevation: 20,
                child: Padding(padding: const EdgeInsets.fromLTRB(5, 10, 5, 10),
                child: Text(blogs[index].toString()),
                ),
                );
              
            } ))


          ],
        ),
        )
      ),
    );
  }
}