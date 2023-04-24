import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_pets_app/blocs/Auth/auth_bloc.dart';
import 'package:my_pets_app/utils/error_dialog.dart';
import 'package:firebase_auth/firebase_auth.dart' as fbAuth;
import '../blocs/user_profile/user_profile_cubit.dart';
import '../../models/user_model.dart';

class UserProfilePage extends StatefulWidget {
  static const String routeName = '/user_profile';
  const UserProfilePage({super.key});

  @override
  State<UserProfilePage> createState() => _UserProfilePageState();
}

class _UserProfilePageState extends State<UserProfilePage> {
// validate mode
  AutovalidateMode _autoValidateMode = AutovalidateMode.disabled;
  // Form key
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  // form fields variables
  String? _name, _lastName, _phoneNumber, _email;
  // submit form
  void _submitForm() {
    setState(() {
      _autoValidateMode = AutovalidateMode.always;
    });
    final form = _formKey.currentState;
    if (form == null || !form.validate()) {
      return;
    }
    form.save();
    // new user
    User newUser = User(
      id: BlocProvider.of<UserProfileCubit>(context).state.user.id,
      name: _name ?? BlocProvider.of<UserProfileCubit>(context).state.user.name,
      lastName: _lastName ?? BlocProvider.of<UserProfileCubit>(context).state.user.lastName,
      email: _email ?? fbAuth.FirebaseAuth.instance.currentUser!.email!,
      point: BlocProvider.of<UserProfileCubit>(context).state.user.point,
      rank: BlocProvider.of<UserProfileCubit>(context).state.user.rank,
      phoneNumber:
          _phoneNumber ?? BlocProvider.of<UserProfileCubit>(context).state.user.phoneNumber,
      dateJoined: BlocProvider.of<UserProfileCubit>(context).state.user.dateJoined,
      emailVerified: BlocProvider.of<UserProfileCubit>(context).state.user.emailVerified,
      phoneVerified: BlocProvider.of<UserProfileCubit>(context).state.user.phoneVerified,
      isSubscribed: BlocProvider.of<UserProfileCubit>(context).state.user.isSubscribed,
      location: BlocProvider.of<UserProfileCubit>(context).state.user.location,
      orderNotification: BlocProvider.of<UserProfileCubit>(context).state.user.orderNotification,
      promotionNotification:
          BlocProvider.of<UserProfileCubit>(context).state.user.promotionNotification,
      postNotification: BlocProvider.of<UserProfileCubit>(context).state.user.postNotification,
      isOnline: BlocProvider.of<UserProfileCubit>(context).state.user.isOnline,
    );

    // update user info
    BlocProvider.of<UserProfileCubit>(context).updateProfile(
      newUser.id,
      newUser.name,
      newUser.lastName,
      newUser.phoneNumber,
      newUser.email,
    );

    // get user info
    BlocProvider.of<UserProfileCubit>(context).getProfile(uid: newUser.id);
  }

