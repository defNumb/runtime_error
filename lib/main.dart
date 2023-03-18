import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_pets_app/blocs/Auth/auth_bloc.dart';
import 'package:my_pets_app/blocs/signin/signin_cubit.dart';
import 'package:my_pets_app/blocs/signup/signup_cubit.dart';
import 'package:my_pets_app/screens/home_page.dart';
import 'package:my_pets_app/screens/signup_page.dart';
import 'package:my_pets_app/screens/splash_screen.dart';

import 'firebase_options.dart';
import 'repositories/auth_repository.dart';
import 'screens/pet_favorites.dart';
import 'screens/signin_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider<AuthRepository>(
          create: (context) => AuthRepository(
            firebaseFirestore: FirebaseFirestore.instance,
            firebaseAuth: FirebaseAuth.instance,
          ),
        ),
      ],
      child: MultiBlocProvider(
        providers: [
          BlocProvider<AuthBloc>(
            create: (context) => AuthBloc(
              authRepository: context.read<AuthRepository>(),
            ),
          ),
          BlocProvider<SigninCubit>(
            create: (context) => SigninCubit(
              authRepository: context.read<AuthRepository>(),
            ),
          ),
          BlocProvider<SignupCubit>(
            create: (context) => SignupCubit(
              authRepository: context.read<AuthRepository>(),
            ),
          ),
        ],
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Flutter Demo',
          theme: ThemeData(
            primarySwatch: Colors.blue,
          ),
          home: SplashScreen(),
          // routes
          routes: {
            PetFavoritesPage.routeName: (context) => const PetFavoritesPage(),
            SigninPage.routeName: (context) => const SigninPage(),
            HomePage.routeName: (context) => const HomePage(),
            SignupPage.routeName: (context) => const SignupPage(),
          },
        ),
      ),
    );
  }
}
