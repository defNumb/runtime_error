//import material
import 'package:flutter/material.dart';
import 'package:my_pets_app/constants/app_constants.dart';

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
          // TODO: COMPLETE THE FORM AND ITS FIELDS
          const Text('CHANGE THIS'),
        ]),
      ),
    );
  }
}
