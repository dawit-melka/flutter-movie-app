part of 'movie_bloc.dart';

sealed class MovieState extends Equatable {
  const MovieState();
  
  @override
  List<Object> get props => [];
}

class MovieInitial extends MovieState {
  const MovieInitial();
}

class LoadingMovies extends MovieState{}

class MovieLoaded extends MovieState{
  final Movie movie;
  const MovieLoaded(this.movie);

  @override
  List<Object> get props => [movie.id];
}

class MoviesLoaded extends MovieState{
  final List<Movie> movies;
  const MoviesLoaded(this.movies);

  @override
  List<Object> get props => [movies];
}

class MovieBookmarked extends MovieState{}

class MovieError extends MovieState {
  final String message;

  const MovieError(this.message);

  @override
  List<String> get props => [message];
}


