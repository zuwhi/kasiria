import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomTextWidget extends StatelessWidget {
  final String text;
  final double fontSize;
  final FontWeight fontWeight;
  final Color color;
  final bool isUnderlined;
  final Color? underlineColor;

  const CustomTextWidget({
    super.key,
    required this.text,
    this.fontSize = 16.0,
    this.fontWeight = FontWeight.w400,
    this.color = Colors.black,
    this.isUnderlined = false,
    this.underlineColor = Colors.black,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: GoogleFonts.poppins(
        
        fontSize: fontSize,
        fontWeight: fontWeight,
        color: color,
        decoration: isUnderlined ? TextDecoration.underline : TextDecoration.none,
        decorationColor: isUnderlined ? underlineColor : null, 
        decorationStyle: TextDecorationStyle.solid,
        decorationThickness: 2
      ),
    );
  }
}
