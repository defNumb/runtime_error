// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:favorite_button/favorite_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_pets_app/constants/app_constants.dart';
import 'package:my_pets_app/utils/error_dialog.dart';
import '../blocs/breed-provider/breed_provider_cubit.dart';
import '../blocs/favorite_badge/favorite_badge_cubit.dart';
import '../models/favorite_model.dart';

class DogBreedDetailsPage extends StatefulWidget {
  final int index;
  const DogBreedDetailsPage({
    Key? key,
    required this.index,
  }) : super(key: key);

  @override
  State<DogBreedDetailsPage> createState() => _DogBreedDetailsPageState();
}

class _DogBreedDetailsPageState extends State<DogBreedDetailsPage> {
  @override
  void initState() {
    super.initState();
    _checkIfProductIsFavorite();
  }

  Future<void> _checkIfProductIsFavorite() async {
    await context
        .read<FavoriteBadgeCubit>()
        .checkFavorite(context.read<BreedProviderCubit>().state.dogBreeds[widget.index].name);
    print('check if favorite');
    print(await context.read<FavoriteBadgeCubit>().state.favorited);
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<BreedProviderCubit, BreedProviderState>(
      listener: (context, state) {
        if (state.status == BreedProviderStatus.error) {
          errorDialog(context, state.error);
        }
      },
      builder: (context, state) {
        if (state.status == BreedProviderStatus.loading) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else if (state.status == BreedProviderStatus.error) {
          return const Center(
            child: Text('Error'),
          );
        }
        return Scaffold(
          backgroundColor: primaryColor,
          appBar: AppBar(
            title: Text(state.dogBreeds[widget.index].name),
          ),
          body: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Container(
                  height: 200,
                  width: 200,
                  child: Image.network(
                    state.dogBreeds[widget.index].image!.url ?? '',
                  ),
                ),
                // Text(
                //   'Description',
                //   style: const TextStyle(
                //     fontSize: 20,
                //     fontWeight: FontWeight.bold,
                //   ),
                // ),
                // Text(
                //   state.dogBreeds[widget.index].description ?? '',
                //   style: const TextStyle(
                //     fontSize: 15,
                //   ),
                // ),
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
                                          .dogBreeds[widget.index]
                                          .name,
                                      image: context
                                          .read<BreedProviderCubit>()
                                          .state
                                          .dogBreeds[widget.index]
                                          .image!
                                          .url!,
                                      type: 'dog'),
                                );
                          } else {
                            await context.read<FavoriteBadgeCubit>().removeFavorite(
                                  favorite: Favorite(
                                    name: context
                                        .read<BreedProviderCubit>()
                                        .state
                                        .dogBreeds[widget.index]
                                        .name,
                                    image: context
                                        .read<BreedProviderCubit>()
                                        .state
                                        .dogBreeds[widget.index]
                                        .image!
                                        .url!,
                                    type: 'dog',
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
                  'Temperament',
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  state.dogBreeds[widget.index].temperament ?? '',
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
                  state.dogBreeds[widget.index].lifeSpan ?? '',
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
                  state.dogBreeds[widget.index].origin ?? '',
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
