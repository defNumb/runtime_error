//import material
import 'package:flutter/material.dart';
import 'package:my_pets_app/screens/add_pet.dart';

class MyPetsPage extends StatefulWidget {
  static const String routeName = '/my_pets';
  const MyPetsPage({super.key});

  @override
  State<MyPetsPage> createState() => _MyPetsPageState();
}

class _MyPetsPageState extends State<MyPetsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.amber,
      appBar: AppBar(
        automaticallyImplyLeading: true,
        title: const Center(
          child: Text('My Pets Page'),
        ),
        // add pet button
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () {
              showModalBottomSheet<dynamic>(
                backgroundColor: Colors.transparent,
                isScrollControlled: true,
                context: context,
                builder: (BuildContext context) => AddPetScreen(),
              );
            },
          ),
        ],
      ),
      body: const Center(
        child: Text('My Pets Page'),
      ),
    );
  }
}
