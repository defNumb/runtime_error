import 'package:flutter/material.dart';
import 'package:my_pets_app/screens/splash_screen.dart';

import 'screens/pet_favorites.dart';
import 'screens/signin_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  // This is the first widget that is called when the app is run
  // The home: property is the first screen that is displayed
  // in this case it is the SplashScreen

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const SplashScreen(),
      // routes
      routes: {
        '/favorite_pets': (context) => const PetFavoritesPage(),
        '/signin_page': (context) => const SigninPage(),
      },
    );
  }
}
