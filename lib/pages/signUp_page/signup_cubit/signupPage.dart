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

                'email':context.read<SignupCubit>().emailController.text
              });
            } else if (state is RegisterFailure) {
              print(state.error);
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                    backgroundColor: Colors.red,
                    content: Text("Something Wrong Happen")),
              );

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
                              return RegExp( r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+").hasMatch(value!) ? null : 'Enter Valid value';
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


                          Padding(
                            padding: const EdgeInsets.only(top: 10.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text("Adderss",style: GoogleFonts.alegreyaSansSc(fontWeight: FontWeight.bold,fontSize: 16)),
                                Padding(
                                  padding: EdgeInsets.only(right: 25.0),
                                  child: Container(
                                    width: 331,
                                    height: 42,
                                    child: DropdownButtonFormField<String>(
                                      onChanged: (value) {

                                        cubit.Address=value;
                                      },
                                        decoration: InputDecoration(
                                          contentPadding: EdgeInsets.only(left: 12),
                                          fillColor: Colors.white,
                                          filled: true,
                                          enabledBorder: OutlineInputBorder(
                                            borderSide: BorderSide(color: Colors.brown),
                                            borderRadius: BorderRadius.circular(12),
                                          ),
                                          focusedBorder: OutlineInputBorder(
                                            borderSide: BorderSide(color: Colors.brown, width: 2.0),
                                            borderRadius: BorderRadius.circular(12),
                                          ),
                                        ),
                                        items: cubit.egyptianCities.map<DropdownMenuItem<String>>((String city) {
                                          return DropdownMenuItem<String>(
                                            value: city,
                                            child: Text(city),
                                          );
                                        }).toList(),
                                       onSaved: (value){
                                          cubit.Address=value;
                                       },
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),

                          Padding(
                            padding:
                            const EdgeInsets.only(top: 25.0, right: 25),
                            child: Container(
                              width: 331,
                              height: 70,
                              child: IntlPhoneField(
                                controller: cubit.phoneController,
                                decoration: InputDecoration(


                                  contentPadding: EdgeInsets.symmetric(horizontal: 8,vertical: 16),
                                  focusColor: Colors.brown,
                                  labelText: 'Phone Number',
                                  labelStyle: GoogleFonts.alegreyaSansSc(fontSize: 16,fontWeight: FontWeight.bold),
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(12),
                                    borderSide: BorderSide(
                                      color: Colors.transparent
                                    ),
                                  ),
                                ),
                                initialCountryCode: 'EG',
                                onChanged: (phone) {
                                  print(phone.completeNumber);
                                },

                              ),
                            ),
                          ),
                          state is RegisterLoading
                              ?
                          CircularProgressIndicator(color: Colors.brown,)
                              : InkWell(
                            onTap: () {
                              if (_formKey.currentState?.validate() ?? false) {
                                // Navigate to next screencontext.read<SignupCubit>().printData();
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