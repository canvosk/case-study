// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:study_case/app/model/get_movie_response_model.dart';
import 'package:study_case/app/model/movie_model.dart';
import 'package:study_case/core/constants/api_strings.dart';
import 'package:study_case/core/services/firebase_services.dart';

class MovieServices {
  final Dio _dio = Dio();

  final ApiStrings _apiStrings;
  final FirebaseServices _firebaseServices;
  MovieServices(this._apiStrings, this._firebaseServices);

  Future<GetMovieResponse> getMovies({int? page}) async {
    try {
      String url = "";
      if (page == 1) {
        url =
            "${_firebaseServices.getUrl() ?? _apiStrings.baseUrl}/3/discover/movie";
      } else {
        url =
            "${_firebaseServices.getUrl() ?? _apiStrings.baseUrl}/3/discover/movie?page=$page";
      }
      Map<String, dynamic> headers = {
        "Authorization": "Bearer ${_apiStrings.token}",
      };

      var response = await _dio.get(
        url,
        options: Options(
          headers: headers,
        ),
      );

      if (response.statusCode == 200) {
        _firebaseServices.logEvent();

        List results = response.data["results"];
        List<MovieModel> movies = [];
        if (results.isNotEmpty) {
          for (var movie in results) {
            movies.add(MovieModel.fromJson(movie));
          }
        }
        debugPrint(movies.toString());
        if (movies.isNotEmpty) {
          return GetMovieResponse(
            isSuccess: true,
            message: "",
            movies: movies,
            page: page,
          );
        }
        return GetMovieResponse(
          isSuccess: true,
          message: "Film bulunamadı...",
          movies: movies,
          page: page,
        );
      }

      return GetMovieResponse(
        isLoading: false,
        isSuccess: false,
        message: "An Error Occured...",
        movies: const [],
        page: page,
      );
    } catch (e) {
      debugPrint(e.toString());
      return GetMovieResponse(
        isSuccess: false,
        message: e.toString(),
        movies: const [],
        page: page,
      );
    }
  }
}
