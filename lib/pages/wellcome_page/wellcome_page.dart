import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:home_elite/pages/signUp_page/signup_cubit/signupPage.dart';
import 'package:home_elite/pages/wellcome_page/welcome_cubit.dart';
import 'package:home_elite/pages/wellcome_page/welcome_state.dart';

import '../../services/navigation_service.dart';

class WellComePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final deviceWidth = MediaQuery.of(context).size.width;
    final deviceHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: BlocProvider(
        create: (context) => GoogleSignUpCubit(),
        child: SafeArea(
          child: Stack(
            children: [
              Image.asset(
                "assets/images/image.jpg",
                fit: BoxFit.fill,
                height: deviceHeight,
                width: deviceWidth,
              ),
              Padding(
                padding: EdgeInsets.only(),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Image.asset("assets/images/logo.png",
                        width: 230, height: 230),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          height: 81,
                          width: 5,
                          decoration: BoxDecoration(color: Color(0xff9D7D43)),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 14.0),
                          child:  Text(
                            "Get your Home in \n  just few clicks.",
                            style: GoogleFonts.alegreyaSansSc(
                              textStyle: TextStyle(fontSize: 20),
                            ),
                          ),
                        ),
                      ],
                    ),
                    // Padding(
                    //   padding: const EdgeInsets.only(bottom: 12),
                    //   child: Text(
                    //     "Get your Home in \n  just few clicks.",
                    //     style: GoogleFonts.alegreyaSansSc(
                    //       textStyle: TextStyle(fontSize: 20),
                    //     ),
                    //   ),
                    // ),

                    BlocConsumer<GoogleSignUpCubit, GoogleSignUpState>(
                      listener: (context, state) {
                        if (state is GoogleSignUpSuccess) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                                backgroundColor: Colors.green,
                                content: Text('Sign-Up Successful!')

                            ),
                          );
                          print("========================Sign Up with google done ======================");
                          print(state.token);

                          Navigator.pushReplacementNamed(context, "/home");
                        } else if (state is GoogleSignUpError) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                                backgroundColor: Colors.red,
                                content: Text(state.error)),
                          );
                          print(state.error);
                        }
                      },
                      builder: (context, state) {
                        var cubit = GoogleSignUpCubit.get(context);
                        if (state is GoogleSignUpLoading) {
                          return Center(child: CircularProgressIndicator());
                        }
                        return Padding(
                          padding: EdgeInsets.only(bottom: 12, top: 30),
                          child: SizedBox(
                            width: 300,
                            height: 59,
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                padding: EdgeInsets.symmetric(
                                    horizontal: 20, vertical: 15),
                                shape: RoundedRectangleBorder(
                                  side: BorderSide(color: Color(0xff9D7D43)),
                                  borderRadius: BorderRadius.circular(12),
                                ),
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Image.asset("assets/images/gmail.png"),
                                  SizedBox(
                                    width: 20,
                                  ),
                                  Text(
                                    "Sign Up With Gmail",
                                    style: GoogleFonts.alegreyaSansSc(
                                        textStyle: TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.black)),
                                  )
                                ],
                              ),
                              onPressed: () {
                                cubit.signUpWithGoogle();

                              },
                            ),
                          ),
                        );
                      },
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: 20),
                      child: SizedBox(
                        width: 300,
                        height: 59,
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
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Image.asset(
                                "assets/images/image3.png",
                                width: 40,
                                height: 45,
                              ),
                              SizedBox(
                                width: 13,
                              ),
                              Text(
                                "Sign Up With Email",
                                style: GoogleFonts.alegreyaSansSc(
                                    textStyle: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w400,
                                        color: Colors.white)),
                              )
                            ],
                          ),
                          onPressed: () {
                            Navigator.pushNamed(context, '/signup');
                          },
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 18),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Already have account? ",
                            style: TextStyle(
                              color: Colors.grey,
                              fontWeight: FontWeight.bold,

                            ),
                          ),
                          InkWell(
                            onTap: (){
                              Navigator.pushReplacementNamed(
                                  context, '/login');
                            },
                            child: Text(
                              "Login",
                              style: TextStyle(
                                  color: Color(0xff9D7D43), fontSize: 13),
                            ),
                          )
                        ],
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
