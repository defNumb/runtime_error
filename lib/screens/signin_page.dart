import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_pets_app/constants/app_constants.dart';
import 'package:my_pets_app/screens/signup_page.dart';
import 'package:validators/validators.dart';

import '../blocs/signin/signin_cubit.dart';
import '../utils/error_dialog.dart';

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
  late bool _passwordVisible;

  @override
  void initState() {
    super.initState();
    _passwordVisible = false;
  }

  void _submit() {
    setState(() {
      _autoValidateMode = AutovalidateMode.always;
    });
    final form = _formKey.currentState;
    if (form == null || !form.validate()) {
      return;
    }
    form.save();
    context.read<SigninCubit>().signin(email: _email!, password: _password!);
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: BlocConsumer<SigninCubit, SigninState>(
          listener: (context, state) {
            if (state.signinStatus == SigninStatus.error) {
              errorDialog(context, state.error);
            }
          },
          builder: (context, state) {
            return Scaffold(
              backgroundColor: primaryColor,
              body: Center(
                child: Padding(
                  padding: const EdgeInsets.all(15.0),
                  // This is the beginning of the form
                  child: Form(
                    key: _formKey,
                    autovalidateMode: _autoValidateMode,
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
                            fillColor: Colors.white,
                            filled: true,
                            labelText: 'Email',
                            prefixIcon: Icon(Icons.email),
                          ),
                          validator: (value) {
                            if (value == null || value.trim().isEmpty) {
                              return 'Please enter an email';
                            }
                            if (!isEmail(value.trim())) {
                              return 'Please enter a valid email';
                            }
                            return null;
                          },
                          onSaved: (String? value) {
                            _email = value;
                          },
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        // This is the password TextFormField
                        TextFormField(
                          obscureText: !_passwordVisible,
                          keyboardType: TextInputType.text,
                          decoration: InputDecoration(
                            labelText: 'Password',
                            fillColor: Colors.white,
                            filled: true,
                            prefixIcon: Icon(Icons.lock),
                            suffixIcon: IconButton(
                              icon:
                                  Icon(_passwordVisible ? Icons.visibility : Icons.visibility_off),
                              onPressed: () {
                                setState(() {
                                  _passwordVisible = !_passwordVisible;
                                });
                              },
                            ),
                          ),
                          validator: (String? value) {
                            if (value == null || value.trim().isEmpty) {
                              return 'Please enter a password';
                            }
                            if (value.trim().length < 6) {
                              return 'Password must be at least 6 characters long';
                            }
                            return null;
                          },
                          onSaved: (String? value) {
                            _password = value;
                          },
                        ),
                        // forgot password?
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            TextButton(
                              onPressed: () {},
                              child: const Text('Forgot Password?'),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        ElevatedButton(
                          onPressed: state.signinStatus == SigninStatus.submitting ? null : _submit,
                          child: Text(state.signinStatus == SigninStatus.submitting
                              ? 'Loading...'
                              : 'Sign in'),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text('Don\'t have an account?'),
                            TextButton(
                              onPressed: () {
                                Navigator.pushNamed(context, SignupPage.routeName);
                              },
                              child: const Text('Sign Up'),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
