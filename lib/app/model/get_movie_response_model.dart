// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:study_case/app/model/movie_model.dart';

class GetMovieResponse extends Equatable {
  final ScrollController? scrollController;
  final bool? isLoading;
  final bool? isSuccess;
  final String? message;
  final List<MovieModel>? movies;
  final int? page;
  final bool? initial;

  const GetMovieResponse({
    this.scrollController,
    this.isLoading,
    this.isSuccess,
    this.message,
    this.movies,
    this.page = 1,
    this.initial = false,
  });

  static final initialValue = GetMovieResponse(
    scrollController: ScrollController(),
    isLoading: true,
    isSuccess: false,
    message: "Loading...",
    movies: const [],
    page: 1,
    initial: true,
  );

  GetMovieResponse copyWith({
    ScrollController? scrollController,
    bool? isLoading,
    bool? isSuccess,
    String? message,
    List<MovieModel>? movies,
    int? page,
    bool? initial,
  }) {
    return GetMovieResponse(
      scrollController: scrollController ?? this.scrollController,
      isLoading: isLoading ?? this.isLoading,
      isSuccess: isSuccess ?? this.isSuccess,
      message: message ?? this.message,
      movies: movies ?? this.movies,
      page: page ?? this.page,
      initial: initial ?? this.initial,
    );
  }

  @override
  List<Object?> get props =>
      [scrollController, isLoading, isSuccess, message, movies, page, initial];
}



