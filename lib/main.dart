import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:study_case/app/viewmodel/firebase_viewmodel.dart';
import 'package:study_case/app/viewmodel/movies_viewmodel.dart';
import 'package:study_case/core/constants/app_strings.dart';
import 'package:study_case/core/routes/routes.dart';
import 'package:study_case/firebase_options.dart';
import 'package:study_case/injection_container.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  await initializeDependencies();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<MovieViewModel>(
          create: (context) => MovieViewModel(sl(), sl()),
        ),
        BlocProvider<FirebaseViewModel>(
          create: (context) => FirebaseViewModel(sl()),
        ),
      ],
      child: MaterialApp.router(
        debugShowCheckedModeBanner: false,
        title: AppStrings.appTitle,
        routerConfig: routes,
      ),
    );
  }
}
