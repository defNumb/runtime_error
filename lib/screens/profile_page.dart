import 'package:flutter/material.dart';

class UserProfilePage extends StatefulWidget {
  static const String routeName = '/user_profile';
  const UserProfilePage({super.key});

  @override
  State<UserProfilePage> createState() => _UserProfilePageState();
}

class _UserProfilePageState extends State<UserProfilePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.amber,
      appBar: AppBar(
        automaticallyImplyLeading: true,
        title: const Center(
          child: Text('User Profile Page'),
        ),
      ),
      body: const Center(
        // TODO: NIKKI COMPLETE THIS PAGE
        child: Text('User Profile Page'),
      ),
    );
  }
}
