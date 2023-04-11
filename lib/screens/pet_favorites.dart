import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../blocs/favorite_list/favorite_list_cubit.dart';

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
          child: Text('Favorites Pet Breeds'),
        ),
      ),

      // builds a list of 5 cards with the pet's name, image, and a button to remove the pet from the favorites list
      body: BlocBuilder<FavoriteListCubit, FavoriteListState>(
        builder: (context, state) {
          if (state.status == FavoriteListStatus.loading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          if (state.status == FavoriteListStatus.error) {
            return Center(
              child: Text(state.error.message),
            );
          }
          // if list is empty show a message
          if (state.favorites.isEmpty) {
            return const Center(
              child: Text('No favorites yet'),
            );
          }
          return ListView.builder(
            itemCount: state.favorites.length,
            itemBuilder: (context, index) {
              return GestureDetector(
                onTap: () {
                  // navigate to pet details page
                  Navigator.pushNamed(
                    context,
                    '/pet_details',
                    arguments: state.favorites[index],
                  );
                },
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                      height: 120,
                      // cream background color and rounded edges
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Row(
                        children: [
                          // image of the pet
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Container(
                              height: 120,
                              width: 120,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                image: DecorationImage(
                                  image: NetworkImage(state.favorites[index].image),
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                          ),
                          // pet name and button to remove from favorites list
                          Expanded(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  state.favorites[index].name,
                                  style: const TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                const SizedBox(height: 10),
                                // button to remove from favorites list
                                ElevatedButton(
                                  onPressed: () {
                                    context.read<FavoriteListCubit>().removeFavorite(
                                          favorite: state.favorites[index],
                                        );
                                  },
                                  child: const Text('Remove from favorites'),
                                ),
                              ],
                            ),
                          ),
                        ],
                      )),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
