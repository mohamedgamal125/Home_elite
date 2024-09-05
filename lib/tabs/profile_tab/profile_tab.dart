import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:home_elite/tabs/profile_tab/profile_tab_cubit.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProfileTab extends StatefulWidget {
  const ProfileTab({super.key});

  @override
  State<ProfileTab> createState() => _ProfileTabState();
}

class _ProfileTabState extends State<ProfileTab> {
  @override
  void initState() {
    super.initState();

    context.read<ProfileTabCubit>().fetchUserData();
  }
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        child: Column(
          children: [
            Image(image: AssetImage("assets/images/TinyHouse.png")),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: Column(
                  children: [
                    BlocBuilder<ProfileTabCubit, ProfileTabState>(

                      builder: (context, state) {

                        if(state is ProfileTabLoading)
                          {
                            return Center(child: CircularProgressIndicator(color: Colors.brown,),);
                          }
                        else if(state is ProfileTabSuccess)
                          {
                            return Card(
                              elevation: 8.0,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12.0),
                              ),
                              color: Colors.white,
                              child: Padding(
                                padding: EdgeInsets.all(8.0),
                                child: ListTile(
                                  leading: Image.asset("assets/images/profile.png"),
                                  title: Text(
                                    '${state.user.username}',
                                    maxLines: 1,
                                    style: GoogleFonts.alegreyaSans(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  subtitle: Text(
                                    "${state.user.email}",
                                    style: GoogleFonts.alegreyaSans(fontSize: 10),
                                    maxLines: 1,
                                  ),
                                  trailing: IconButton(
                                    icon: Icon(
                                      Icons.edit,
                                      color: Colors.brown,
                                      size: 20,
                                    ),
                                    onPressed: () {
                                      // Handle edit button press
                                    },
                                  ),
                                ),
                              ),
                            );
                          }

                        return Center(child: Text("Something wrong happen while get data"),);
                      },
                    ),


                    Card(
                      elevation: 8.0,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12.0),
                      ),
                      color: Colors.white,
                      child: Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Column(
                          children: [
                            Row(
                              children: [
                                Image.asset("assets/icons/language_icon.png"),
                                SizedBox(
                                  width: 18,
                                ),
                                Text(
                                  "Language",
                                  style: GoogleFonts.alegreyaSans(),
                                ),
                                Spacer(),
                                Row(
                                  children: [
                                    Text(
                                      "English",
                                      style: GoogleFonts.alegreyaSans(
                                          fontSize: 12, color: Colors.grey),
                                    ),
                                    Image.asset(
                                      "assets/icons/editIcon.png",
                                      width: 30,
                                      height: 30,
                                    )
                                  ],
                                ),
                              ],
                            ),
                            Divider(
                              color: Colors.grey,
                              thickness: 0.3,
                              endIndent: 25,
                              indent: 25,
                            ),
                            Row(
                              children: [
                                Image.asset("assets/icons/location_icon.png"),
                                SizedBox(
                                  width: 18,
                                ),
                                Text(
                                  "Country",
                                  style: GoogleFonts.alegreyaSans(),
                                ),
                                Spacer(),
                                Row(
                                  children: [
                                    Text(
                                      "Egypt",
                                      style: GoogleFonts.alegreyaSans(
                                          fontSize: 12, color: Colors.grey),
                                    ),
                                    Image.asset(
                                      "assets/icons/editIcon.png",
                                      width: 30,
                                      height: 30,
                                    )
                                  ],
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                    Card(
                      elevation: 8.0,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12.0),
                      ),
                      color: Colors.white,
                      child: Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Column(
                          children: [
                            Row(
                              children: [
                                Image.asset("assets/icons/aboutus_icon.png"),
                                SizedBox(
                                  width: 18,
                                ),
                                Text(
                                  "About us",
                                  style: GoogleFonts.alegreyaSans(),
                                ),
                                Spacer(),
                                Image.asset(
                                  "assets/icons/editIcon.png",
                                  width: 30,
                                  height: 30,
                                )
                              ],
                            ),
                            Divider(
                              color: Colors.grey,
                              thickness: 0.3,
                              endIndent: 25,
                              indent: 25,
                            ),
                            Row(
                              children: [
                                Image.asset("assets/icons/rateus_icon.png"),
                                SizedBox(
                                  width: 18,
                                ),
                                Text(
                                  "Rate us",
                                  style: GoogleFonts.alegreyaSans(),
                                ),
                                Spacer(),
                                Image.asset(
                                  "assets/icons/editIcon.png",
                                  width: 30,
                                  height: 30,
                                ),
                              ],
                            ),
                            Divider(
                              color: Colors.grey,
                              thickness: 0.3,
                              endIndent: 25,
                              indent: 25,
                            ),
                            Row(
                              children: [
                                Image.asset("assets/icons/contactus_icon.png"),
                                SizedBox(
                                  width: 18,
                                ),
                                Text(
                                  "Contact us",
                                  style: GoogleFonts.alegreyaSans(),
                                ),
                                Spacer(),
                                Image.asset(
                                  "assets/icons/editIcon.png",
                                  width: 30,
                                  height: 30,
                                ),
                              ],
                            ),
                            Divider(
                              color: Colors.grey,
                              thickness: 0.3,
                              endIndent: 25,
                              indent: 25,
                            ),
                            Row(
                              children: [
                                Image.asset("assets/icons/privacy_icon.png"),
                                SizedBox(
                                  width: 18,
                                ),
                                Text(
                                  "Privacy Policy",
                                  style: GoogleFonts.alegreyaSans(),
                                ),
                                Spacer(),
                                Image.asset(
                                  "assets/icons/editIcon.png",
                                  width: 30,
                                  height: 30,
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                    Card(
                      elevation: 8.0,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12.0),
                      ),
                      color: Colors.white,
                      child: Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Column(
                          children: [
                            Row(
                              children: [
                                Image.asset("assets/icons/ads_icon.png"),
                                SizedBox(
                                  width: 18,
                                ),
                                Text(
                                  "My Ads",
                                  style: GoogleFonts.alegreyaSans(),
                                ),
                                Spacer(),
                                Image.asset(
                                  "assets/icons/editIcon.png",
                                  width: 30,
                                  height: 30,
                                ),
                              ],
                            ),
                            Divider(
                              color: Colors.grey,
                              thickness: 0.3,
                              endIndent: 25,
                              indent: 25,
                            ),
                            Row(
                              children: [
                                Image.asset("assets/icons/ads_icon.png"),
                                SizedBox(
                                  width: 18,
                                ),
                                Text(
                                  "My Activity",
                                  style: GoogleFonts.alegreyaSans(),
                                ),
                                Spacer(),
                                Image.asset(
                                  "assets/icons/editIcon.png",
                                  width: 30,
                                  height: 30,
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(height: 20), // Adds spacing before the button
                    Container(

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
                            "Logout",
                            style: GoogleFonts.alegreyaSansSc(
                                textStyle: TextStyle(
                                    color: Colors.white,
                                    fontSize: 16)),
                          ),
                        ),
                        onPressed: () async {
                          final SharedPreferences pref = await SharedPreferences
                              .getInstance();
                          print("=======Token before delete=====");
                          print(pref.get('token'));
                          await pref.remove('token');
                          await pref.clear();
                          print("=======Token after delete=====");
                          print(pref.get('token'));
                          Navigator.pushReplacementNamed(context, "/login");
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
