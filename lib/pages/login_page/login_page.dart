import 'dart:async';

import 'package:dio/dio.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:home_elite/Theming/myTheme_data.dart';
import 'package:home_elite/pages/login_page/login_cubit.dart';
import 'package:home_elite/pages/login_page/login_state.dart';
import 'package:uni_links/uni_links.dart';

import '../../shared/components/custom_input_fields.dart';
import '../reset_password/reset_password.dart';

class LoginPage extends StatefulWidget {
  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  var _formKey = GlobalKey<FormState>();
  StreamSubscription? _sub;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _sub = uriLinkStream.listen((Uri? uri) {
      if (uri != null) {
        print("Received deep link on TestPage: $uri");
        // Handle the deep link
        if (uri.host == 'test') {
          // Perform any action if required when the deep link is received on this page
        }
      }
    });
  }
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
                  "assets/images1/background_new.jpg",
                  fit: BoxFit.fill,
                  height: deviceHeight,
                  width: deviceWidth,
                ),
                Padding(
                  padding: EdgeInsets.only(top: 50, left: 36,right: 6),
                  child: BlocConsumer<LoginCubit, LoginState>(
                    listener: (context, state) {
                      if (state is LoginSuccess) {

                        Navigator.pushReplacementNamed(context, "/home");
                      } else if (state is LoginFailure) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text("errorWhileLogin".tr()),backgroundColor: Colors.red,),
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
                                BoxDecoration(color: MyColor.myTitleColor),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(left: 14.0),
                                child: Text(
                                  "login".tr(),
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
                            child: Image.asset("assets/images1/newLogo.png"),
                          ),
                          CustomTextField(
                            label: "emailAddress".tr(),
                            obscureText: false,
                            onChanged: (value) {
                              cubit.emailController.text = value;
                            },
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return "invalidData".tr();
                              }
                              return null;
                            },
                          ),
                          CustomTextField(
                            label: "password".tr(),
                            obscureText: true,
                            onChanged: (value) {
                              cubit.passwordController.text = value;
                            },
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return "invalidData".tr();
                              }
                              return null;
                            },
                          ),
                          state is LoginLoading
                              ? Padding(
                            padding: const EdgeInsets.only(top: 12,right: 20),
                            child: Center(
                                child: CircularProgressIndicator(
                                    color: MyColor.myDark)),
                          )
                              : Container(
                            margin: EdgeInsets.only(top: 35, right: 20),
                            width: 300,
                            height: 55,
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                backgroundColor:MyColor.myDark,
                                padding: EdgeInsets.symmetric(
                                    horizontal: 20, vertical: 15),
                                shape: RoundedRectangleBorder(
                                  side: BorderSide(
                                      color: MyColor.myDark),
                                  borderRadius: BorderRadius.circular(12),
                                ),
                              ),
                              child: Center(
                                child: Text(
                                  "login".tr(),
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
                                      "canNotLogin".tr(),
                                      style: TextStyle(
                                          color: Colors.grey, fontSize: 12),
                                    ),
                                    GestureDetector(
                                        onTap: () {
                                          Navigator.push(context, MaterialPageRoute(builder: (context)=>ResetPassword()));
                                        },
                                        child: Text(
                                          "resetPassword".tr(),
                                          style: TextStyle(
                                              color: MyColor.myDark, fontSize: 13),
                                        ))
                                  ],
                                ),
                                Row(
                                  children: [
                                    Text(
                                      "or".tr(),
                                      style: TextStyle(
                                          color: Colors.grey, fontSize: 12),
                                    ),
                                    GestureDetector(
                                        onTap: () {
                                          Navigator.pushReplacementNamed(
                                              context, "/welcomePage");
                                        },
                                        child: Text(
                                          "createAccount".tr(),
                                          style: TextStyle(
                                              color:MyColor.myDark, fontSize: 13),
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
