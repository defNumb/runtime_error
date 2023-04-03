import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_pets_app/blocs/Auth/auth_bloc.dart';
import 'package:my_pets_app/blocs/breed-provider/breed_provider_cubit.dart';
import 'package:my_pets_app/blocs/signin/signin_cubit.dart';
import 'package:my_pets_app/blocs/signup/signup_cubit.dart';
import 'package:my_pets_app/repositories/cat_api.dart';
import 'package:my_pets_app/repositories/dog_api.dart';
import 'package:my_pets_app/screens/cat_breeds.dart';
import 'package:my_pets_app/screens/dog_breeds.dart';
import 'package:my_pets_app/screens/home_page.dart';
import 'package:my_pets_app/screens/petdict_page.dart';
import 'package:my_pets_app/screens/signup_page.dart';
import 'package:my_pets_app/screens/splash_screen.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'firebase_options.dart';
import 'repositories/auth_repository.dart';
import 'screens/pet_favorites.dart';
import 'screens/signin_page.dart';
import 'package:path_provider/path_provider.dart';
import 'package:flutter/foundation.dart' show kIsWeb;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  // Setting up HydratedBloc
  // This will help store information in the device
  HydratedBloc.storage = await HydratedStorage.build(
    storageDirectory:
        kIsWeb ? HydratedStorage.webStorageDirectory : await getApplicationDocumentsDirectory(),
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
        RepositoryProvider<DogApiRepository>(
          create: (context) => DogApiRepository(),
        ),
        RepositoryProvider<CatApiRepository>(
          create: (context) => CatApiRepository(),
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
          BlocProvider<BreedProviderCubit>(
            create: (context) => BreedProviderCubit(
              dogApiRepository: context.read<DogApiRepository>(),
              catApiRepository: context.read<CatApiRepository>(),
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
            PetDictionaryPage.routeName: (context) => const PetDictionaryPage(),
            DogBreedsPage.routeName: (context) => const DogBreedsPage(),
            CatBreedsPage.routeName: (context) => const CatBreedsPage(),
          },
        ),
      ),
    );
  }
}
