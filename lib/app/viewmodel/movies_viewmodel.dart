import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:study_case/app/model/get_movie_response_model.dart';
import 'package:study_case/app/model/movie_model.dart';
import 'package:study_case/core/constants/api_strings.dart';
import 'package:study_case/core/services/movie_services.dart';

class MovieViewModel extends Cubit<GetMovieResponse> {
  final MovieServices _movieServices;
  final ApiStrings _apiStrings;

  MovieViewModel(this._movieServices, this._apiStrings)
      : super(GetMovieResponse.initialValue);

  String get imageUrl => _apiStrings.imageUrl;

  Future getMovies({bool? nextPage}) async {
    emit(
      state.copyWith(
        isLoading: true,
      ),
    );

    int page = 1;
    if (nextPage == true && state.movies!.isNotEmpty) {
      page = state.page! + 1;
    }
    GetMovieResponse result = await _movieServices.getMovies(page: page);

    if (state.initial == true) {
      emit(
        result.copyWith(
          scrollController: state.scrollController,
          isLoading: false,
          movies: result.movies,
        ),
      );
      return;
    } else if (result.movies!.isNotEmpty) {
      List<MovieModel> newMoviesList = state.movies!;
      for (var movie in result.movies!) {
        newMoviesList.add(movie);
      }

      emit(result.copyWith(
          scrollController: state.scrollController,
          isLoading: false,
          movies: newMoviesList));
      return;
    }
    emit(result.copyWith(
        scrollController: state.scrollController, isLoading: false));
    return;
  }

  Future refreshMovies() async {
    emit(GetMovieResponse.initialValue);
  }

  Future nextPage() async {
    if (state.isLoading!) {
      return;
    }
    getMovies(nextPage: true);
  }
}
