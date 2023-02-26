import 'package:flutter/material.dart';
import 'package:my_pets_app/screens/home_page.dart';
import 'package:my_pets_app/screens/signin_page.dart';

// The SplashScreen is the first screen that is displayed and helps us
// to decide which screen to display next depending on the authentication status
// of the user. If the user is authenticated then we display the HomePage
// otherwise we display the SignupPage

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  // this is a temporary variable to simulate the authentication status
  bool status = true;

  @override
  Widget build(BuildContext context) {
    //  here we are using a ternary operator to decide which screen to display
    //  depending on the value of the status variable
    if (status == true) {
      return const HomePage();
    } else if (status == false) {
      return const SignupPage();
    }
    return const CircularProgressIndicator();
  }
}
