part of 'movie_bloc.dart';

sealed class MovieEvent extends Equatable {
  const MovieEvent();

  @override
  List<Object> get props => [];
}

class GetAllMoviesEvent extends MovieEvent {}

class SearchMoviesEvent extends MovieEvent {
  final String searchQuery;
  const SearchMoviesEvent({this.searchQuery = ""});
}

class GetMovieEvent extends MovieEvent {
  final String id;
  const GetMovieEvent({required this.id});
  @override
  List<Object> get props => [id];
}

class GetBookmarkedMoviesEvent extends MovieEvent{}

class BookmarkEvent extends MovieEvent {
  final String id;
  const BookmarkEvent({required this.id});
  @override
  List<Object> get props => [id];
}