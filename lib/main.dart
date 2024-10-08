import 'package:dio/dio.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:home_elite/Theming/myTheme_data.dart';
import 'package:home_elite/bloc_observer.dart';
import 'package:home_elite/pages/home_page/home_page.dart';
import 'package:home_elite/pages/login_page/login_page.dart';
import 'package:home_elite/pages/myAds_page/my_ads_page.dart';
import 'package:home_elite/pages/signUp_page/signup_cubit/signupPage.dart';
import 'package:home_elite/pages/signUp_page/signup_cubit/signup_cubit.dart';
import 'package:home_elite/pages/signUp_page/signup_verification.dart';
import 'package:home_elite/pages/wellcome_page/wellcome_page.dart';
import 'package:home_elite/splash_screen/splash.dart';
import 'package:home_elite/splash_screen/splash_screen.dart';
import 'package:home_elite/tabs/add_ads/buy_ads/add_buy_ads.dart';
import 'package:home_elite/tabs/add_ads/buy_ads/add_buy_ads_cubit.dart';
import 'package:home_elite/tabs/add_ads/rent_ads/add_rent_ads.dart';
import 'package:home_elite/tabs/add_ads/rent_ads/add_rent_ads_cubit.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:uni_links/uni_links.dart';

import 'auth_service.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();
  SharedPreferences prefs = await SharedPreferences.getInstance();
  String? selectedLanguage = prefs.getString('selectedLanguage');


  Locale initialLocale;
  if (selectedLanguage == 'Arabic') {
    initialLocale = Locale('ar');
  } else {
    initialLocale = Locale('en'); // Default to English if not set
  }
  Bloc.observer = MyBlocObserver();
  runApp(
      EasyLocalization(
        supportedLocales: [Locale('en'), Locale('ar')],
        path: 'assets/language', // Path to your translation files
        fallbackLocale: Locale('en'),
        startLocale: initialLocale,
        child: MultiBlocProvider(
            providers: [
        BlocProvider(
          create: (context) => AddRentAdsCubit(),
        ),
        BlocProvider(
          create: (context) => AddBuyAdsCubit(),
        ),
            ],
            child: MyApp(),
          ),
      ));
}

class MyApp extends StatefulWidget {
  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {

  final AuthService _authService = AuthService();


  @override
  void initState() {
    super.initState();
    _authService.handleCallbackUri(context);

    _handleDeepLink();
  }

  void _handleDeepLink() async {
    try {
      // Check if the app was opened via a deep link
      final initialUri = await getInitialUri();
      if (initialUri != null && initialUri.scheme == 'yourapp') {
        // Navigate to the page if the deep link matches
        if (initialUri.host == 'test') {
          Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => LoginPage(),
          ));
        }
      }
    } catch (e) {
      print("Failed to get initial deep link: $e");
    }
  }
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      localizationsDelegates: context.localizationDelegates,
      supportedLocales: context.supportedLocales,
      locale: context.locale,
      debugShowCheckedModeBanner: false,
      home: AnimatedSplashScreen(),

      routes: {
        '/login': (context) => LoginPage(),
        '/welcomePage': (context) => WellComePage(),
        '/home': (context) => HomePage(),
        '/signup': (context) => SignupPage(),
        // '/addAds2': (context) => AddAds2(),
        // '/signup2': (context) => SignupPage2(),
        '/signupVerification': (context) => SignupVerification(),
        '/AddBuyAds': (context) => AddBuyAds(),
        '/AddRentAds': (context) => AddRentAds(),
        '/myAdsPage': (context) => MyAdsPage(),
      },
    );
  }




}
