import 'package:flutter/material.dart';
import 'package:opso/programs%20screen/gsoc_screen.dart';
import 'package:opso/services/notificationService.dart';
import 'home_page.dart';


void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await NotificationService.initialNotification();
  runApp(OpSoApp());
}


class OpSoApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'OpSo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,

      ),
      home: HomePage(),
    );
  }
}


