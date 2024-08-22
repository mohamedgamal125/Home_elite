import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl_phone_field/intl_phone_field.dart';

class SignupPage2 extends StatelessWidget {
  const SignupPage2({super.key});

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
                padding: EdgeInsets.only(top: 50, left: 36),
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
                      padding: EdgeInsets.only(right: 12,top: 30),
                      child: IntlPhoneField(
                        decoration: InputDecoration(
                          focusColor: Colors.brown,
                          labelText: 'Phone Number',
                          border: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Colors.brown
                            ),
                          ),
                        ),
                        initialCountryCode: 'EG',
                        onChanged: (phone) {
                          print(phone.completeNumber);
                        },
                      ),
                    ),
          
                    Padding(
                      padding: const EdgeInsets.only(top: 28,right: 12),
                      child: Text("Please verify your phone to protect your account. Enter the verification code sent to your mobile number to ensure your account remains secure. This verification step helps us confirm your identity and prevent unauthorized access. If you did not request this verification, please contact our support team immediately. Remember, do not share this code with anyone.",style: TextStyle(color:Colors.grey,fontSize: 10),),
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
                            "Verification code",
                            style: GoogleFonts.alegreyaSansSc(
                                textStyle: TextStyle(
                                    color: Colors.white, fontSize: 16)),
                          ),
                        ),
                        onPressed: () {
                          Navigator.pushNamed(context, "/signupVerification");
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
