import 'dart:convert';

import 'package:mobile/core/util/bookmark_preferences.dart';
import 'package:mobile/features/movie/data/models/movie_model.dart';
import 'package:mobile/features/movie/domain/entities/movie.dart';

abstract class MovieLocalDataSource {
  Future<List<Movie>> getBookmarkedMovies();
}

class MovieLocalDataSourceImpl implements MovieLocalDataSource {
  @override
  Future<List<Movie>> getBookmarkedMovies() async {
    final List<String> jsonList = await BookmarkPreferences.getAllBookmarked();
    final List<Movie> convertedList = jsonList
        .map<Movie>(
          (movie) => MovieModel.fromMap(jsonDecode(movie)['data']),
        )
        .toList();
    
    return convertedList;
  }
}
