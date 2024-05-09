// ignore_for_file: use_key_in_widget_constructors, prefer_const_constructors

import "package:flutter/material.dart";

class ProgramOption extends StatelessWidget {
  final String title;
  final Widget image;
  final VoidCallback onTap;

  const ProgramOption({
    required this.title,
    required this.image,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: Color.fromARGB(255, 237, 237, 239),
          borderRadius: BorderRadius.circular(15),
        ),
        child: Row(
          children: [
            SizedBox(
              width: 60,
              height: 60,
              child: image,
            ),
            SizedBox(width: 20),
            Expanded(
              child: Text(
                title,
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Icon(Icons.arrow_forward),
          ],
        ),
      ),
    );
  }
}
