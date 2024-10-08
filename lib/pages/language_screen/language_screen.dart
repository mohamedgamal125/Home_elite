import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../wellcome_page/wellcome_page.dart';

class LanguageScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final double deviceWidth = MediaQuery.of(context).size.width;
    final deviceHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            Image.asset(
              "assets/images1/background_new.jpg",
              fit: BoxFit.fill,
              height: deviceHeight,
              width: deviceWidth,
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        InkWell(
                          onTap: () async{
                            _changeLanguage(context, 'ar');
                           _navigateToWelcomeScreen(context);

                          },
                          child: Container(
                            width: 120,
                            height: 100,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(18),
                            ),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(18),
                              // Same border radius as the container
                              child: Image.asset(
                                "assets/images1/icons/ar_logo1.png",
                                fit: BoxFit
                                    .cover, // Ensures the image covers the entire container
                              ),
                            ),
                          ),
                        ),
                        SizedBox(height: 10),
                        // Adds some space between the image and the text
                        Text(
                          "العربية",
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      width: 25,
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        InkWell(
                          onTap: () async{

                             _changeLanguage(context, 'en');
                            _navigateToWelcomeScreen(context);
                          },
                          child: Container(
                            width: 120,
                            height: 100,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(18),
                            ),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(18),
                              // Same border radius as the container
                              child: Image.asset(
                                "assets/images1/icons/en_logo.png",
                                fit: BoxFit
                                    .cover, // Ensures the image covers the entire container
                              ),
                            ),
                          ),
                        ),
                        SizedBox(height: 10),
                        // Adds some space between the image and the text
                        Text(
                          "English",
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),


                  ],
                ),


              ],
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _changeLanguage(BuildContext context, String languageCode) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    Locale locale = Locale(languageCode);


    await prefs.setString('selectedLanguage', languageCode);
    await prefs.setBool('isLanguageSelected', true);


    await context.setLocale(locale);
  }


  void _navigateToWelcomeScreen(BuildContext context) {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => WellComePage()),  // Navigate to your welcome screen
    );
  }
}
