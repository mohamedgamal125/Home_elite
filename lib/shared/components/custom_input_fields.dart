import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:home_elite/Theming/myTheme_data.dart';

class CustomTextField extends StatelessWidget {
  final String label;
  final bool obscureText;
  final Function(String) onChanged;
  final String? Function(String?) validator;
  final double? width;
  final double? height;
  final String? rgx;

  const CustomTextField({
    Key? key,
    required this.label,
    this.obscureText = false,
    required this.onChanged,
    required this.validator,
    this.width,
    this.height,
    this.rgx,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(right: 28),
            child: Text(
              label,
              style: GoogleFonts.alegreyaSansSc(
                textStyle: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 0, right: 25),
            child: SizedBox(
              width: width ?? 331,
              child: Column(
                children: [
                  SizedBox(
                    height: height ?? 50, // Set constant height for the field
                    child: TextFormField(
                      obscureText: obscureText,
                      cursorColor:MyColor.myDark,
                      style: TextStyle(fontSize: 14),
                      textAlignVertical: TextAlignVertical.center,
                      decoration: InputDecoration(
                        contentPadding: EdgeInsets.only(left: 12, top: 12, bottom: 12),
                        fillColor: Colors.white,
                        filled: true,
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: MyColor.myDark),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: MyColor.myDark, width: 2.0),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        errorBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.red),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        focusedErrorBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.red, width: 2.0),
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      onChanged: onChanged,
                      validator: validator,
                    ),
                  ),
                  // Add space for error text to prevent layout shift
                  const SizedBox(height: 16), // Adjust this value based on error text height
                  // The error message will show up here without affecting field size
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
