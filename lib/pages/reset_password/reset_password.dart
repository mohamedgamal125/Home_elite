import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:home_elite/pages/login_page/login_cubit.dart';
import 'package:home_elite/pages/login_page/login_state.dart';
import 'package:home_elite/pages/reset_password/reset_password_cubit.dart';

import '../../shared/components/custom_input_fields.dart';

class ResetPassword extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final deviceWidth = MediaQuery.of(context).size.width;
    final deviceHeight = MediaQuery.of(context).size.height;

    return BlocProvider(
      create: (context) => ResetPasswordCubit(),
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
                BlocConsumer<ResetPasswordCubit, ResetPasswordState>(
                  listener: (context, state) {
                    if (state is ResetPasswordSuccess) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text(state.message,maxLines: 1,style: TextStyle(fontSize: 12),),
                          backgroundColor: Colors.green,
                        ),
                      );
                    } else if (state is ResetPasswordError) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text("Please enter a vaild email"),
                          backgroundColor: Colors.red,
                        ),
                      );
                    }
                  },
                  builder: (context, state) {
                    var cubit = ResetPasswordCubit.get(context);
                    return Padding(
                        padding: EdgeInsets.only(top: 50, left: 36),
                        child: Column(
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
                                    "Reset Password",
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
                                cubit.email.text = value;
                              },
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return "Please enter your email";
                                }
                                return null;
                              },
                            ),
                            state is ResetPasswordLoading
                                ? Padding(
                                  padding:  EdgeInsets.symmetric(vertical: 16),
                                  child: Center(
                                      child: CircularProgressIndicator(
                                        color: Colors.brown,
                                      ),
                                    ),
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
                                          borderRadius:
                                              BorderRadius.circular(12),
                                        ),
                                      ),
                                      child: Center(
                                        child: Text(
                                          "Reset Password",
                                          style: GoogleFonts.alegreyaSansSc(
                                              textStyle: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 16)),
                                        ),
                                      ),
                                      onPressed: () {
                                        print("email ${cubit.email.text}");
                                        cubit.resetPassword();
                                      },
                                    ),
                                  ),
                          ],
                        ));
                  },
                ),
              ],
            ),
          )),
    );
  }
}
