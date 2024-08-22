import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomButton extends StatelessWidget {

  final double width;
  final double height;
  final String buttonText;
  final Color buttonColor;


  CustomButton({
   required this.width,
    required this.height,
    required  this.buttonText,
    required this.buttonColor
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      height: height,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: Color(0xff9D7D43),
          padding: EdgeInsets.symmetric(
              horizontal: 20, vertical: 15),
          shape: RoundedRectangleBorder(
            side: BorderSide(
                color: Color(0xff9D7D43)
            ),
            borderRadius: BorderRadius.circular(12),
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset("assets/images/image3.png",width: 40,height: 45,),
            SizedBox(width: 13,),
            Text("Sign Up With Email",style: GoogleFonts.alegreyaSansSc(
                textStyle: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w400,
                    color: Colors.white
                )
            ),)
          ],
        ),
        onPressed: () {},
      ),
    );
  }
}
