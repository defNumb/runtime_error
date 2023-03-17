import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_pets_app/constants/app_constants.dart';

import '../blocs/Auth/auth_bloc.dart';

class HomePage extends StatefulWidget {
  static const String routeName = '/home_page';
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        backgroundColor: primaryColor,
        appBar: AppBar(
          automaticallyImplyLeading: false,
          title: const Center(
            child: Text('Home Page'),
          ),
          // actions with 3 buttons to visit the profile page, pet dictionary page,and favorite pets page
          actions: [
            IconButton(
              onPressed: () {},
              icon: const Icon(Icons.person),
            ),
            IconButton(
              onPressed: () {},
              icon: const Icon(Icons.pets),
            ),
            IconButton(
              onPressed: () {
                Navigator.pushNamed(context, '/favorite_pets');
              },
              icon: const Icon(Icons.favorite),
            ),
            IconButton(
              onPressed: () {},
              icon: const Icon(Icons.book),
            ),
          ],
        ),
        body: BlocBuilder<AuthBloc, AuthState>(
          builder: (context, state) {
            return Column(
              children: [
                const SizedBox(
                  height: 50,
                ),
                //
                //  TODO:    TASK 1
                // INSTRUCTIONS TASK # 1
                // In the home page, create a text widget that says "Home Page" - already done
                // create another text widget that says "Welcome, ${state.user.email}"
                // and add a paragraph widget that says "This team runtime_error project app.. etc etc"
                //
                //
                const Center(
                  child: Text('Home Page'),
                ),
                //
                // END OF TASK # 1
                //
                // sign out green button
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.green,
                  ),
                  onPressed: () {
                    context.read<AuthBloc>().add(SignoutRequestedEvent());
                  },
                  child: const Text('Sign Out'),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
