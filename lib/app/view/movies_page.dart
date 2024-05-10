import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:study_case/app/view/movies.dart';
import 'package:study_case/app/viewmodel/movies_viewmodel.dart';
import 'package:study_case/injection_container.dart';

class MoviesPage extends StatelessWidget {
  const MoviesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => MovieViewModel(sl(), sl()),
      child: Scaffold(
        appBar: AppBar(
          title: const Text("TMDB"),
        ),
        body: const Movies(),
      ),
    );
  }
}
