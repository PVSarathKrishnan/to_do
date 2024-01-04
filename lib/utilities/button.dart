import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class MyButton extends StatelessWidget {
  final String text;
  VoidCallback onPressed;
  MyButton({super.key, required this.text, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      onPressed: onPressed,
      color: Color.fromARGB(255, 255, 255, 255).withOpacity(.9),
      child: Text(text,style: GoogleFonts.josefinSans(fontWeight: FontWeight.bold),),
    );
  }
}
