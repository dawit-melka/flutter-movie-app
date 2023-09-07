import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:mobile/core/use_case/usecase.dart';
import 'package:mobile/features/movie/domain/entities/movie.dart';
import 'package:mobile/features/movie/domain/usecases/get_all_movies.dart';
import 'package:mobile/features/movie/domain/usecases/get_bookmarked_movies.dart';
import 'package:mobile/features/movie/domain/usecases/get_movie.dart';
import 'package:mobile/features/movie/domain/usecases/search_movies.dart';

part 'movie_event.dart';
part 'movie_state.dart';

class MovieBloc extends Bloc<MovieEvent, MovieState> {
  MovieBloc({
    required GetAllMoviesUsecase getAllMovies,
    required GetMovieUsecase getMovie,
    required SearchMovieUsecase searchMovie,
    required GetBookmarkedMoviesUsecase getBookmarked,
  })  : _getAllMovies = getAllMovies,
        _getMovie = getMovie,
        _searchMovie = searchMovie,
        _getBookmarked = getBookmarked,
        super(const MovieInitial()) {
    on<GetAllMoviesEvent>(_getAllMoviesHandler);
    on<GetMovieEvent>(_getMovieHandler);
    on<SearchMoviesEvent>(_searchMoviesHandler);
    on<GetBookmarkedMoviesEvent>(_getBookmarkedHandler);
  }

  final GetAllMoviesUsecase _getAllMovies;
  final GetMovieUsecase _getMovie;
  final SearchMovieUsecase _searchMovie;
  final GetBookmarkedMoviesUsecase _getBookmarked;

  FutureOr<void> _getAllMoviesHandler(
      GetAllMoviesEvent event, Emitter<MovieState> emit) async {
    emit(LoadingMovies());

    final result = await _getAllMovies(NoParams());
    result.fold((error) => emit(MovieError(error.errorMessage)),
        (movies) => emit(MoviesLoaded(movies)));
  }

  FutureOr<void> _getMovieHandler(
      GetMovieEvent event, Emitter<MovieState> emit) async {
        emit(LoadingMovies());
        final result = await _getMovie(event.id);

        result.fold((l) => emit(MovieError(l.errorMessage)), (movie) => emit(MovieLoaded(movie)));
      }

  FutureOr<void> _searchMoviesHandler(
      SearchMoviesEvent event, Emitter<MovieState> emit) async {
        emit(LoadingMovies());

        final result = await _searchMovie(event.searchQuery);
        result.fold((l) => emit(MovieError(l.errorMessage)), (movies) => emit(MoviesLoaded(movies)));
      }

  FutureOr<void> _getBookmarkedHandler(GetBookmarkedMoviesEvent event, Emitter<MovieState> emit) async {
    emit(LoadingMovies());
    final result = await _getBookmarked(NoParams());
    result.fold((l) => emit(MovieError(l.errorMessage)), (movies) => emit(MoviesLoaded(movies)));
  }
}
