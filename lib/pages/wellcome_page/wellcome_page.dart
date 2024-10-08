import 'package:dio/dio.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:home_elite/Theming/myTheme_data.dart';
import 'package:home_elite/pages/signUp_page/signup_cubit/signupPage.dart';
import 'package:home_elite/pages/wellcome_page/welcome_cubit.dart';
import 'package:home_elite/pages/wellcome_page/welcome_state.dart';

import '../../services/navigation_service.dart';

class WellComePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final double deviceWidth = MediaQuery.of(context).size.width;
    final deviceHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: BlocProvider(
        create: (context) => GoogleSignUpCubit(),
        child: SafeArea(
          child: Stack(
            children: [
              Image.asset(
                "assets/images1/background_new.jpg",
                fit: BoxFit.fill,
                height: deviceHeight,
                width: deviceWidth,
              ),
              Padding(
                padding:  EdgeInsets.only(top: 50),
                child: Column(
                  // mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Image.asset("assets/images1/newLogo.png",
                        width: 230, height: 150),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 8.0,top: 12),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(bottom: 12),
                            child: Text("Developed By ",style: TextStyle(fontSize: 12,color: MyColor.myDark),),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(bottom:12,),
                            child: Image.asset("assets/images1/company (1).png",width: 100,height: 25,),

                          ),

                          Padding(
                            padding: const EdgeInsets.only(bottom: 12),
                            child: Text(" &Hassen",style: TextStyle(fontSize: 12,color: MyColor.myDark),),
                          )
                        ],
                      ),
                    ),

                    Padding(
                      padding: const EdgeInsets.only( top: 18.0,bottom: 18),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            margin: EdgeInsets.only(left: 8),
                            height: 81,
                            width: 5,
                            decoration: BoxDecoration(color:MyColor.myDark),
                          ),
                          Padding(
                            padding:  EdgeInsets.only(left: 18.0,right: 8),
                            child:  Expanded(
                              child: Text(
                                "welcome".tr(),
                                style: GoogleFonts.alegreyaSansSc(
                                  textStyle: TextStyle(fontSize: 20),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),


                    BlocConsumer<GoogleSignUpCubit, GoogleSignUpState>(
                      listener: (context, state) {
                        if (state is GoogleSignUpSuccess) {

                          print("========================Sign Up with google done ======================");
                          print(state.token);

                          Navigator.pushReplacementNamed(context, "/home");
                        } else if (state is GoogleSignUpError) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                                backgroundColor: Colors.red,
                                content: Text("errorWhileLogin".tr())),
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
                                  side: BorderSide(color: MyColor.myDark),
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
                                    "signupG".tr(),
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
                            backgroundColor: MyColor.myDark,
                            padding: EdgeInsets.symmetric(
                                horizontal: 20, vertical: 15),
                            shape: RoundedRectangleBorder(
                              side: BorderSide(color: MyColor.myDark),
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Image.asset(
                                "assets/images1/email_logo.png",
                                width: 40,
                                height: 45,
                              ),
                              SizedBox(
                                width: 13,
                              ),
                              Text(
                                "signupE".tr(),
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
                            "haveAccount".tr(),
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
                            child: Padding(
                              padding:  EdgeInsets.only(left: 6.0),
                              child: Text(
                                "login".tr(),
                                style: TextStyle(
                                    color: MyColor.myDark, fontSize: 13),
                              ),
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
