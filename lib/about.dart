import 'package:flutter/material.dart';
import 'package:url_launcher/link.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AboutScreen  extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(
      context,
    );
    return Scaffold(
      appBar: AppBar(
         leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios),
         
          onPressed: () => Navigator.of(context).pop(),
        ),
        centerTitle: true,
        title: Text('About App'),
      ),
      body: Padding(
        padding: EdgeInsets.fromLTRB(
          ScreenUtil().setWidth(50),
          ScreenUtil().setWidth(0),
          ScreenUtil().setWidth(40),
          ScreenUtil().setWidth(70),
        ),
        // const EdgeInsets.fromLTRB(50, 0, 40, 70),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Image
            Image.asset(
              'assets/OpSo_about.png',
              width: ScreenUtil().setWidth(250),
              height: ScreenUtil().setHeight(250),
              fit: BoxFit.contain,
            ),
            SizedBox(height: ScreenUtil().setHeight(05)),
            // Version
            Text(
              'Version 1.0.0',
              style: TextStyle(fontSize: ScreenUtil().setSp(16)),
            ),
            SizedBox(height: ScreenUtil().setHeight(10)),
            // App Description
            Text(
              'OpSo',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: ScreenUtil().setSp(16)),
            ),
            SizedBox(height: ScreenUtil().setHeight(20)),
            // GitHub Button
            Link(
              uri: Uri.parse('https://github.com/andoriyaprashant/OpSo'),
              target: LinkTarget.self,
              builder: (context, followlink) => ElevatedButton.icon(
                onPressed: followlink,
                icon: Icon(Icons.code),
                label: Text('GitHub'),
              ),
            ),
            SizedBox(height: ScreenUtil().setHeight(10)),

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
    );
  }
}
