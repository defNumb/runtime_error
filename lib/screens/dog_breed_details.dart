// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../blocs/breed-provider/breed_provider_cubit.dart';

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
  Widget build(BuildContext context) {
    return BlocBuilder<BreedProviderCubit, BreedProviderState>(
      builder: (context, state) {
        return Scaffold(
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
