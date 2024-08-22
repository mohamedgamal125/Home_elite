import 'package:flutter/material.dart';
import 'package:flutter_otp_text_field/flutter_otp_text_field.dart';
import 'package:google_fonts/google_fonts.dart';


class SignupVerification extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    final deviceWidth = MediaQuery.of(context).size.width;
    final deviceHeight = MediaQuery.of(context).size.height;
    return Scaffold(

      appBar: AppBar(
        automaticallyImplyLeading: false,

        title: Padding(
          padding:  EdgeInsets.only(left: 18),
          child: GestureDetector(
              onTap: (){
                Navigator.pop(context);
              },
              child: Image.asset("assets/images/arrow_back.png",width: 35,)),
        ),

      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Stack(
            children: [
              Image.asset(
                "assets/images/image.jpg",
                fit: BoxFit.fill,
                height: deviceHeight,
                width: deviceWidth,
              ),
              Padding(
                padding: EdgeInsets.only(top: 120, left: 36),
                child: Column(
                  children: [
                    Row(
                      children: [
                        Container(
                          height: 40,
                          width: 6,
                          decoration: BoxDecoration(color: Color(0xff9D7D43)),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 14.0),
                          child: Text(
                            "Sign up",
                            style: GoogleFonts.alegreyaSansSc(
                                textStyle: TextStyle(
                                    fontSize: 30,
                                    fontWeight: FontWeight.w400,
                                    color: Color(0xff263A27))),
                          ),
                        )
                      ],
                    ),

                    Padding(
                      padding: const EdgeInsets.only(top: 39),
                      child: Text("Check your SMS , because we sent verification code to confirm your account",style: TextStyle(
                        fontWeight: FontWeight.w100,

                      ),),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 39,right: 100),
                      child: Text("Verification code",style: GoogleFonts.alegreyaSansSc(textStyle: TextStyle(
                        fontSize: 22
                      )),),
                    ),

                    Padding(
                      padding: const EdgeInsets.only(top:18,right: 26),
                      child: OtpTextField(
                        numberOfFields: 6,
                        borderColor: Colors.brown,
                        fillColor: Colors.white,
                        filled: true,
                        cursorColor: Colors.brown,
                        enabledBorderColor: Colors.brown,
                        disabledBorderColor: Colors.brown,
                        enabled: true,

                      ),
                    ),

                    Container(
                      margin: EdgeInsets.only(top: 35,right: 20),
                      width: 300,
                      height: 53,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Color(0xff9D7D43),
                          padding: EdgeInsets.symmetric(
                              horizontal: 20, vertical: 15),
                          shape: RoundedRectangleBorder(
                            side: BorderSide(color: Color(0xff9D7D43)),
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                        child: Center(
                          child: Text(
                            "Verify",
                            style: GoogleFonts.alegreyaSansSc(
                                textStyle: TextStyle(
                                    color: Colors.white, fontSize: 16)),
                          ),
                        ),
                        onPressed: () {
                          Navigator.pushReplacementNamed(context, "/login");

                        },
                      ),
                    ),


                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
