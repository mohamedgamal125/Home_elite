import 'package:flutter/material.dart';
import 'package:home_elite/pages/login_page/login_page.dart';
import 'package:home_elite/pages/wellcome_page/wellcome_page.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../pages/home_page/home_page.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>

    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<Offset> _positionAnimation;
  late Animation<double> _initialFlipAnimation;
  late Animation<double> _zoomFlipAnimation;
  late Animation<Offset> _finalPositionAnimation;
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

    _controller = AnimationController(
      vsync: this,
      duration: Duration(seconds: 4), // Total duration of the splash screen
    );

    // Position animation from bottom center to center
    _positionAnimation = Tween<Offset>(
      begin: Offset(0, 1), // Start at the bottom center
      end: Offset(0, 0), // Move to the center
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: Interval(0.0, 0.5, curve: Curves.easeInOut), // 50% of the total duration
    ));

    // First flip (without zoom) - faster flip
    _initialFlipAnimation = Tween<double>(
      begin: 0,
      end: 1,
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: Interval(0.5, 0.6, curve: Curves.easeInOut), // 10% of the total duration
    ));

    // Second flip with zoom - faster flip
    _zoomFlipAnimation = Tween<double>(
      begin: 0,
      end: 1,
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: Interval(0.7, 0.8, curve: Curves.easeInOut), // 10% of the total duration
    ));

    _finalPositionAnimation = Tween<Offset>(
      begin: Offset(0, 0),
      end: Offset(0, -0.2), // Move the logo upwards slightly
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: Interval(0.8, 1.0, curve: Curves.easeInOut), // Last 20% of the duration
    ));
    _controller.forward().then((_) {
      Navigator.of(context).pushReplacement(MaterialPageRoute(
        builder: (context) => startPage!,
      ));
    });
    _checkToken();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Center(
        child: AnimatedBuilder(
          animation: _controller,
          builder: (context, child) {
            // Combined transformations
            double rotation = _initialFlipAnimation.value * 3.1416;
            double scale = 1.0;
            if (_zoomFlipAnimation.value > 0) {
              rotation += _zoomFlipAnimation.value * 3.1416;
              scale +=  _zoomFlipAnimation.value;
            }

            return Transform.translate(
              offset: _finalPositionAnimation.value+_positionAnimation.value,
              child: Transform(
                alignment: Alignment.center,
                transform: Matrix4.identity()
                  ..rotateY(rotation) // Apply both flips
                  ..scale(scale), // Apply zoom
                child: LogoWidget(),
              ),
            );
          },
        ),
      ),
    );
  }
}

class LogoWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Image.asset(
      'assets/images/black_logo.png', // Replace with your logo asset path
      width: 200,
      height: 200,
    );
  }
}


