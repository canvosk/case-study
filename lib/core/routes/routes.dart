import 'package:go_router/go_router.dart';
import 'package:study_case/app/model/movie_model.dart';
import 'package:study_case/app/view/movie_detail.dart';
import 'package:study_case/app/view/movies_page.dart';

final GoRouter routes = GoRouter(
  routes: [
    GoRoute(
      path: '/',
      builder: (context, state) => const MoviesPage(),
    ),
    GoRoute(
      path: '/movie-detail',
      builder: (context, state) => MovieDetail(
        movie: state.extra as MovieModel,
      ),
    ),
  ],
);
