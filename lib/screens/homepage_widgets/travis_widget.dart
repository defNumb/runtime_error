import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_pets_app/constants/app_constants.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../blocs/breed-provider/breed_provider_cubit.dart';
import '../../models/custom_error.dart';
import '../../utils/error_dialog.dart';

// Statefull widget called TravisWidget that is a copy of the SethWidget
// but using Cat API instead of Dog API

class TravisWidget extends StatefulWidget {
  const TravisWidget({Key? key}) : super(key: key);

  @override
  State<TravisWidget> createState() => _TravisWidgetState();
}

class _TravisWidgetState extends State<TravisWidget> {
  @override
  void initState() {
    super.initState();
    _getCatBreeds();
  }

  void _getCatBreeds() {
    context.read<BreedProviderCubit>().getCatBreeds();
  }

  @override
  Widget build(BuildContext context) {
    // return scaffold wrapped in a blocbuilder
    return BlocBuilder<BreedProviderCubit, BreedProviderState>(
      builder: (context, state) {
        // if the state is loading, show a loading indicator
        if (state.status == BreedProviderStatus.loading) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
        // if catbreeds is empty, show a text widget
        if (state.catBreeds.isEmpty) {
          return const Text('No cat breeds found');
        }
        // create a random number
        final randomNumber = Random().nextInt(50);

        return Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            children: [
              Text(
                'Cat of the Day',
                style:
                    TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.grey[800]),
              ),
              // size box
              const SizedBox(
                height: 10,
              ),
              // container with a picture of a random pet
              Container(
                height: 250,
                width: 250,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: tertiaryColor,
                ),
                child: Padding(
                  padding: const EdgeInsets.all(25.0),
                  child: Column(
                    children: [
                      Container(
                        height: 150,
                        width: 150,
                        // rounded image
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: state.catBreeds[randomNumber].image == null
                            ? Placeholder()
                            : Image.network(
                                state.catBreeds[randomNumber].image!.url!,
                                fit: BoxFit.fitHeight,
                              ),
                      ),
                      // size box
                      const SizedBox(
                        height: 10,
                      ),
                      // pet name
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Text(
                            state.catBreeds[randomNumber].name,
                            style: const TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                          InkWell(
                            onTap: () async {
                              // try to launch the url
                              if (state.catBreeds[randomNumber].cfaUrl == null) {
                                errorDialog(context,
                                    CustomError(message: 'No wikipedia url for this breed'));
                                return;
                              }
                              try {
                                await launchUrl(
                                    // if android, use the android url else use the ios url
                                    Uri.parse(state.catBreeds[randomNumber].cfaUrl!));
                              } catch (e) {
                                errorDialog(context, CustomError(message: e.toString()));
                              }
                            },
                            child: const Text(
                              'Learn More',
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                                color: Colors.black,
                              ),
                            ),
                          ),
                        ],
                      ),
                      // pet breed
                    ],
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
