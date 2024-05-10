import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:study_case/app/model/movie_model.dart';
import 'package:study_case/app/viewmodel/movies_viewmodel.dart';
import 'package:study_case/core/theme/app_colors.dart';
import 'package:study_case/core/theme/text_styles.dart';

class MovieDetail extends StatelessWidget {
  final MovieModel movie;
  const MovieDetail({super.key, required this.movie});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("TMDB"),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 24),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Icon(
                  Icons.star_rate_rounded,
                  color: AppColor.rateColor,
                  size: 36,
                ),
                Text(
                  movie.voteAverage!.toStringAsFixed(1),
                  textAlign: TextAlign.center,
                  overflow: TextOverflow.fade,
                  style: detailRating(context),
                ),
              ],
            ),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.only(left: 24, right: 24, top: 24),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CachedNetworkImage(
                placeholder: (_, __) => const CupertinoActivityIndicator(),
                errorWidget: (_, __, ___) {
                  debugPrint(__);
                  debugPrint(___.toString());
                  return const Icon(Icons.error_outline);
                },
                imageUrl:
                    context.read<MovieViewModel>().imageUrl + movie.posterPath!,
                imageBuilder: (context, imageProvider) => Container(
                  height: 450,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    image: DecorationImage(
                      image: imageProvider,
                      fit: BoxFit.fill,
                    ),
                  ),
                ),
                fit: BoxFit.cover,
              ),
              const SizedBox(height: 24),
              Center(
                child: Text(
                  movie.title!,
                  textAlign: TextAlign.center,
                  overflow: TextOverflow.fade,
                  style: detailTitle(context),
                ),
              ),
              const SizedBox(height: 12),
              Align(
                alignment: Alignment.centerRight,
                child: Padding(
                  padding: const EdgeInsets.only(right: 8),
                  child: Text(
                    movie.releaseDate!,
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
              const SizedBox(height: 12),
              Text(
                movie.overview!,
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
