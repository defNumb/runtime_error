//import material
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_pets_app/blocs/breed-provider/breed_provider_cubit.dart';
import 'package:my_pets_app/constants/app_constants.dart';
import 'package:my_pets_app/models/dog_api_model.dart';

import '../blocs/pet_list/pet_list_cubit.dart';
import '../blocs/signup_pet/signup_pet_cubit.dart';
import '../models/cat_api_model.dart';
import '../models/pet_model.dart';
import '../utils/input_formatters.dart';
import '../utils/text_utils.dart';

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
  AutovalidateMode _autoValidateMode = AutovalidateMode.disabled;
  String? _name,
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
      icon: _species == 'Dog' ? 'assets/images/dog_icon.png' : 'assets/images/cat_icon.png',
      name: _name!,
      breed: _breed ?? 'Dog',
      breed2: _breed2 ?? '',
      species: _species!,
      gender: _gender ?? '',
      weight: _weight ?? '',
      birthDay: _birthDay ?? '',
      healthConditions: '',
      neutered: _neutered ?? 'No',
      backgroundImage: _backgroundImage ?? '',
      referenceId: '',
    );
    context
        .read<SignupPetCubit>()
        .createPet(pet: newPet, uid: FirebaseAuth.instance.currentUser!.uid);
    context.read<PetListCubit>().updatePetList(uid: FirebaseAuth.instance.currentUser!.uid);
    Navigator.of(context).pop();
  }

  void _getDogBreeds() {
    context.read<BreedProviderCubit>().getDogBreeds();
  }

  void _getCatBreeds() {
    context.read<BreedProviderCubit>().getCatBreeds();
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
                  child: FormField(
                    builder: (FormFieldState<String> state) {
                      return InputDecorator(
                        decoration: InputDecoration(
                            errorStyle: TextStyle(color: Colors.redAccent, fontSize: 16.0),
                            border: OutlineInputBorder(borderRadius: BorderRadius.circular(5.0))),
                        isEmpty: _species == 'Dog',
                        child: DropdownButtonHideUnderline(
                          child: DropdownButton<String>(
                            value: _species,
                            isExpanded: true,
                            isDense: true,
                            onChanged: (String? newValue) {
                              setState(() {
                                if (newValue == 'Dog') {
                                  _getDogBreeds();
                                } else if (newValue == 'Cat') {
                                  _getCatBreeds();
                                }
                                _species = newValue;
                                state.didChange(newValue);
                              });
                            },
                            items: speciesList.map<DropdownMenuItem<String>>((String value) {
                              return DropdownMenuItem<String>(
                                value: value,
                                child: Text(value),
                              );
                            }).toList(),
                          ),
                        ),
                      );
                    },
                    autovalidateMode: _autoValidateMode,
                  ),
                ),
                ////////////////////////////////////
                /// END OF SPECIES FIELD
                ///
                ////////////////////////////////////
                /// THIS IS A FORM FIELD FOR THE BREED
                ///
                ///
                BlocBuilder<BreedProviderCubit, BreedProviderState>(
                  builder: (context, state) {
                    return Padding(
                      padding: const EdgeInsets.all(15),
                      child: FormField(
                        builder: (FormFieldState<String> formFieldstate) {
                          return InputDecorator(
                            decoration: InputDecoration(
                                errorStyle: TextStyle(color: Colors.redAccent, fontSize: 16.0),
                                border:
                                    OutlineInputBorder(borderRadius: BorderRadius.circular(5.0))),
                            child: DropdownButtonHideUnderline(
                              child: DropdownButton<String>(
                                value: _breed,
                                isExpanded: true,
                                isDense: true,
                                onChanged: (String? newValue) {
                                  setState(() {
                                    _breed = newValue;
                                    formFieldstate.didChange(newValue);
                                  });
                                },
                                items: _species == 'Dog'
                                    ? state.dogBreeds
                                        .map<DropdownMenuItem<String>>((DogBreed value) {
                                        return DropdownMenuItem<String>(
                                          value: value.name,
                                          child: Text(value.name),
                                        );
                                      }).toList()
                                    : state.catBreeds
                                        .map<DropdownMenuItem<String>>((CatBreed value) {
                                        return DropdownMenuItem<String>(
                                          value: value.name,
                                          child: Text(value.name),
                                        );
                                      }).toList(),
                              ),
                            ),
                          );
                        },
                      ),
                    );
                  },
                ),

                ///
                /// END OF BREED FIELD
                /// //////////////////////////////////
                /// THIS IS A FORM FIELD FOR THE BIRTHDAY
                /// //////////////////////////////////
                ///
                Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: TextFormField(
                    inputFormatters: [
                      FilteringTextInputFormatter.digitsOnly,
                      LengthLimitingTextInputFormatter(8),
                      DateInputFormatter(),
                    ],
                    autocorrect: false,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      filled: true,
                      fillColor: Colors.white70,
                      hintText: 'dd/mm/aaaa',
                    ),
                    validator: (value) {
                      return TextUtils.validateDate(value);
                    },
                    keyboardType: TextInputType.datetime,
                    onSaved: (value) {
                      _birthDay = value.toString();
                    },
                  ),
                ),
                // submit button
                Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: ElevatedButton(
                    onPressed: _submit,
                    child: const Text('Submit'),
                  ),
                ),
              ],
            ),
          ),
        ]),
      ),
    );
  }
}
