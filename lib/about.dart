import 'package:flutter/material.dart';
import 'package:url_launcher/link.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AboutScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(
      context,
    );return Scaffold(
      appBar: AppBar(
        title: Text('About App'),
      ),
      body: SingleChildScrollView( // This allows the content to scroll
        child: Padding(
          padding: EdgeInsets.fromLTRB(
            ScreenUtil().setWidth(50),
            ScreenUtil().setWidth(0),
            ScreenUtil().setWidth(40),
            ScreenUtil().setWidth(70),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [

                  Image.asset(
                    'assets/OpSo_about.png',
                    width: ScreenUtil().setWidth(150),
                    height: ScreenUtil().setHeight(150),
                    fit: BoxFit.contain,
                  ),
                  SizedBox(width: ScreenUtil().setWidth(10)),

                  Text(
                    'Version 1.0.0',
                    style: TextStyle(fontSize: ScreenUtil().setSp(12)),
                  ),



              SizedBox(height: ScreenUtil().setHeight(20)),


              Link(
                uri: Uri.parse('https://github.com/andoriyaprashant/OpSo'),
                target: LinkTarget.self,
                builder: (context, followlink) => ElevatedButton.icon(
                  onPressed: followlink,
                  icon: Icon(Icons.code),
                  label: Text('GitHub'),
                ),
              ),

              SizedBox(height: ScreenUtil().setHeight(30)),


              Text(
                'About OpSo',
                style: TextStyle(
                  fontSize: ScreenUtil().setSp(20),
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: ScreenUtil().setHeight(10)),


              Text(
                "OpSo is a comprehensive platform designed to help individuals explore various open-source programs, such as Google Summer of Code, Summer of Bitcoin, and Linux Foundation. Our goal is to provide easy access to information about these programs, including eligibility criteria, important resources, and guidance on how to participate. Whether you're a beginner or an experienced open-source contributor, OpSo is your go-to app for discovering new opportunities and staying informed about the open-source world.",
                textAlign: TextAlign.start,
                style: TextStyle(fontSize: ScreenUtil().setSp(12)),
              ),
              // Link(
              //   uri: Uri.parse('https://gssoc.girlscript.tech/'),
              //   target: LinkTarget.self,
              //   builder: (context, followlink) => ElevatedButton.icon(
              //     onPressed: followlink,
              //     icon: Icon(Icons.link),
              //     label: Text('Gssoc Website'),
              //   ),
              // ),
            ],
          ),
        ),
      ),
    );

  }
}
