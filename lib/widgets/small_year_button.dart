import 'package:flutter/material.dart';

class YearButton extends StatelessWidget {
  final String year;
  final Function()? onTap;
  final Color backgroundColor;
  final double fontSize;
  final Color fontColor;
  final bool isEnabled;
  final Color selectedFontColor;

  const YearButton({
    Key? key,
    required this.year,
    required this.isEnabled,
    this.onTap,
    this.backgroundColor = Colors.orange,
    this.fontSize = 20,
    this.fontColor = Colors.white,
    this.selectedFontColor = Colors.orange,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onTap,
      style: ElevatedButton.styleFrom(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
          side: const BorderSide(
            color: Color.fromRGBO(255, 183, 77, 1),
          ),
        ),
        backgroundColor: backgroundColor,
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      ),
      child: FittedBox( 
        fit: BoxFit.scaleDown, 
        child: Text(
          year,
          style: TextStyle(
            fontSize: fontSize,
            color: isEnabled ? selectedFontColor : fontColor,
            fontWeight: FontWeight.bold, 
          ),
        ),
      ),
    );
  }
}
