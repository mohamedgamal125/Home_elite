import 'dart:async';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../pages/home_page/home_page.dart';
import '../pages/login_page/login_page.dart';

class AnimatedSplashScreen extends StatefulWidget {
  @override
  _AnimatedSplashScreenState createState() => _AnimatedSplashScreenState();
}

class _AnimatedSplashScreenState extends State<AnimatedSplashScreen> with TickerProviderStateMixin {
  bool _moveToRight = false;
  bool _moveBigCircleToCenter = false;
  Widget ?startPage;

  Future<void> _checkToken()async{
    final SharedPreferences pref = await SharedPreferences.getInstance();
    final String? token= pref.getString('token');

    print("==========Token=========");
    print(token);
    setState(() {
      if(token !=null && token.isNotEmpty)
      {
        startPage=HomePage();
      }
      else
        startPage=LoginPage();
    });
  }
  @override
  void initState() {
    super.initState();
    _checkToken();

    // Start the first animation after a short delay
    Timer(Duration(milliseconds: 300), () {
      setState(() {
        _moveToRight = true;
      });

      // After moving to the right, move only the big circle to the center
      Timer(Duration(milliseconds: 500), () {  // Faster transition to the center
        setState(() {
          _moveBigCircleToCenter = true;
        });
      });
    });

    // Navigate to another page after 3 seconds (adjust based on your needs)
    Timer(Duration(seconds: 3), () {

      Navigator.of(context).pushReplacement(MaterialPageRoute(
        builder: (context) => startPage!,
      ));
    });
  }

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    return Scaffold(
      body: Stack(
        children: [
          // Big circle moves to center with faster speed
          AnimatedPositioned(
            duration: Duration(milliseconds: 700), // Reduced duration for faster animation
            curve: Curves.easeInOut,
            left: _moveBigCircleToCenter
                ? screenSize.width / 2 - 100
                : _moveToRight
                ? screenSize.width - 200
                : 70, // Starting position of the big circle with space
            bottom: _moveBigCircleToCenter
                ? screenSize.height / 2 - 100
                : _moveToRight
                ? 50
                : 50,
            child: AnimatedOpacity(
              duration: Duration(milliseconds: 700),
              opacity: _moveBigCircleToCenter ? 0.5 : 0.8,
              child: Container(
                width: 200,
                height: 200,
                decoration: BoxDecoration(
                  color: Colors.grey.withOpacity(0.1),
                  shape: BoxShape.circle,
                ),
              ),
            ),
          ),
          // Small circle remains stationary
          Positioned(
            left: 20, // Fixed starting position of the small circle
            bottom: 100, // Fixed position at the bottom-left
            child: Container(
              width: 100,
              height: 100,
              decoration: BoxDecoration(
                color: Colors.grey.withOpacity(0.1),
                shape: BoxShape.circle,
              ),
            ),
          ),
          // Logo at the center
          Center(
            child: Image.asset(
              'assets/images1/newLogo.png', // Add your logo image here
              width: 300,
              height: 300,
            ),
          ),
        ],
      ),
    );
  }
}
