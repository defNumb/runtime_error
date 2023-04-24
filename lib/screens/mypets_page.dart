//import material
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_pets_app/screens/add_pet.dart';
import 'package:my_pets_app/utils/error_dialog.dart';

import '../blocs/pet_list/pet_list_cubit.dart';

class MyPetsPage extends StatefulWidget {
  static const String routeName = '/my_pets';
  const MyPetsPage({super.key});

  @override
  State<MyPetsPage> createState() => _MyPetsPageState();
}

class _MyPetsPageState extends State<MyPetsPage> {
  @override
  void initState() {
    super.initState();
    context.read<PetListCubit>().getPetList(uid: FirebaseAuth.instance.currentUser!.uid);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.amber,
      appBar: AppBar(
        automaticallyImplyLeading: true,
        title: const Center(
          child: Text('My Pets Page'),
        ),
        // add pet button
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () {
              showModalBottomSheet<dynamic>(
                backgroundColor: Colors.transparent,
                isScrollControlled: true,
                context: context,
                builder: (BuildContext context) => AddPetScreen(),
              );
            },
          ),
        ],
      ),
      body: BlocConsumer<PetListCubit, PetListState>(
        listener: (context, state) {
          if (state.listStatus == PetListStatus.error) {
            errorDialog(context, state.error);
          }
        },
        builder: (context, state) {
          if (state.listStatus == PetListStatus.loading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (state.listStatus == PetListStatus.loaded && state.petList.isEmpty) {
            return Center(
              child: Container(
                height: 100,
                width: 150,
                child: Flexible(
                    child:
                        Text('You haven\'t added any pets yet!, click the + button to add a pet')),
              ),
            );
          }
          // return a list of pets if there are any
          return ListView.builder(
            itemCount: state.petList.length,
            itemBuilder: (context, index) {
              return GestureDetector(
                onTap: () {
                  // navigate to pet details page
                },
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    height: 100,
                    width: 150,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Row(
                      children: [
                        // pet image
                        Container(
                          height: 100,
                          width: 100,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            image: DecorationImage(
                              image: Image.asset(state.petList[index].icon).image,
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        // pet name
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            state.petList[index].name,
                            style: const TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
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
