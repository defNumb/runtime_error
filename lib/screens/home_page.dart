import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.amber,
      appBar: AppBar(
        title: const Center(
          child: Text('Home Page'),
        ),
      ),
      body: Column(
        children: [
          // Row with 3 buttons
          // 1st button is to visit the profile page
          // 2nd button is to visist the pet dictionary page
          // 3rd button is to visit the favorite pets page
          const SizedBox(
            height: 50,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              ElevatedButton(
                onPressed: () {},
                child: const Text('Profile'),
              ),
              ElevatedButton(
                onPressed: () {},
                child: const Text('Pet Dictionary'),
              ),
              ElevatedButton(
                onPressed: () {},
                child: const Text('Favorite Pets'),
              ),
            ],
          ),
          const Center(
            child: Text('Home Page'),
          ),
          const SizedBox(height: 500),
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
