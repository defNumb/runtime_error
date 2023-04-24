import 'dart:math';

import 'package:flutter/material.dart';
import 'package:my_pets_app/blocs/breed-provider/breed_provider_cubit.dart';

class SethWidget extends StatelessWidget {
  const SethWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 300,
      width: 100,
      color: Colors.red,
      child: Column(
        children: [
          Flexible(flex: 2, child: Center(child: Text("Explore Dog breeds"))),
          Flexible(
            flex: 10,
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.all(12),
              itemCount: 20,
              separatorBuilder: (context, index) {
                return const SizedBox(width: 60);
              },
              itemBuilder: (context, index) {
                return buildBreedCard(index);
              },
            ),
          )
        ],
      )
    );

    /*return Container(
      height: 300,
      width: 100,
      color: Colors.red,
      child: Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Text("Dog"),
            Text("Cat"),
            Text("Dog"),
            Text("Cat")
          ],
        ),
        // this is what i want my widget to do
        // Pull a 
      ),
    );*/
  }
}

Widget buildBreedCard(int index) => Column(
  mainAxisSize: MainAxisSize.min,
  children: [
    Text("Card $index"), // TODO: Animal Breed title
    ClipRRect(
      borderRadius: BorderRadius.circular(20),
      child: Image.asset(
        'assets/images/dog_icon.png', // TODO: Animal Breed image
        height: 150,
        width: 150,
        fit: BoxFit.cover,
      )
    )
  ],
);
