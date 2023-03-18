import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_pets_app/screens/home_page.dart';
import 'package:my_pets_app/screens/signin_page.dart';
import '../blocs/Auth/auth_bloc.dart';

// The SplashScreen is the first screen that is displayed and helps us
// to decide which screen to display next depending on the authentication status
// of the user. If the user is authenticated then we display the HomePage
// otherwise we display the SignupPage

class SplashScreen extends StatelessWidget {
  static const String routeName = '/';

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthBloc, AuthState>(
      listener: (context, state) {
        if (state.authStatus == AuthStatus.unauthenticated) {
          Navigator.of(context).pushNamed(SigninPage.routeName);
        } else if (state.authStatus == AuthStatus.authenticated ||
            state.authStatus == AuthStatus.anonymous) {
          Navigator.of(context).pushNamed(HomePage.routeName);
        }
      },
      builder: (context, state) {
        return Scaffold(
          body: Center(
            child: CircularProgressIndicator(),
          ),
        );
      },
    );
  }
}
