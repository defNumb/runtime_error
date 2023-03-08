import 'package:flutter/material.dart';
import 'package:my_pets_app/constants/app_constants.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: primaryColor,
      appBar: AppBar(
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
      body: Column(
        children: [
          const SizedBox(
            height: 50,
          ),
          const Center(
            child: Text('Home Page'),
          ),

          // sign out green button
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.green,
            ),
            onPressed: () {},
            child: const Text('Sign Out'),
          ),
        ],
      ),
    );
  }
}
