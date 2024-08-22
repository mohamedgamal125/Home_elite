import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:home_elite/pages/signUp_page/signupPage.dart';
import 'package:home_elite/pages/wellcome_page/welcome_cubit.dart';
import 'package:home_elite/pages/wellcome_page/welcome_state.dart';

import '../../services/navigation_service.dart';

class WellComePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final deviceWidth = MediaQuery.of(context).size.width;
    final deviceHeight = MediaQuery.of(context).size.height;
    final _navigation = NavigationService();
    return Scaffold(
      body: BlocProvider(
        create: (context) => GoogleSignUpCubit(Dio()),
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
                padding: EdgeInsets.all(32),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Image.asset("assets/images/logo.png",
                        width: 275, height: 275),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 12),
                      child: Text(
                        "Get your Home in \n  just few clicks.",
                        style: GoogleFonts.alegreyaSansSc(
                          textStyle: TextStyle(fontSize: 20),
                        ),
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          margin: EdgeInsets.only(left: 30),
                          width: 15,
                          height: 15,
                          decoration: BoxDecoration(
                              color: Color(0xff9D7D43),
                              borderRadius: BorderRadius.circular(100)),
                        ),
                        Expanded(
                          child: Divider(
                            thickness: 2,
                            height: 2,
                            indent: 0,
                            endIndent: 30,
                            color: Color(0xff9D7D43),
                          ),
                        ),
                      ],
                    ),
                    BlocConsumer<GoogleSignUpCubit, GoogleSignUpState>(
                      listener: (context, state) {
                        // TODO: implement listener
                        if (state is GoogleSignUpSuccess) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text('Sign-Up Successful! Token: ${state.token}')),
                          );
                          print("========================Sign Up with google done ======================");
                          print(state.token);
                        } else if (state is GoogleSignUpFailure) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text('Sign-Up Failed: ${state.errorMessage}')),
                          );
                          print(state.errorMessage);
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
                                            fontWeight: FontWeight.w100,
                                            color: Colors.black)),
                                  )
                                ],
                              ),
                              onPressed: () {
                                print("before signup ");
                                cubit.signUpWithGoogle();

                                print("after signup");
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
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: EdgeInsets.only(top: 22, left: 6),
                          child: Text(
                            "Already have account? ",
                            style: TextStyle(
                              color: Colors.grey,
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(top: 10),
                          child: TextButton(
                              onPressed: () {
                                Navigator.pushReplacementNamed(
                                    context, '/login');
                              },
                              child: Text(
                                "Login",
                                style: TextStyle(
                                    color: Color(0xff9D7D43), fontSize: 12),
                              )),
                        )
                      ],
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
