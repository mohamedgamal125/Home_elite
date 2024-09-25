import 'package:flutter/material.dart';
import 'package:uni_links/uni_links.dart';

class AuthService {
  void handleCallbackUri(BuildContext context) {
    uriLinkStream.listen((Uri? uri) async {
      if (uri != null) {
        final bool isFirstTime = uri.queryParameters['firstTime'] == 'true';
        final String? token = uri.queryParameters['token'];

        if (token != null) {
          // Handle successful login for returning users
          print('Token received: $token');
          // Save the token and navigate to the home page
          // Navigate to the home page
        }

        //yourapp://auth?firstTime=true
        // If it's the first time, redirect to the login page
        if (isFirstTime) {
          Navigator.of(context).pushReplacementNamed('/login');
        } else {
          // Navigate to home page for returning users
          Navigator.of(context).pushReplacementNamed('/home'); // Adjust to your routing setup
        }
      }
    });
  }
}
