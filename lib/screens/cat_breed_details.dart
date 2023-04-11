// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:favorite_button/favorite_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../blocs/breed-provider/breed_provider_cubit.dart';
import '../blocs/favorite_badge/favorite_badge_cubit.dart';
import '../models/favorite_model.dart';

class CatBreedDetailsPage extends StatefulWidget {
  final int index;
  CatBreedDetailsPage({
    Key? key,
    required this.index,
  }) : super(key: key);

  @override
  State<CatBreedDetailsPage> createState() => _CatBreedDetailsPageState();
}

class _CatBreedDetailsPageState extends State<CatBreedDetailsPage> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<BreedProviderCubit, BreedProviderState>(
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            title: Text(state.catBreeds[widget.index].name),
          ),
          body: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Container(
                  height: 200,
                  width: 200,
                  child: Image.network(
                    state.catBreeds[widget.index].image!.url ?? '',
                  ),
                ),
                BlocBuilder<FavoriteBadgeCubit, FavoriteBadgeState>(
                  builder: (context, state) {
                    print(state.favorited);
                    return Padding(
                      padding: const EdgeInsets.fromLTRB(300, 15, 0, 15),
                      child: FavoriteButton(
                        iconSize: 50,
                        valueChanged: (favorited) async {
                          if (favorited) {
                            await context.read<FavoriteBadgeCubit>().addFavorite(
                                  favorite: Favorite(
                                    name: context
                                        .read<BreedProviderCubit>()
                                        .state
                                        .catBreeds[widget.index]
                                        .name,
                                    image: context
                                        .read<BreedProviderCubit>()
                                        .state
                                        .catBreeds[widget.index]
                                        .image!
                                        .url!,
                                    type: 'cat',
                                  ),
                                );
                          } else {
                            await context.read<FavoriteBadgeCubit>().removeFavorite(
                                  favorite: Favorite(
                                    name: context
                                        .read<BreedProviderCubit>()
                                        .state
                                        .catBreeds[widget.index]
                                        .name,
                                    image: context
                                        .read<BreedProviderCubit>()
                                        .state
                                        .catBreeds[widget.index]
                                        .image!
                                        .url!,
                                    type: 'cat',
                                  ),
                                );
                          }
                        },
                        isFavorite: context.read<FavoriteBadgeCubit>().state.favorited,
                      ),
                    );
                  },
                ),
                Text(
                  'Description',
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  state.catBreeds[widget.index].description ?? '',
                  style: const TextStyle(
                    fontSize: 15,
                  ),
                ),
                Text(
                  'Temperament',
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  state.catBreeds[widget.index].temperament ?? '',
                  style: const TextStyle(
                    fontSize: 15,
                  ),
                ),
                Text(
                  'Origin',
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  state.catBreeds[widget.index].origin ?? '',
                  style: const TextStyle(
                    fontSize: 15,
                  ),
                ),
                Text(
                  'Life Span',
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  state.catBreeds[widget.index].lifeSpan ?? '',
                  style: const TextStyle(
                    fontSize: 15,
                  ),
                ),
                Text(
                  'Wikipedia URL',
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  state.catBreeds[widget.index].wikipediaUrl ?? '',
                  style: const TextStyle(
                    fontSize: 15,
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
