//import material
import 'package:flutter/material.dart';
import 'package:my_pets_app/constants/app_constants.dart';

import '../models/pet_model.dart';

class AddPetScreen extends StatefulWidget {
  static const String routeName = '/add_pet';
  const AddPetScreen({super.key});

  @override
  State<AddPetScreen> createState() => _AddPetScreenState();
}

class _AddPetScreenState extends State<AddPetScreen> {
  //
  // THIS SETS UP VARIABLES FOR THE FORM TO SUBMIT TO THE DATABASE
  //
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _passwordController = TextEditingController();
  AutovalidateMode _autoValidateMode = AutovalidateMode.disabled;
  String? _name,
      _icon,
      _species,
      _breed,
      _breed2,
      _gender,
      _birthDay,
      _weight,
      _neutered,
      _backgroundImage;
  void _submit() {
    setState(() {
      _autoValidateMode = AutovalidateMode.always;
    });
    final form = _formKey.currentState;
    if (form == null || !form.validate()) {
      return;
    }

    form.save();
    Pet newPet = Pet(
      id: '',
      icon: _icon ?? 'assets/images/dog_icon.png',
      name: _name!,
      breed: _breed ?? 'Perro',
      breed2: _breed2 ?? '',
      species: _species!,
      gender: _gender ?? '',
      weight: _weight!,
      birthDay: _birthDay!,
      healthConditions: '',
      neutered: _neutered ?? 'No',
      backgroundImage: _backgroundImage ?? '',
      referenceId: '',
    );
    // context
    //     .read<SignupPetCubit>()
    //     .createPet(pet: newPet, uid: FirebaseAuth.instance.currentUser!.uid);
    // context.read<PetListCubit>().updatePetList(uid: FirebaseAuth.instance.currentUser!.uid);
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.95,
      // rounded top corners
      decoration: const BoxDecoration(
        color: primaryColor,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(50, 0, 50, 10),
            child: Divider(
              color: Colors.black54,
              thickness: 2,
            ),
          ),
          Form(
            key: _formKey,
            autovalidateMode: _autoValidateMode,
            child: ListView(
              shrinkWrap: true,
              children: [
                const SizedBox(height: 15),
                Padding(
                  padding: const EdgeInsets.fromLTRB(15, 0, 0, 10),
                  child: Row(
                    children: const [
                      Text('Please fill in the following required fields',
                          style: TextStyle(color: Colors.black)),
                      Padding(
                        padding: EdgeInsets.only(left: 2.0),
                        child: Text('*', style: TextStyle(color: Colors.red)),
                      ),
                    ],
                  ),
                ),
                ////////////////////////////////////
                // THIS IS A FORM FIELD FOR THE NAME
                // IF YOU
                Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: TextFormField(
                    decoration: InputDecoration(
                      fillColor: Colors.white70,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      filled: true,
                      labelText: 'Pet Name',
                      prefixIcon: Icon(Icons.account_box),
                    ),
                    validator: (String? value) {
                      if (value == null || value.trim().isEmpty) {
                        return 'Please enter a name';
                      }
                      if (value.trim().length < 3) {
                        return 'The name must be at least 3 characters long';
                      }
                      return null;
                    },
                    onSaved: (String? value) {
                      _name = value;
                    },
                  ),
                ),
                // END OF NAME FIELD
                ////////////////////////////////////
                // THIS IS A FORM FIELD FOR THE SPECIES
                //
                Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: TextFormField(
                    decoration: InputDecoration(
                      fillColor: Colors.white70,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      filled: true,
                      labelText: 'Species',
                      prefixIcon: Icon(Icons.pets),
                    ),
                    validator: (String? value) {
                      if (value == null || value.trim().isEmpty) {
                        return 'Please enter a species';
                      }
                      if (value.trim().length < 3) {
                        return 'The species must be at least 3 characters long';
                      }
                      return null;
                    },
                    onSaved: (String? value) {
                      _species = value;
                    },
                  ),
                  // END OF SPECIES FIELD
                  //
                ),
              ],
            ),
          ),
          const Text('CHANGE THIS'),
        ]),
      ),
    );
  }
}
