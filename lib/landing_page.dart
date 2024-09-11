// import 'package:flutter/material.dart';
// import 'package:animated_text_kit/animated_text_kit.dart';
// import 'package:opso/home_page.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';

// class LandingPage extends StatefulWidget {
//   const LandingPage({super.key});

//   @override
//   State<LandingPage> createState() => _LandingPageState();
// }

// class _LandingPageState extends State<LandingPage> {
//   @override
//   Widget build(BuildContext context) {
//     ScreenUtilInit(
//       designSize: Size(360, 690),
//     );
//     // double width = MediaQuery.of(context).size.width;
//     // double height = MediaQuery.of(context).size.height;
//     return Scaffold(
//       body: SingleChildScrollView(
//         child: Padding(
//           padding: const EdgeInsets.all(20),
//           child: Container(
//             child: Column(
//               children: [
//                 Center(
//                   child: Container(
//                     width: 360.w,
//                     height: (690.h) / 2,
//                     decoration: const BoxDecoration(
//                       image: DecorationImage(
//                           image: AssetImage("assets/landing.webp"),
//                           fit: BoxFit.contain),
//                     ),
//                   ),
//                 ),
//                 Center(
//                   child: SizedBox(
//                     child: DefaultTextStyle(
//                       style: TextStyle(
//                         fontSize: 50.sp,
//                       ),
//                       child: AnimatedTextKit(
//                         animatedTexts: [
//                           ColorizeAnimatedText(
//                             'Unlock your potential',
//                             textStyle: TextStyle(
//                                 fontSize: 20.sp, fontWeight: FontWeight.w700),
//                             colors: [
//                               const Color.fromRGBO(255, 183, 77, 1),
//                               const Color.fromARGB(255, 231, 225, 208)
//                             ],
//                           ),
//                         ],
//                         isRepeatingAnimation: true,
//                       ),
//                     ),
//                   ),
//                 ),
//                 const Padding(padding: EdgeInsets.only(top: 20)),
//                 Center(
//                   child: SizedBox(
//                     child: Text(
//                       "Contribute to Open Source",
//                       style: TextStyle(
//                           fontWeight: FontWeight.w400, fontSize: 20.sp),
//                     ),
//                   ),
//                 ),
//                 const Padding(padding: EdgeInsets.only(top: 30)),
//                 Center(
//                   child: SizedBox(
//                     width: 250.w,
//                     height: 60.h,
//                     child: ElevatedButton(
//                       style: ElevatedButton.styleFrom(
//                           backgroundColor:
//                               const Color.fromRGBO(255, 183, 77, 1),
//                           shape: const RoundedRectangleBorder(
//                             borderRadius: BorderRadius.all(Radius.circular(20)),
//                           )),
//                       onPressed: () {
//                         Navigator.push(
//                             context,
//                             MaterialPageRoute(
//                                 builder: (context) => HomePage()));
//                       },
//                       child: Text(
//                         "Get started",
//                         style: TextStyle(
//                             color: Colors.white,
//                             fontSize: (MediaQuery.of(context).size.width <
//                                     MediaQuery.of(context).size.height)
//                                 ? 19.sp
//                                 : 19.sh),
//                       ),
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }
