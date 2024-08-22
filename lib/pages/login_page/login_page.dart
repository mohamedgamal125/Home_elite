import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:home_elite/pages/login_page/login_cubit.dart';
import 'package:home_elite/pages/login_page/login_state.dart';

import '../../splash_screen/splash.dart';

class LoginPage extends StatelessWidget {
  var _formKey = GlobalKey<FormState>();


  @override
  Widget build(BuildContext context) {
    final deviceWidth = MediaQuery.of(context).size.width;
    final deviceHeight = MediaQuery.of(context).size.height;
    return BlocProvider(
      create: (context) => LoginCubit(Dio()),
      child: Scaffold(
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
                child: BlocConsumer<LoginCubit, LoginState>(
                  listener: (context, state) {

                    if(state is LoginSuccess)
                      {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text(state.response.message),backgroundColor: Colors.green,),
                        );
                        print(state.response);
                        Navigator.pushReplacementNamed(context, "/home");
                      }
                    else if (state is LoginFailure) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text(state.error)),
                      );

                      print("==============error==============");
                      print(state.error);
                    }
                  },
                  builder: (context, state) {
                    var cubit = LoginCubit.get(context);
                    return Column(
                      children: [
                        Row(
                          children: [
                            Container(
                              height: 40,
                              width: 6,
                              decoration:
                                  BoxDecoration(color: Color(0xff9D7D43)),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left: 14.0),
                              child: Text(
                                "Login",
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
                          padding: const EdgeInsets.only(
                              left: 15, right: 40, top: 40),
                          child: Image.asset("assets/images/logo.png"),
                        ),
                        Padding(
                          padding: EdgeInsets.only(top: 36),
                          child: Row(
                            children: [
                              Text(
                                "Email Address",
                                style: GoogleFonts.alegreyaSansSc(
                                    textStyle: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 16)),
                              ),
                              Padding(
                                padding: EdgeInsets.only(left: 5),
                                child: Text(
                                  "*",
                                  style: TextStyle(color: Colors.red),
                                ),
                              )
                            ],
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(top: 6, right: 25),
                          child: Container(
                            height: 50,
                            child: TextFormField(
                              controller: cubit.emailController,
                              cursorColor: Colors.brown,
                              cursorHeight: 26,
                              decoration: InputDecoration(
                                fillColor: Colors.white,
                                filled: true,
                                enabledBorder: OutlineInputBorder(
                                    borderSide: BorderSide(color: Colors.brown),
                                    borderRadius: BorderRadius.circular(
                                        12) // Brown border when not focused
                                    ),
                                focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        color: Colors.brown, width: 2.0),
                                    // Brown border when focused
                                    borderRadius: BorderRadius.circular(12)),
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(top: 36),
                          child: Row(
                            children: [
                              Text(
                                "Password",
                                style: GoogleFonts.alegreyaSansSc(
                                    textStyle: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 16)),
                              ),
                              Padding(
                                padding: EdgeInsets.only(left: 5),
                                child: Text(
                                  "*",
                                  style: TextStyle(color: Colors.red),
                                ),
                              )
                            ],
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(top: 6, right: 25),
                          child: Container(
                            height: 50,
                            child: TextFormField(
                              controller: cubit.passwordController,
                              obscureText: true,
                              cursorColor: Colors.brown,
                              cursorHeight: 26,
                              decoration: InputDecoration(
                                fillColor: Colors.white,
                                filled: true,
                                enabledBorder: OutlineInputBorder(
                                    borderSide: BorderSide(color: Colors.brown),
                                    borderRadius: BorderRadius.circular(
                                        12) // Brown border when not focused
                                    ),
                                focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        color: Colors.brown, width: 2.0),
                                    // Brown border when focused
                                    borderRadius: BorderRadius.circular(12)),
                              ),
                            ),
                          ),
                        ),
                        state is LoginLoading?Padding(
                          padding: const EdgeInsets.only(top: 12),
                          child: Center(child: CircularProgressIndicator(color: Colors.brown)),
                        )
                        :Container(
                          margin: EdgeInsets.only(top: 35, right: 20),
                          width: 300,
                          height: 55,
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
                                "Login",
                                style: GoogleFonts.alegreyaSansSc(
                                    textStyle: TextStyle(
                                        color: Colors.white, fontSize: 16)),
                              ),
                            ),
                            onPressed: () {
                              print("????????????before Login");

                              print("======================================${cubit.emailController.text}======${cubit.passwordController.text}");
                              cubit.loginUser(cubit.emailController.text, cubit.passwordController.text);
                              print("======================after login");
                              },
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(top: 18),
                          child: Column(
                            children: [
                              Row(
                                children: [
                                  Text(
                                    "if you can't login go to ",
                                    style: TextStyle(
                                        color: Colors.grey, fontSize: 10),
                                  ),
                                  GestureDetector(
                                      onTap: () {},
                                      child: Text(
                                        "Reset Password",
                                        style: TextStyle(
                                            color: Colors.brown, fontSize: 12),
                                      ))
                                ],
                              ),
                              Row(
                                children: [
                                  Text(
                                    "Or ",
                                    style: TextStyle(
                                        color: Colors.grey, fontSize: 10),
                                  ),
                                  GestureDetector(
                                      onTap: () {
                                        Navigator.pushReplacementNamed(context, "/welcomePage");
                                      },
                                      child: Text(
                                        "Create New Account",
                                        style: TextStyle(
                                            color: Colors.brown, fontSize: 12),
                                      ))
                                ],
                              ),
                            ],
                          ),
                        )
                      ],
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      )),
    );
  }
}
