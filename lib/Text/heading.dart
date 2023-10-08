import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Modified_Text2 extends StatelessWidget {
  final String text;
  final Color color;
  final double size;
  final FontWeight fontWeight;

  const Modified_Text2({
    super.key,
    required this.text,
    required this.color,
    required this.size,
    required this.fontWeight,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: GoogleFonts.montserrat(
        color: color,
        fontSize: size,
        fontWeight: fontWeight,
      ),
    );
  }
}
