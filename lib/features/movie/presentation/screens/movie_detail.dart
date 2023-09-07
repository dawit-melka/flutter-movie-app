import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:mobile/core/util/bookmark_preferences.dart';
import 'package:mobile/features/movie/presentation/widgets/loading_widget.dart';

import '../../../../injection/injection_container.dart';
import '../bloc/movie_bloc.dart';
import '../widgets/movie_detail_image.dart';
import '../widgets/movie_info.dart';
import '../widgets/movie_title.dart';
import '../widgets/watch_now_button.dart';

class MovieDetailScreen extends StatefulWidget {
  final String id;
  const MovieDetailScreen({required this.id, super.key});

  @override
  State<MovieDetailScreen> createState() => _MovieDetailScreenState();
}

class _MovieDetailScreenState extends State<MovieDetailScreen> {
  bool isBookmarked = false;

  @override
  void initState(){
    super.initState();
    isBookmarked = BookmarkPreferences.isBookmarked(widget.id);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        title: const Text(
          "Detail",
          style: TextStyle(color: Colors.black, fontSize: 20),
        ),
        centerTitle: true,
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
        actions: [
          IconButton(
            onPressed: () async {
              await BookmarkPreferences.setBookmartk(widget.id);
              setState(() {
                isBookmarked = BookmarkPreferences.isBookmarked(widget.id);
              });
            },
            icon: Icon(
              isBookmarked? Icons.bookmark: Icons.bookmark_outline_rounded,
              color: Colors.blueGrey[900],
              size: 40,
            ),
          )
        ],
      ),
      body: BlocProvider(
        create: (context) => sl<MovieBloc>(),
        child: BlocConsumer<MovieBloc, MovieState>(
          listener: (context, state) {
            // TODO: implement listener
          },
          builder: (context, state) {
            if (state is MovieInitial) {
              BlocProvider.of<MovieBloc>(context).add(GetMovieEvent(id: widget.id));
              return Center(child: Expanded(child: LoadingWidget(message: "Loading")));
            } else if (state is LoadingMovies) {
              return Center(child: Expanded(child: LoadingWidget(message: "Loading")));
            } else if (state is MovieLoaded) {
              return SingleChildScrollView(
                child: SafeArea(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: Column(
                      children: [
                        // Spacer(),
                        MovieDetailImage(
                          image: state.movie.image,
                          rating: state.movie.rating,
                        ),
                        SizedBox(height: 10),
                        MovieTitle(
                          title: state.movie.title,
                        ),
                        SizedBox(height: 10),
                        MovieInfo(
                          duration: state.movie.duration,
                          category: state.movie.category,
                        ),
                        SizedBox(height: 10),
                        Text(
                          state.movie.description,
                          style: TextStyle(fontSize: 16),
                        ),
                        SizedBox(height: 20),

                        const SizedBox(height: 20),
                      ],
                    ),
                  ),
                ),
              );
            } else {
              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text("Error while geting movie$state"),
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
      floatingActionButton: WatchNowButton(),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
