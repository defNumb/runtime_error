import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_pets_app/blocs/favorite_badge/favorite_badge_cubit.dart';
import 'package:my_pets_app/constants/app_constants.dart';

import '../blocs/breed-provider/breed_provider_cubit.dart';
import 'dog_breed_details.dart';

class DogBreedsPage extends StatefulWidget {
  static const String routeName = '/dog-breeds';
  const DogBreedsPage({super.key});

  @override
  State<DogBreedsPage> createState() => _DogBreedsPageState();
}

class _DogBreedsPageState extends State<DogBreedsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: primaryColor,
      appBar: AppBar(
        title: const Text('Dog Breeds'),
      ),
      body: BlocBuilder<BreedProviderCubit, BreedProviderState>(
        builder: (context, state) {
          if (state.status == BreedProviderStatus.loading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          return ListView.builder(
            itemCount: state.dogBreeds.length,
            itemBuilder: (context, index) {
              return Center(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: GestureDetector(
                    onTap: () async {
                      // check if breed is favorited
                      await context
                          .read<FavoriteBadgeCubit>()
                          .checkFavorite(state.dogBreeds[index].name);
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => DogBreedDetailsPage(index: index)));
                    },
                    child: Container(
                      height: 150,
                      width: 350,
                      // color mustard and round borders with shadow
                      decoration: BoxDecoration(
                        color: quaternaryColor,
                        borderRadius: BorderRadius.circular(20),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.5),
                            spreadRadius: 5,
                            blurRadius: 7,
                            offset: const Offset(0, 3),
                          ),
                        ],
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Container(
                              height: 125,
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Image.network(state.dogBreeds[index].image!.url ?? ''),
                              )),
                          Flexible(
                              child: Text(state.dogBreeds[index].name,
                                  style: const TextStyle(fontSize: 12))),
                        ],
                      ),
                    ),
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
