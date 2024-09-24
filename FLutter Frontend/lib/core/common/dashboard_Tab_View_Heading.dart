import 'package:final_assignment/core/common/colors.dart';
import 'package:flutter/material.dart';

class DashboardTabViewHeading extends StatelessWidget {
  final String text;
  final Color textColor;
  final double fontSize;
  final FontWeight fontWeight;
  final Color shadowColor;
  
  const DashboardTabViewHeading({
    super.key,
    required this.text,
    this.textColor = Colors.black,
    this.fontSize = 25,
    this.fontWeight = FontWeight.bold,
    this.shadowColor = goldColor, // Default shadow color
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(
        color: textColor,
        fontWeight: fontWeight,
        fontSize: fontSize,
        shadows: [
          Shadow(
            offset: const Offset(2.0, 2.0),
            blurRadius: 3.0,
            color: shadowColor,
          ),
        ],
      ),
    );
  }
}
