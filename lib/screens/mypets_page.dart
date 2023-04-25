//import material
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_pets_app/blocs/signup_pet/signup_pet_cubit.dart';
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
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        // pet image
                        Padding(
                          padding: const EdgeInsets.fromLTRB(20, 0, 0, 0),
                          child: Container(
                            height: 50,
                            width: 50,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              image: DecorationImage(
                                image: Image.asset(state.petList[index].icon).image,
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                        ),
                        // size box

                        Column(
                          children: [
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
                            // pet breed
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                state.petList[index].breed,
                                style: const TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            // pet age
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                state.petList[index].birthDay,
                                style: const TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ],
                        ),
                        // DELETE PET BUTTON

                        IconButton(
                          color: Colors.red,
                          onPressed: () => showDialog<String>(
                            context: context,
                            builder: (BuildContext context) => AlertDialog(
                              title: const Text('Confirmation'),
                              content: const Text('Confirm delete pet?'),
                              actions: <Widget>[
                                TextButton(
                                  onPressed: () => Navigator.pop(context, 'Cancel'),
                                  child: const Text('Cancel'),
                                ),
                                TextButton(
                                  onPressed: () async {
                                    await context.read<SignupPetCubit>().deletePet(
                                          petId: state.petList[index].id,
                                        );
                                    await context
                                        .read<PetListCubit>()
                                        .getPetList(uid: FirebaseAuth.instance.currentUser!.uid);
                                    Navigator.pop(context, 'OK');
                                  },
                                  child: const Text('OK'),
                                ),
                              ],
                            ),
                          ),
                          icon: const Icon(
                            Icons.delete_outline,
                          ),
                        )
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
