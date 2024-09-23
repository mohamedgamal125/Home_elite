import 'package:flutter/material.dart';
import 'package:uni_links/uni_links.dart';

class AuthService {
  void handleCallbackUri(BuildContext context) {
    uriLinkStream.listen((Uri? uri) async {
      if (uri != null) {
        if (uri.queryParameters.containsKey('token')) {
          final String? token = uri.queryParameters['token'];
          if (token != null) {

            print('Token received: $token');
            // Save the token and navigate to home page
          }
        } else if (uri.queryParameters.containsKey('login') && uri.queryParameters['login'] == 'true') {
          // Redirect to the login page if it's the user's first time signing up
          Navigator.of(context).pushReplacementNamed('/login'); // Adjust to your routing setup
        }
      }
    });
  }
}
