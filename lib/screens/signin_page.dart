import 'package:flutter/material.dart';
import 'package:my_pets_app/constants/app_constants.dart';

class SigninPage extends StatefulWidget {
  // Setting up the name of the page route
  static const String routeName = '/signin_page';
  const SigninPage({super.key});

  @override
  State<SigninPage> createState() => _SigninPageState();
}

class _SigninPageState extends State<SigninPage> {
  // Setting up the form key
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  // Setting up the autovalidate mode
  AutovalidateMode _autoValidateMode = AutovalidateMode.disabled;
  // Setting up the email and password variables
  String? _email, _password;
  // Setting up the focus node
  FocusNode myFocusNode = FocusNode();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: primaryColor,
      appBar: AppBar(
        title: const Center(
          child: Text('Signin Page'),
        ),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          // This is the beginning of the form
          child: Form(
            // Here a ListView is used to make the form scrollable in case the
            // keyboard is open
            child: ListView(
              shrinkWrap: true,
              children: [
                // this is used as empty space to push the form down
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.05,
                ),
                // This is the email TextFormField
                TextFormField(
                  focusNode: myFocusNode,
                  keyboardType: TextInputType.emailAddress,
                  autocorrect: false,
                  decoration: const InputDecoration(
                    icon: Icon(Icons.person),
                    fillColor: Colors.white,
                    filled: true,
                    labelText: 'Email',
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                // This is the password TextFormField
                TextFormField(
                  decoration: const InputDecoration(
                    icon: Icon(Icons.lock),
                    labelText: 'Password',
                    fillColor: Colors.white,
                    filled: true,
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                ElevatedButton(
                  onPressed: () {},
                  child: const Text('Sign Up'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
