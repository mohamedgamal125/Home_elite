import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_otp_text_field/flutter_otp_text_field.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:home_elite/pages/signUp_page/signup_cubit/signup_cubit.dart';
import 'package:home_elite/pages/signUp_page/verification_cubit/verification_cubit.dart';

class SignupVerification extends StatefulWidget {
  final String? verificationCode;

  SignupVerification({this.verificationCode});

  @override
  State<SignupVerification> createState() => _SignupVerificationState();
}

class _SignupVerificationState extends State<SignupVerification> {
  String? verificationCode;
  @override
  Widget build(BuildContext context) {
    final Map<String, dynamic>? args =
        ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>;
    final deviceWidth = MediaQuery.of(context).size.width;
    final deviceHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      body: BlocProvider(
        create: (context) => VerificationCubit(),
        child: SafeArea(
          child: SingleChildScrollView(
            child: Stack(
              children: [
                Image.asset(
                  "assets/images/image.jpg",
                  fit: BoxFit.fill,
                  height: deviceHeight,
                  width: deviceWidth,
                ),
                BlocConsumer<VerificationCubit, VerificationState>(
                  listener: (context, state) {
                    if (state is VerificationSuccess) {
                      ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text("Verification Complete"),backgroundColor: Colors.green,));
                      Navigator.pushReplacementNamed(context, "/login");
                    } else if (state is VerificationError) {
                      ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text("${state.error}"),backgroundColor: Colors.red,));

                      print(state.error);
                    }

                  },
                  builder: (context, state) {
                    return Padding(
                      padding: EdgeInsets.only(top: 80, left: 36),
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
                            child: Text(
                              "Check your SMS , because we sent verification code to confirm your account",
                              style: TextStyle(
                                fontWeight: FontWeight.w100,
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 39, right: 100),
                            child: Text(
                              "Verification code}",
                              style: GoogleFonts.alegreyaSansSc(
                                  textStyle: TextStyle(fontSize: 22)),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 18, right: 26),
                            child: OtpTextField(

                              onSubmit: (value) {
                                setState(() {
                                  verificationCode=value;
                                });
                              },
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
                          SizedBox(
                            height: deviceHeight * 0.2,
                          ),
                          state is VerificationLoading?Center(child: CircularProgressIndicator(color: Colors.brown,)):Container(
                            margin: EdgeInsets.only(top: 35, right: 30),
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

                                  print("==================================================");
                                  print(args?['email']);
                                  print(args?['verificationCode']);
                                  print("=======================");
                                  print(verificationCode);
                                  context.read<VerificationCubit>().verifyPhone(args?['email'],verificationCode!);

                              },
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
