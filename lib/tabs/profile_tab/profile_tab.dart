import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:home_elite/Theming/myTheme_data.dart';
import 'package:home_elite/tabs/profile_tab/edit_page/edit_profile.dart';
import 'package:home_elite/tabs/profile_tab/profile_tab_cubit.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProfileTab extends StatefulWidget {
  const ProfileTab({super.key});

  @override
  State<ProfileTab> createState() => _ProfileTabState();
}

class _ProfileTabState extends State<ProfileTab> {
  String _currentLanguage = 'English';
  @override
  void initState() {

    super.initState();

    context.read<ProfileTabCubit>().fetchUserData();
    _getSelectedLanguage();
  }
  void _getSelectedLanguage() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? selectedLanguage = prefs.getString('selectedLanguage');

    // Apply the selected language or set default language
    if (selectedLanguage != null) {
      setState(() {
        _currentLanguage = selectedLanguage; // Use this in your UI
      });
    }
  }
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        child: Column(
          children: [
            Image(image: AssetImage("assets/images1/Tiny house_new.png")),
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
                            return Center(child: CircularProgressIndicator(color: MyColor.myDark),);
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
                                      color:MyColor.myDark,
                                      size: 20,
                                    ),
                                    onPressed: () {
                                        Navigator.push(context, MaterialPageRoute(builder: (context)=> EditProfile()));
                                    },
                                  ),
                                ),
                              ),
                            );
                          }

                        return Center(child: CircularProgressIndicator(color:MyColor.myDark,),);
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
                            GestureDetector(
                              onTap: (){
                                showLanguageSelectionSheet(context);
                              },
                              child: Row(
                                children: [
                                  Image.asset("assets/icons/language_icon.png"),
                                  SizedBox(
                                    width: 18,
                                  ),
                                  Text(
                                    "lang".tr(),
                                    style: GoogleFonts.alegreyaSans(),
                                  ),
                                  Spacer(),
                                  Row(
                                    children: [
                                      Text(
                                        "$_currentLanguage",
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
                                  "country".tr(),
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
                                  "aboutUs".tr(),
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
                            InkWell(

                              child: Row(
                                children: [
                                  Image.asset("assets/icons/rateus_icon.png"),
                                  SizedBox(
                                    width: 18,
                                  ),
                                  Text(
                                    "rateUs".tr(),
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
                                  "contactUs".tr(),
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
                                  "privacyPolicy".tr(),
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
                            InkWell(
                              onTap: () {

                                Navigator.pushNamed(context, "/myAdsPage");
                              },
                              child: Row(
                                children: [
                                  Image.asset("assets/icons/ads_icon.png"),
                                  SizedBox(
                                    width: 18,
                                  ),
                                  Text(
                                    "myAds".tr(),
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
                            ),
                            Divider(
                              color: Colors.grey,
                              thickness: 0.3,
                              endIndent: 25,
                              indent: 25,
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
                          backgroundColor: MyColor.myDark,
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
                            "logout".tr(),
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

  void showLanguageSelectionSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return Container(
          padding: EdgeInsets.all(16),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ListTile(
                title: Text('english'.tr()),
                onTap: () {
                  _changeLanguage(context, 'English');
                },
              ),
              ListTile(
                title: Text('arabic'.tr()),
                onTap: () {
                  _changeLanguage(context, 'Arabic');
                },
              ),
            ],
          ),
        );
      },
    );
  }
  void _changeLanguage(BuildContext context, String language) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    Locale locale;

    if (language == 'English') {
      locale = Locale('en');
    } else {
      locale = Locale('ar');
    }

    await prefs.setString('selectedLanguage', language);

    // Change the app's language
    await context.setLocale(locale);
    await prefs.setBool('isLanguageSelected', true);

    setState(() {
      _currentLanguage = language; // Update displayed language
    });

    Navigator.pop(context);
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('$language selected')),
    );
  }

}
