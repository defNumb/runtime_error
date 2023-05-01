import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_pets_app/constants/app_constants.dart';
import 'package:my_pets_app/utils/error_dialog.dart';
import '../blocs/breed-provider/breed_provider_cubit.dart';
import '../blocs/favorite_badge/favorite_badge_cubit.dart';
import 'cat_breed_details.dart';

class CatBreedsPage extends StatefulWidget {
  static const String routeName = '/cat-breeds';
  const CatBreedsPage({super.key});

  @override
  State<CatBreedsPage> createState() => _CatBreedsPageState();
}

class _CatBreedsPageState extends State<CatBreedsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: quaternaryColor,
      appBar: AppBar(
        title: const Text('Cat Breeds'),
      ),
      body: BlocListener<BreedProviderCubit, BreedProviderState>(
        listener: (context, state) {
          if (state.status == BreedProviderStatus.error) {
            return errorDialog(context, state.error);
          }
        },
        child: BlocBuilder<BreedProviderCubit, BreedProviderState>(
          builder: (context, state) {
            if (state.status == BreedProviderStatus.loading) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
            return ListView.builder(
              itemCount: state.catBreeds.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Center(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: GestureDetector(
                        onTap: () async {
                          await context
                              .read<FavoriteBadgeCubit>()
                              .checkFavorite(state.catBreeds[index].name);
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => CatBreedDetailsPage(index: index)));
                        },
                        child: Container(
                          height: 150,
                          width: 350,
                          // color mustard and round borders with shadow
                          decoration: BoxDecoration(
                            color: primaryColor,
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
                                    child: state.catBreeds[index].image == null
                                        ? Placeholder(
                                            fallbackWidth: 50,
                                          )
                                        : Image.network(state.catBreeds[index].image!.url ?? ''),
                                  )),
                              Flexible(
                                  child: Text(state.catBreeds[index].name,
                                      style: const TextStyle(fontSize: 12))),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                );
              },
            );
          },
        ),
      ),
    );
  }
}