  @override
  void initState() {
    super.initState();
    context.read<UserProfileCubit>().getProfile(uid: fbAuth.FirebaseAuth.instance.currentUser!.uid);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.amber,
      appBar: AppBar(
        automaticallyImplyLeading: true,
        title: Padding(
          padding: const EdgeInsets.only(left: 60.0),
          child: Text('My Profile Page'),
        ),
        // save button
        actions: [
          IconButton(
            onPressed: () {
              _submitForm();
            },
            icon: const Icon(Icons.save),
          ),
        ],
      ),
      body: BlocConsumer<UserProfileCubit, UserProfileState>(
        listener: (context, state) {
          if (state.status == UserProfileStatus.error) {
            errorDialog(context, state.error);
          }
        },
        builder: (context, state) {
          if (state.status == UserProfileStatus.loading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          return Center(
            child: Column(
              children: [
                //sizedbox
                const SizedBox(
                  height: 50,
                ),
                // PROFILE PICTURE
                Container(
                  decoration: const BoxDecoration(
                    color: Color.fromARGB(255, 130, 189, 217),
                    borderRadius: BorderRadius.all(
                      Radius.circular(100),
                    ),
                  ),
                  height: 65,
                  width: 65,
                  child: Padding(
                    padding: const EdgeInsets.all(3.0),
                    child: Container(
                      decoration: const BoxDecoration(
                        color: Color.fromARGB(221, 199, 229, 219),
                        borderRadius: BorderRadius.all(
                          Radius.circular(100),
                        ),
                      ),
                      child: Icon(
                        Icons.person,
                        color: Colors.black,
                        size: 50,
                      ),
                    ),
                  ),
                ),
                // sizedbox
                Flexible(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      // dark blue grey color and rounded edges
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Color.fromARGB(112, 155, 151, 151),
                      ),
                      child: Form(
                        autovalidateMode: _autoValidateMode,
                        key: _formKey,
                        child: ListView(
                          shrinkWrap: true,
                          children: [
                            // form fields with rounded corners populated with user data
                            // name field
                            Padding(
                              padding: const EdgeInsets.only(left: 15.0, right: 15.0, top: 15.0),
                              child: Container(
                                height: 50,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  color: Colors.grey[200],
                                ),
                                child: TextFormField(
                                  initialValue: state.user.name,
                                  decoration: const InputDecoration(
                                    border: InputBorder.none,
                                    hintText: 'Name',
                                    hintStyle: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w500,
                                    ),
                                    contentPadding: EdgeInsets.only(left: 15.0),
                                  ),
                                  validator: (String? value) {
                                    if (value == null || value.isEmpty) {
                                      return 'Please enter your name';
                                    }
                                    return null;
                                  },
                                  onSaved: (newValue) {
                                    _name = newValue;
                                  },
                                ),
                              ),
                            ),
                            // last name field
                            Padding(
                              padding: const EdgeInsets.only(left: 15.0, right: 15.0, top: 15.0),
                              child: Container(
                                height: 50,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  color: Colors.grey[200],
                                ),
                                child: TextFormField(
                                  initialValue: state.user.lastName,
                                  decoration: const InputDecoration(
                                    border: InputBorder.none,
                                    hintText: 'Last Name',
                                    hintStyle: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w500,
                                    ),
                                    contentPadding: EdgeInsets.only(left: 15.0),
                                  ),
                                  validator: (String? value) {
                                    if (value == null || value.isEmpty) {
                                      return 'Please enter your last name';
                                    }
                                    return null;
                                  },
                                  onSaved: (newValue) {
                                    _lastName = newValue;
                                  },
                                ),
                              ),
                            ),
                            // phone number field
                            Padding(
                              padding: const EdgeInsets.only(left: 15.0, right: 15.0, top: 15.0),
                              child: Container(
                                height: 50,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  color: Colors.grey[200],
                                ),
                                child: TextFormField(
                                  keyboardType: TextInputType.number,
                                  initialValue: state.user.phoneNumber,
                                  decoration: const InputDecoration(
                                    border: InputBorder.none,
                                    hintText: 'Phone number',
                                    hintStyle: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w500,
                                    ),
                                    contentPadding: EdgeInsets.only(left: 15.0),
                                  ),
                                  onSaved: (newValue) {
                                    _phoneNumber = newValue;
                                  },
                                ),
                              ),
                            ),
                            // email field WARN THE user that if this is changed
                            // the app will log out
                            Padding(
                              padding: const EdgeInsets.only(
                                  left: 15.0, right: 15.0, top: 15.0, bottom: 15.0),
                              child: Container(
                                height: 50,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  color: Colors.grey[200],
                                ),
                                child: TextFormField(
                                  keyboardType: TextInputType.emailAddress,
                                  initialValue: state.user.email,
                                  decoration: const InputDecoration(
                                    border: InputBorder.none,
                                    hintText: 'Email',
                                    hintStyle: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w500,
                                    ),
                                    contentPadding: EdgeInsets.only(left: 15.0),
                                  ),
                                  validator: (String? value) {
                                    if (value == null || value.isEmpty) {
                                      return 'Please enter an email';
                                    }
                                    return null;
                                  },
                                  onSaved: (newValue) {
                                    _email = newValue;
                                  },
                                ),
                              ),
                            ),
                            // warning text
                            Padding(
                              padding: const EdgeInsets.all(15),
                              child: Text(
                                'If you change your email, you will be logged out of the app.',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 14,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                // sign out button
                ElevatedButton(
                  onPressed: () {
                    context.read<AuthBloc>().add(SignoutRequestedEvent());
                  },
                  child: const Text('Sign Out'),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
