import 'package:flutter/material.dart';

class PetFavoritesPage extends StatefulWidget {
  static const String routeName = '/favorite_pets';

  const PetFavoritesPage({super.key});

  @override
  State<PetFavoritesPage> createState() => _PetFavoritesPageState();
}

class _PetFavoritesPageState extends State<PetFavoritesPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.amber,
      appBar: AppBar(
        automaticallyImplyLeading: true,
        title: const Center(
          child: Text('Favorites Pets Page'),
        ),
      ),

      // builds a list of 5 cards with the pet's name, image, and a button to remove the pet from the favorites list
      body: ListView.builder(
        itemCount: 5,
        itemBuilder: (context, index) {
          return Card(
            child: ListTile(
              leading: const Icon(Icons.pets),
              title: const Text('Pet Name'),
              subtitle: const Text('Pet Description'),
              trailing: IconButton(
                onPressed: () {},
                icon: const Icon(Icons.delete),
              ),
            ),
          );
        },
      ),
    );
  }
}
