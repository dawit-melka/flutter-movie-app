import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:mobile/core/color/colors.dart';
import 'package:mobile/features/movie/presentation/bloc/movie_bloc.dart';
import 'package:mobile/features/movie/presentation/widgets/loading_widget.dart';
import 'package:mobile/features/movie/presentation/widgets/search_bar_widget.dart';
import 'package:mobile/injection/injection_container.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';

import '../widgets/all_movies_tile.dart';
import '../widgets/category_title.dart';
import '../widgets/saved_movies_card.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool showCards = true;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: AppBar(
         leading: IconButton(
          onPressed: () {
            context.pop();
          },
          icon: Icon(
            Icons.arrow_back,
            color: Colors.blueGrey[900],
            size: 40,
          ),
        ),
        title: Text(
          "Alem Cinema",
          style: TextStyle(color: Colors.black),
        ),
        centerTitle: true,
        backgroundColor: tilesColor,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: SafeArea(
          child: Column(
            children: [
              const SizedBox(height: 20),
              SearchBarWidget(searchByName: (queryString) {
                BlocProvider.of<MovieBloc>(context)
                    .add(SearchMoviesEvent(searchQuery: queryString));
                setState(() {
                  showCards = false;
                });
                if (queryString == "") {
                  setState(() {
                    showCards = true;
                  });
                }
              }),
              const SizedBox(height: 20),
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                color: backgroundColor,
                width: double.infinity,
                child: Column(
                  children: [
                    Visibility(
                      visible: showCards,
                      child: Container(
                        color: tilesColor,
                        padding: const EdgeInsets.symmetric(
                            horizontal: 20, vertical: 5),
                        child: const Row(
                          children: [
                            Text(
                              "Saved Movies",
                              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                            ),
                            SizedBox(width: 5),
                            Icon(
                              Icons.bookmark_rounded,
                              color: Colors.blue,
                              size: 30,
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 10),
                    Visibility(
                      visible: showCards,
                      child: BlocProvider(
                        create: (context) => sl<MovieBloc>(),
                        child: BlocConsumer<MovieBloc, MovieState>(
                          listener: (context, state) {
                            if (state is MovieError) {
                              showTopSnackBar(
                                  Overlay.of(context),
                                  const CustomSnackBar.error(
                                      message:
                                          "Oops unable to load the movies"));
                            }
                          },
                          builder: (context, state) {
                            if (state is MovieInitial) {
                              BlocProvider.of<MovieBloc>(context)
                                  .add(GetBookmarkedMoviesEvent());
                               return LoadingWidget(message: "Loading");
                            } else if (state is LoadingMovies) {
                               return LoadingWidget(message: "Loading");
                            } else if (state is MoviesLoaded) {
                              if (state.movies.isNotEmpty) {
                                return SavedMoviesCard(
                                    savedMovies: state.movies);
                              } else {
                                return Container(
                                  height: 250,
                                  width: 200,
                                  decoration: BoxDecoration(
                                    color: tilesColor,
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                  child: Center(
                                      child: Text(
                                    "No Saved Movie!",
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 25),
                                  )),
                                );
                              }
                            } else {
                              return Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Text("Error while getting articles$state"),
                                  FloatingActionButton.extended(
                                    onPressed: () {
                                      context.go('/home');
                                    },
                                    label: Icon(
                                      Icons.home,
                                      size: 32,
                                    ),
                                  ),
                                ],
                              );
                            }
                          },
                        ),
                      ),
                    ),
                    Visibility(visible: showCards, child: SizedBox(height: 10)),
                    Visibility(visible: showCards, child: CategoryTitle()),
                    SizedBox(height: 20),
                    BlocConsumer<MovieBloc, MovieState>(
                      listener: (context, state) {
                        // TODO: implement listener
                      },
                      builder: (context, state) {
                        if (state is MovieInitial) {
                          BlocProvider.of<MovieBloc>(context)
                              .add(GetAllMoviesEvent());
                          return LoadingWidget(message: "Loading");

                        } else if (state is LoadingMovies) {
                          return LoadingWidget(message: "Loading");
                        } else if (state is MoviesLoaded) {
                          return AllMoviesTile(allMovies: state.movies);
                          // return SizedBox(height: 10, width: 10,);
                        } else {
                          return Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text("Error while getting movies$state"),
                              FloatingActionButton.extended(
                                onPressed: () {
                                  context.go('/home');
                                },
                                label: Icon(
                                  Icons.home,
                                  size: 32,
                                ),
                              ),
                            ],
                          );
                        }
                      },
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
