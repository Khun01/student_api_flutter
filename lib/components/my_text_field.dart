import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class MyTextField extends StatefulWidget {
  final String hintText;
  final Icon icon;
  final ValueChanged<String> onChanged;

  const MyTextField({
    super.key,
    required this.hintText,
    required this.icon,
    required this.onChanged,
  });

  @override
  State<MyTextField> createState() => _MyTextFieldState();
}

class _MyTextFieldState extends State<MyTextField> {
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      onChanged: (value){
        widget.onChanged(value);
      },
      decoration: InputDecoration(
        hintText: widget.hintText,
        hintStyle: GoogleFonts.nunito(
          color: Colors.black.withOpacity(0.5)
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(50),
        ),
        focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(50)),
        prefixIcon: widget.icon,
      ),
    );
  }
}
