import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_pets_app/blocs/Auth/auth_bloc.dart';
import 'package:my_pets_app/blocs/breed-provider/breed_provider_cubit.dart';
import 'package:my_pets_app/blocs/favorite_list/favorite_list_cubit.dart';
import 'package:my_pets_app/blocs/signin/signin_cubit.dart';
import 'package:my_pets_app/blocs/signup/signup_cubit.dart';
import 'package:my_pets_app/repositories/cat_api.dart';
import 'package:my_pets_app/repositories/dog_api.dart';
import 'package:my_pets_app/repositories/favorites_repository.dart';
import 'package:my_pets_app/repositories/mypets_repository.dart';
import 'package:my_pets_app/repositories/profile_repository.dart';
import 'package:my_pets_app/screens/cat_breeds.dart';
import 'package:my_pets_app/screens/dog_breeds.dart';
import 'package:my_pets_app/screens/home_page.dart';
import 'package:my_pets_app/screens/mypets_page.dart';
import 'package:my_pets_app/screens/petdict_page.dart';
import 'package:my_pets_app/screens/signup_page.dart';
import 'package:my_pets_app/screens/splash_screen.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'blocs/favorite_badge/favorite_badge_cubit.dart';
import 'blocs/pet_list/pet_list_cubit.dart';
import 'blocs/signup_pet/signup_pet_cubit.dart';
import 'blocs/user_profile/user_profile_cubit.dart';
import 'firebase_options.dart';
import 'repositories/auth_repository.dart';
import 'screens/pet_favorites.dart';
import 'screens/profile_page.dart';
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
        RepositoryProvider<FavoriteRepository>(
          create: (context) => FavoriteRepository(
            firebaseFirestore: FirebaseFirestore.instance,
            firebaseAuth: FirebaseAuth.instance,
          ),
        ),
        // profile reposityory
        RepositoryProvider<ProfileRepository>(
          create: (context) => ProfileRepository(
            firebaseFirestore: FirebaseFirestore.instance,
            firebaseAuth: FirebaseAuth.instance,
          ),
        ),
        // pet repository
        RepositoryProvider<MyPetsRepository>(
          create: (context) => MyPetsRepository(
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
          BlocProvider<BreedProviderCubit>(
            create: (context) => BreedProviderCubit(
              dogApiRepository: context.read<DogApiRepository>(),
              catApiRepository: context.read<CatApiRepository>(),
            ),
          ),
          // favorite provider
          BlocProvider<FavoriteListCubit>(
            create: (context) => FavoriteListCubit(
              favoriteRepository: context.read<FavoriteRepository>(),
            ),
          ),
          // favorite badge
          BlocProvider<FavoriteBadgeCubit>(
            create: (context) => FavoriteBadgeCubit(
              favoriteRepository: context.read<FavoriteRepository>(),
            ),
          ),
          // user profile cubit
          BlocProvider<UserProfileCubit>(
            create: (context) => UserProfileCubit(
              profileRepository: context.read<ProfileRepository>(),
            ),
          ),
          // pet list cubit
          BlocProvider<PetListCubit>(
            create: (context) => PetListCubit(
              petRepository: context.read<MyPetsRepository>(),
            ),
          ),
          // add pet cubit
          BlocProvider<SignupPetCubit>(
            create: (context) => SignupPetCubit(
              petRepository: context.read<MyPetsRepository>(),
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
            UserProfilePage.routeName: (context) => const UserProfilePage(),
            MyPetsPage.routeName: (context) => const MyPetsPage(),
          },
        ),
      ),
    );
  }
}
