import 'package:cached_network_image/cached_network_image.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:study_case/app/model/get_movie_response_model.dart';
import 'package:study_case/app/viewmodel/movies_viewmodel.dart';
import 'package:study_case/app/widgets/shimmer_box.dart';
import 'package:study_case/core/theme/app_colors.dart';
import 'package:study_case/core/theme/text_styles.dart';

class Movies extends StatelessWidget {
  const Movies({super.key});

  @override
  Widget build(BuildContext context) {
    final moviesState = context.read<MovieViewModel>();

    return BlocBuilder<MovieViewModel, GetMovieResponse>(
      bloc: moviesState,
      builder: (context, state) {
        if (state.initial! && state.movies!.isEmpty) {
          moviesState.getMovies();
        }

        state.scrollController!.addListener(() {
          if (state.scrollController!.position.maxScrollExtent ==
              state.scrollController!.offset) {
            moviesState.nextPage();
          }
        });

        return RefreshIndicator(
          onRefresh: () async {
            context.read<MovieViewModel>().refreshMovies();
          },
          child: state.isSuccess == false && state.isLoading == false
              ? SingleChildScrollView(
                  child: Center(
                    child: Text(state.message!),
                  ),
                )
              : state.initial == true && state.isLoading == true
                  ? Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 12),
                      child: GridView.builder(
                        itemCount: 9,
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                          mainAxisExtent: 340,
                          crossAxisCount: 2,
                          crossAxisSpacing: 15,
                          mainAxisSpacing: 15,
                        ),
                        itemBuilder: (_, index) {
                          return const ShimmerBox();
                        },
                      ),
                    )
                  : Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 12),
                      child: Column(
                        children: [
                          Expanded(
                            child: GridView.builder(
                              controller: state.scrollController,
                              itemCount: state.movies!.length,
                              gridDelegate:
                                  const SliverGridDelegateWithFixedCrossAxisCount(
                                mainAxisExtent: 340,
                                crossAxisCount: 2,
                                crossAxisSpacing: 15,
                              ),
                              itemBuilder: (_, index) {
                                return GestureDetector(
                                  onTap: () async {
                                    context.push('/movie-detail',
                                        extra: state.movies![index]);

                                    await FirebaseAnalytics.instance.logEvent(
                                        name: "movie_clicked",
                                        parameters: {
                                          'movie_name':
                                              state.movies![index].title,
                                        });
                                  },
                                  child: Column(
                                    children: [
                                      CachedNetworkImage(
                                        placeholder: (_, __) =>
                                            const CupertinoActivityIndicator(),
                                        errorWidget: (_, __, ___) {
                                          debugPrint(__);
                                          debugPrint(___.toString());
                                          return const Icon(
                                              Icons.error_outline);
                                        },
                                        imageUrl: context
                                                .read<MovieViewModel>()
                                                .imageUrl +
                                            state.movies![index].posterPath!,
                                        imageBuilder:
                                            (context, imageProvider) =>
                                                Container(
                                          height: 250,
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(15),
                                            image: DecorationImage(
                                              image: imageProvider,
                                              fit: BoxFit.fill,
                                            ),
                                          ),
                                        ),
                                        fit: BoxFit.cover,
                                      ),
                                      const SizedBox(height: 8),
                                      Text(
                                        state.movies![index].title!,
                                        textAlign: TextAlign.center,
                                        overflow: TextOverflow.ellipsis,
                                        maxLines: 2,
                                        style: productNameText(context),
                                      ),
                                      Center(
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Icon(
                                              Icons.star_rate_rounded,
                                              color: AppColor.rateColor,
                                            ),
                                            Text(
                                              state.movies![index].voteAverage!
                                                  .toStringAsFixed(1),
                                              textAlign: TextAlign.center,
                                              overflow: TextOverflow.fade,
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                );
                              },
                            ),
                          ),
                          state.initial == false && state.isLoading == true
                              ? const Padding(
                                  padding: EdgeInsets.symmetric(horizontal: 12),
                                  child: Center(
                                      child: CircularProgressIndicator()),
                                )
                              : Container(),
                        ],
                      ),
                    ),
        );
      },
    );
  }
}
