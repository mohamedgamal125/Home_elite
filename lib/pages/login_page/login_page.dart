import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:home_elite/pages/login_page/login_cubit.dart';
import 'package:home_elite/pages/login_page/login_state.dart';

import '../../shared/components/custom_input_fields.dart';
import '../reset_password/reset_password.dart';

class LoginPage extends StatelessWidget {
  var _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final deviceWidth = MediaQuery.of(context).size.width;
    final deviceHeight = MediaQuery.of(context).size.height;

    return BlocProvider(
      create: (context) => LoginCubit(Dio()),
      child: Scaffold(
        resizeToAvoidBottomInset: false,
          body: SafeArea(
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
                      if (state is LoginSuccess) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text(state.response.message),
                            backgroundColor: Colors.green,
                          ),
                        );
                        Navigator.pushReplacementNamed(context, "/home");
                      } else if (state is LoginFailure) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text("Error While Login"),backgroundColor: Colors.red,),
                        );

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
                          CustomTextField(
                            label: "Email Address",
                            obscureText: false,
                            onChanged: (value) {
                              cubit.emailController.text = value;
                            },
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return "Please enter your email";
                              }
                              return null;
                            },
                          ),
                          CustomTextField(
                            label: "Password",
                            obscureText: true,
                            onChanged: (value) {
                              cubit.passwordController.text = value;
                            },
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return "Please enter your password";
                              }
                              return null;
                            },
                          ),
                          state is LoginLoading
                              ? Padding(
                            padding: const EdgeInsets.only(top: 12,right: 20),
                            child: Center(
                                child: CircularProgressIndicator(
                                    color: Colors.brown)),
                          )
                              : Container(
                            margin: EdgeInsets.only(top: 35, right: 20),
                            width: 300,
                            height: 55,
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Color(0xff9D7D43),
                                padding: EdgeInsets.symmetric(
                                    horizontal: 20, vertical: 15),
                                shape: RoundedRectangleBorder(
                                  side: BorderSide(
                                      color: Color(0xff9D7D43)),
                                  borderRadius: BorderRadius.circular(12),
                                ),
                              ),
                              child: Center(
                                child: Text(
                                  "Login",
                                  style: GoogleFonts.alegreyaSansSc(
                                      textStyle: TextStyle(
                                          color: Colors.white,
                                          fontSize: 16)),
                                ),
                              ),
                              onPressed: () {

                                  cubit.loginUser(
                                      cubit.emailController.text,
                                      cubit.passwordController.text);

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
                                      "If you can't login go to ",
                                      style: TextStyle(
                                          color: Colors.grey, fontSize: 12),
                                    ),
                                    GestureDetector(
                                        onTap: () {
                                          Navigator.push(context, MaterialPageRoute(builder: (context)=>ResetPassword()));
                                        },
                                        child: Text(
                                          "Reset Password",
                                          style: TextStyle(
                                              color: Colors.brown, fontSize: 13),
                                        ))
                                  ],
                                ),
                                Row(
                                  children: [
                                    Text(
                                      "Or ",
                                      style: TextStyle(
                                          color: Colors.grey, fontSize: 12),
                                    ),
                                    GestureDetector(
                                        onTap: () {
                                          Navigator.pushReplacementNamed(
                                              context, "/welcomePage");
                                        },
                                        child: Text(
                                          "Create New Account",
                                          style: TextStyle(
                                              color: Colors.brown, fontSize: 13),
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
          )),
    );
  }
}
