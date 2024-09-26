import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:home_elite/tabs/profile_tab/edit_page/edit_profile_cubit.dart';
import 'package:intl_phone_field/intl_phone_field.dart';

class EditProfile extends StatelessWidget {
  const EditProfile({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocProvider(
        create: (context) => EditProfileCubit(),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 20, right: 20, top: 50),
              child: Row(
                children: [
                  Container(
                    height: 40,
                    width: 6,
                    decoration: BoxDecoration(color: Color(0xff9D7D43)),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 14.0),
                    child: Text(
                      "Edit Profile",
                      style: GoogleFonts.alegreyaSansSc(
                          textStyle: TextStyle(
                              fontSize: 30,
                              fontWeight: FontWeight.w400,
                              color: Color(0xff263A27))),
                    ),
                  ),
                ],
              ),
            ),
            BlocConsumer<EditProfileCubit, EditProfileState>(
              listener: (context, state) {
                // TODO: implement listener
              },
              builder: (context, state) {
                var cubit = EditProfileCubit.get(context);
                return Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 9.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Name  ",
                              style: GoogleFonts.alegreyaSansSc(),
                            ),
                            Container(
                              height: 32,
                              child: TextFormField(
                                controller: cubit.name,
                                cursorColor: Colors.brown,
                                onChanged: (value) {
                                  cubit.name.text = value;
                                },
                                decoration: InputDecoration(
                                  hintText: "",
                                  hintStyle: GoogleFonts.alegreyaSansSc(
                                    fontSize: 16,
                                  ),
                                  contentPadding: EdgeInsets.only(left: 12),
                                  fillColor: Colors.white,
                                  filled: true,
                                  enabledBorder: OutlineInputBorder(
                                    borderSide: BorderSide(color: Colors.grey),
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        color: Colors.grey, width: 2.0),
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                          top: 25.0,
                        ),
                        child: Container(
                          width: double.infinity,
                          height: 70,
                          child: IntlPhoneField(
                            cursorColor: Colors.brown,
                            controller: cubit.phone,
                            decoration: InputDecoration(
                              contentPadding: EdgeInsets.only(
                                  left: 8, right: 8, bottom: 80),
                              focusColor: Colors.brown,
                              focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(16)),
                              labelText: 'Phone Number',
                              labelStyle: GoogleFonts.alegreyaSansSc(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12),
                                borderSide:
                                    BorderSide(color: Colors.transparent),
                              ),
                            ),
                            initialCountryCode: 'EG',
                            onChanged: (phone) {
                              print(phone.completeNumber);
                            },
                          ),
                        ),
                      ),
                      BlocConsumer<EditProfileCubit, EditProfileState>(
                        listener: (context, state) {
                            if(state is EditeProfileError)
                              {
                                ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("There is a proplem")));
                              }
                            if(state is EditeProfileSuccess)
                              {
                                AwesomeDialog(
                                  context: context,
                                  dialogType: DialogType.success,
                                  animType: AnimType.rightSlide,
                                  title: 'you information Updated Successfully',

                                  btnOkOnPress: () {
                                    cubit.clearData();

                                  },
                                )..show();

                              }
                        },
                        builder: (context, state) {
                          return state is EditeProfileLoading?Center(child: CircularProgressIndicator(color: Colors.brown,),):Container(
                            margin: EdgeInsets.only(top: 35, right: 20),
                            width: 331,
                            height: 44,
                            decoration: BoxDecoration(
                              color: Color(0xff9D7D43), // Background color
                              borderRadius: BorderRadius.circular(12),
                              border: Border.all(
                                  color: Color(0xff9D7D43)), // Border color
                            ),
                            child: InkWell(
                              onTap: () {

                                cubit.editProfile();
                              },
                              child: Row(
                                children: [
                                  Text(
                                    "Save",
                                    style: GoogleFonts.alegreyaSansSc(
                                      textStyle: TextStyle(
                                          color: Colors.white, fontSize: 18),
                                    ),
                                  ),
                                ],
                                mainAxisAlignment: MainAxisAlignment.center,
                              ),
                            ),
                          );
                        },
                      ),
                    ],
                  ),
                );
              },
            )
          ],
        ),
      ),
    );
  }
}
