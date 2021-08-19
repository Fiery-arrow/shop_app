import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:shop_app/screens/landing_page.dart';
import 'package:shop_app/screens/main_screen.dart';

class UserState extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: FirebaseAuth.instance.authStateChanges(),
      // ignore: missing_return
      builder: (context, userSnapShot) {
        if (userSnapShot.connectionState == ConnectionState.waiting) {
          return Center(
            child: CircularProgressIndicator(),
          );
        } else if (userSnapShot.connectionState == ConnectionState.active) {
          if (userSnapShot.hasData) {
            return MainScreens();
          } else {
            return LandingPage();
          }
        } else if (userSnapShot.hasError) {
          return Center(
            child: Text("Error occurred"),
          );
        }
      },
    );
  }
}
