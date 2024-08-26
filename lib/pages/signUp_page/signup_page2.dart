// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:home_elite/pages/signUp_page/signup_cubit/signup_cubit.dart';
// import 'package:home_elite/pages/signUp_page/signup_verification.dart';
// import 'package:intl_phone_field/intl_phone_field.dart';
//
// class SignupPage2 extends StatelessWidget {
//   const SignupPage2({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     final deviceWidth = MediaQuery
//         .of(context)
//         .size
//         .width;
//     final deviceHeight = MediaQuery
//         .of(context)
//         .size
//         .height;
//     return Scaffold(
//
//       resizeToAvoidBottomInset: false,
//
//       body: BlocConsumer<SignupCubit, SignupState>(
//         listener: (context, state) {
//           if (state is SignupSuccess) {
//             ScaffoldMessenger.of(context).showSnackBar(
//               SnackBar(backgroundColor: Colors.green,
//                   content: Text(state.responseModel.message)),
//             );
//             // Handle navigation or other actions if needed
//             Navigator.pushReplacementNamed(context, "/signupVerification");
//           } else if (state is SignupFailure) {
//             ScaffoldMessenger.of(context).showSnackBar(
//               SnackBar(
//                   backgroundColor: Colors.red,
//                   content: Text("Something Wrong Happen")),
//             );
//
//             print("==============================ERRor Signup========================");
//             print(state.error);
//             print("==============================ERRor Signup========================");
//           }
//         },
//         builder: (context, state) {
//           return SafeArea(
//             child: Stack(
//               children: [
//                 Image.asset(
//                   "assets/images/image.jpg",
//                   fit: BoxFit.fill,
//                   height: deviceHeight,
//                   width: deviceWidth,
//                 ),
//                 Padding(
//                   padding: EdgeInsets.only(top: 50, left: 36),
//                   child: Column(
//                     children: [
//                       Row(
//                         children: [
//                           Container(
//                             height: 40,
//                             width: 6,
//                             decoration: BoxDecoration(
//                                 color: Color(0xff9D7D43)),
//                           ),
//                           Padding(
//                             padding: const EdgeInsets.only(left: 14.0),
//                             child: Text(
//                               "Sign up",
//                               style: GoogleFonts.alegreyaSansSc(
//                                   textStyle: TextStyle(
//                                       fontSize: 30,
//                                       fontWeight: FontWeight.w400,
//                                       color: Color(0xff263A27))),
//                             ),
//                           )
//                         ],
//                       ),
//
//                       Padding(
//                         padding: EdgeInsets.only(right: 12, top: 30),
//                         child: IntlPhoneField(
//
//                           decoration: InputDecoration(
//                             focusColor: Colors.brown,
//                             labelText: 'Phone Number',
//                             border: OutlineInputBorder(
//                               borderSide: BorderSide(
//                                   color: Colors.brown
//                               ),
//                             ),
//                           ),
//                           initialCountryCode: 'EG',
//                           onChanged: (phone) {
//                             print(phone.completeNumber);
//                             context.read<SignupCubit>().updatePhoneNumber(
//                                 phone.completeNumber);
//                           },
//                         ),
//                       ),
//
//                       Padding(
//                         padding: const EdgeInsets.only(top: 28, right: 12),
//                         child: Text(
//                           "Please verify your phone to protect your account. Enter the verification code sent to your mobile number to ensure your account remains secure. This verification step helps us confirm your identity and prevent unauthorized access. If you did not request this verification, please contact our support team immediately. Remember, do not share this code with anyone.",
//                           style: TextStyle(
//                               color: Colors.grey, fontSize: 12),),
//                       ),
//                       SizedBox(height:deviceHeight*0.2,),
//                       state is SignupLoading?
//                         CircularProgressIndicator(color: Colors.brown,)
//                           :InkWell(
//                         // onTap: () {
//                         //   context.read<SignupCubit>().register(
//                         //       email: state.email,
//                         //       password: state.password,
//                         //       //confpassword: state.password,
//                         //       phone: state.phoneNumber,
//                         //       address: "gigg",
//                         //       username: state.username);
//                         //   context.read<SignupCubit>().printData();
//                         //   },
//                         child: Container(
//                           margin: EdgeInsets.only(top: 35, right: 20),
//                           width: 331,
//                           height: 44,
//                           decoration: BoxDecoration(
//                             color: Color(0xff9D7D43), // Background color
//                             borderRadius: BorderRadius.circular(12),
//                             border: Border.all(color: Color(0xff9D7D43)), // Border color
//                           ),
//                           child: Row(
//                             mainAxisAlignment: MainAxisAlignment.center,
//                             children: [
//                               Text(
//                                 "Verification code",
//                                 style: GoogleFonts.alegreyaSansSc(
//                                     textStyle: TextStyle(
//                                         color: Colors.white, fontSize: 18)),
//                               ),
//                             ],
//                           ),
//                         ),
//                       )
//
//
//                     ],
//                   ),
//                 ),
//               ],
//             ),
//           );
//         },
//       ),
//     );
//   }
// }
