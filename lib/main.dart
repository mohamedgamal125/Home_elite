import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:home_elite/Theming/myTheme_data.dart';
import 'package:home_elite/bloc_observer.dart';
import 'package:home_elite/pages/home_page/home_page.dart';
import 'package:home_elite/pages/login_page/login_page.dart';
import 'package:home_elite/pages/signUp_page/signup_cubit/signupPage.dart';
import 'package:home_elite/pages/signUp_page/signup_cubit/signup_cubit.dart';
import 'package:home_elite/pages/signUp_page/signup_page2.dart';
import 'package:home_elite/pages/signUp_page/signup_verification.dart';
import 'package:home_elite/pages/wellcome_page/wellcome_page.dart';

void main() {
  Bloc.observer=MyBlocObserver();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: WellComePage(),
      theme: MythemeData.lightMode,
      routes: {
        '/login': (context) => LoginPage(),
        '/welcomePage': (context) => WellComePage(),
        '/home': (context) => HomePage(),
        '/signup': (context) => SignupPage(),
        // '/signup2': (context) => SignupPage2(),
        '/signupVerification': (context) => SignupVerification(),
      },
    );
  }
}
