import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:home_elite/pages/signUp_page/signup_cubit/signup_cubit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:home_elite/pages/signUp_page/signup_cubit/signup_state.dart';
import 'package:intl_phone_field/intl_phone_field.dart';

import '../../../shared/components/custom_input_fields.dart';

class SignupPage extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final deviceWidth = MediaQuery
        .of(context)
        .size
        .width;
    final deviceHeight = MediaQuery
        .of(context)
        .size
        .height;

    return BlocProvider(
      create: (_) => SignupCubit(),
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        body: BlocConsumer<SignupCubit, RegisterState>(
          listener: (context, state) {
            if (state is RegisterSuccess) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                    backgroundColor: Colors.green,
                    content: Text(state.response.message)),
              );
              // Handle navigation or other actions if needed
              Navigator.pushReplacementNamed(context, "/signupVerification",arguments: {
                'verificationCode':state.response.user.verificationCode,
                'email': state.response.user.email
              });
            } else if (state is RegisterFailure) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                    backgroundColor: Colors.red,
                    content: Text("Something Wrong Happen")),
              );

              print(
                  "==============================ERRor Signup========================");
              print(state.error);
              print(
                  "==============================ERRor Signup========================");
            }
          },
          builder: (context, state) {
            var cubit = SignupCubit.get(context);
            return SafeArea(
              child: Stack(
                children: [
                  Image.asset(
                    "assets/images/image.jpg",
                    fit: BoxFit.fill,
                    height: deviceHeight,
                    width: deviceWidth,
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 36, top: 80),
                    child: Form(
                      key: _formKey,
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
                                        color: Color(0xff263A27)),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          CustomTextField(
                            label: "Username",
                            onChanged: (value) {
                              cubit.userNameController.text = value;
                            },
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Username is required';
                              }
                              return null;
                            },
                          ),
                          CustomTextField(
                            label: "Email",
                            onChanged: (value) {
                              cubit.emailController.text = value;
                            },
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Email is required';
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
                                return 'Password is required';
                              }
                              return null;
                            },
                          ),
                          CustomTextField(
                            label: "Address",
                            onChanged: (value) {
                              cubit.AddressController.text = value;
                            },
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Password is required';
                              }
                              return null;
                            },
                          ),
                          Padding(
                            padding:
                            const EdgeInsets.only(top: 25.0, right: 25),
                            child: IntlPhoneField(
                              controller: cubit.phoneController,
                              decoration: InputDecoration(
                                focusColor: Colors.brown,
                                labelText: 'Phone Number',
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(12),
                                  borderSide: BorderSide(
                                    color: Colors.brown,
                                  ),
                                ),
                              ),
                              initialCountryCode: 'EG',
                              onChanged: (phone) {
                                print(phone.completeNumber);
                              },

                            ),
                          ),
                          state is RegisterLoading
                              ?
                          CircularProgressIndicator(color: Colors.brown,)
                              : InkWell(
                            onTap: () {
                              if (_formKey.currentState?.validate() ?? false) {
                                // Navigate to next screen
                                context.read<SignupCubit>().printData();
                                context.read<SignupCubit>().register();
                              }
                            },
                            child: Container(
                              margin: EdgeInsets.only(top: 35, right: 20),
                              width: 331,
                              height: 44,
                              decoration: BoxDecoration(
                                color: Color(0xff9D7D43), // Background color
                                borderRadius: BorderRadius.circular(12),
                                border: Border.all(
                                    color: Color(0xff9D7D43)), // Border color
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    "Next",
                                    style: GoogleFonts.alegreyaSansSc(
                                      textStyle: TextStyle(
                                          color: Colors.white, fontSize: 18),
                                    ),
                                  ),
                                  SizedBox(width: 8),
                                  // Add some spacing between the text and the image
                                  Image.asset("assets/images/arrow.png",
                                      width: 22, height: 22),
                                ],
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }

}