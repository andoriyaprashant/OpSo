import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ProgramOption extends StatelessWidget {
  final String title;
  final String imageAssetPath;
  final VoidCallback onTap;

  const ProgramOption({
    super.key,
    required this.title,
    required this.imageAssetPath,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    final borderColor = isDarkMode ? Colors.white : Colors.black45;
    return Column(
      children: [
        GestureDetector(
          onTap: onTap,
          child: Container(
            padding: EdgeInsets.all(ScreenUtil().setWidth(20)),
            decoration: BoxDecoration(
              // color: const Color.fromARGB(255, 237, 237, 239),
              borderRadius: BorderRadius.circular(15),
              border: Border.all(
                width: 1,
                color: borderColor,
              ),
            ),
            child: Row(
              children: [
                Image.asset(
                  imageAssetPath,
                  width: ScreenUtil().setWidth(50),
                  height: ScreenUtil().setHeight(50),
                ),
                SizedBox(width: ScreenUtil().setWidth(20)),
                Expanded(
                  child: Text(
                    title,
                    style: TextStyle(
                      fontSize: ScreenUtil().setSp(18),
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                const Icon(Icons.arrow_forward),
              ],
            ),
          ),
        ),
        SizedBox(height: ScreenUtil().setHeight(20)),
      ],
    );
  }
}
