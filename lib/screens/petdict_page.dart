import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_pets_app/blocs/breed-provider/breed_provider_cubit.dart';

class PetDictionaryPage extends StatefulWidget {
  static const String routeName = '/pet-dictionary';
  const PetDictionaryPage({super.key});

  @override
  State<PetDictionaryPage> createState() => _PetDictionaryPageState();
}

class _PetDictionaryPageState extends State<PetDictionaryPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Pet Dictionary'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            // Container for dog breeds
            Container(
              width: 300,
              height: 200,
              decoration: BoxDecoration(
                color: Colors.blue,
                borderRadius: BorderRadius.circular(20),
              ),
              // child will be a button to a new page with a list of dog breeds.
              child: TextButton(
                onPressed: () {
                  context.read<BreedProviderCubit>().getDogBreeds();
                  Navigator.pushNamed(context, '/dog-breeds');
                },
                child: const Text('Dogs', style: TextStyle(color: Colors.white)),
              ),
            ),
            // Container for cat breeds
            Container(
              width: 300,
              height: 200,
              decoration: BoxDecoration(
                color: Colors.blue,
                borderRadius: BorderRadius.circular(20),
              ),
              child: TextButton(
                onPressed: () {
                  context.read<BreedProviderCubit>().getCatBreeds();
                  Navigator.pushNamed(context, '/cat-breeds');
                },
                child: const Text('Cats', style: TextStyle(color: Colors.white)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
