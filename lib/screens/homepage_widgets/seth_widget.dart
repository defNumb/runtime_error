import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_pets_app/constants/app_constants.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../blocs/breed-provider/breed_provider_cubit.dart';
import '../../models/custom_error.dart';
import '../../utils/error_dialog.dart';

class SethWidget extends StatefulWidget {
  const SethWidget({super.key});

  @override
  State<SethWidget> createState() => _SethWidgetState();
}

class _SethWidgetState extends State<SethWidget> {
  // get dog breeds from the cubit
  @override
  void initState() {
    super.initState();
    _getDogBreeds();
  }

  // get dog breeds from the cubit
  void _getDogBreeds() {
    context.read<BreedProviderCubit>().getDogBreeds();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<BreedProviderCubit, BreedProviderState>(
      builder: (context, state) {
        // if the state is loading, show a loading indicator
        if (state.status == BreedProviderStatus.loading) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
        final randomNumber = Random().nextInt(50);
        return Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            children: [
              // title : Pet of the week
              // this widget will be a container with a title and a picture of a random
              // pet from the cat or dog api
              Text(
                'Pet of the Day',
                style:
                    TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.grey[800]),
              ),

              // size box
              const SizedBox(
                height: 10,
              ),
              // container with a picture of a random pet
              Container(
                height: 200,
                width: 300,
                decoration: BoxDecoration(
                  color: tertiaryColor,
                  borderRadius: BorderRadius.circular(10),
                ),
                // child will contain a picture of a random pet
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: [
                      Container(
                        height: 150,
                        width: 150,
                        // rounded image
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Image.network(
                          state.dogBreeds[randomNumber].image!.url ?? '',
                          fit: BoxFit.fitHeight,
                        ),
                      ),
                      // size box
                      const SizedBox(
                        height: 10,
                      ),
                      // pet name
                      Flexible(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Text(
                              state.dogBreeds[randomNumber].name,
                              style: const TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                            InkWell(
                              onTap: () async {
                                // try to launch the url
                                if (state.dogBreeds[randomNumber].wikipediaUrl == null) {
                                  errorDialog(context,
                                      CustomError(message: 'No wikipedia url for this breed'));
                                  return;
                                }
                                try {
                                  await launchUrl(
                                      // if android, use the android url else use the ios url
                                      Uri.parse(state.dogBreeds[randomNumber].wikipediaUrl!));
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
