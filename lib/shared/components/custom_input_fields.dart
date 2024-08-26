import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomTextField extends StatelessWidget {
  final String label;
  final bool obscureText;
  final Function(String) onChanged;
  final String? Function(String?) validator;
  final double? width;
  final double? height;

  const CustomTextField({
    Key? key,
    required this.label,
    this.obscureText = false,
    required this.onChanged,
    required this.validator,
    this.width, // Custom width
    this.height, // Custom height
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: GoogleFonts.alegreyaSansSc(
              textStyle: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 0, right: 25),
            child: SizedBox(
              width: 331, // Default to full width if not provided
              height: 42, // Height is now customizable
              child: TextFormField(
                obscureText: obscureText,
                cursorColor: Colors.brown,
                style: TextStyle(
                  fontSize: 14,
                ),
                textAlignVertical: TextAlignVertical.center,
                decoration: InputDecoration(
                  contentPadding: EdgeInsets.only(left: 12),
                  fillColor: Colors.white,
                  filled: true,
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.brown),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.brown, width: 2.0),
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                onChanged: onChanged,
                validator: validator,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
