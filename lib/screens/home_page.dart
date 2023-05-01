import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_pets_app/blocs/user_profile/user_profile_cubit.dart';
import 'package:my_pets_app/constants/app_constants.dart';
import 'package:my_pets_app/screens/homepage_widgets/sam_widget.dart';
import 'package:my_pets_app/screens/homepage_widgets/seth_widget.dart';
import 'package:my_pets_app/screens/homepage_widgets/travis_widget.dart';

import '../blocs/Auth/auth_bloc.dart';
import '../blocs/favorite_list/favorite_list_cubit.dart';

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
              onPressed: () {
                Navigator.pushNamed(context, '/user_profile');
              },
              icon: const Icon(Icons.person),
            ),
            IconButton(
              onPressed: () {
                Navigator.pushNamed(context, '/my_pets');
              },
              icon: const Icon(Icons.pets),
            ),
            IconButton(
              onPressed: () {
                // read favorite list
                context
                    .read<FavoriteListCubit>()
                    .getFavorites(uid: FirebaseAuth.instance.currentUser!.uid);
                Navigator.pushNamed(context, '/favorite_pets');
              },
              icon: const Icon(Icons.favorite),
            ),
            IconButton(
              onPressed: () {
                Navigator.pushNamed(context, '/pet-dictionary');
              },
              icon: const Icon(Icons.book),
            ),
          ],
        ),
        body: BlocBuilder<UserProfileCubit, UserProfileState>(
          builder: (context, state) {
            return ListView(
              children: [
                const SizedBox(
                  height: 50,
                ),
                //

                Center(
                  child: Title(
                    color: Colors.green,
                    child: Text(
                      'My Pet Dictionary',
                      style: TextStyle(
                        fontSize: 30,
                        fontFamily: 'Quicksand',
                        fontWeight: FontWeight.bold,
                        color: Colors.teal,
                      ),
                    ),
                  ),
                ),
                Center(
                  child: Title(
                    color: Colors.black,
                    child: Text('Welcome, ${state.user.name}'),
                  ),
                ),
                const SizedBox(
                  height: 50,
                ),

                //
                //
                SethWidget(),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: const Divider(
                    color: Colors.grey,
                    thickness: 1,
                  ),
                ),
                SamWidget(),
                TravisWidget(),
                // sign out green button
              ],
            );
          },
        ),
      ),
    );
  }
}
