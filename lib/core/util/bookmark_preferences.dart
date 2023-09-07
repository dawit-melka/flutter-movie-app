import 'package:http/http.dart' as http;
import 'package:mobile/core/util/constants.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../error/exception.dart';

class BookmarkPreferences {
  static SharedPreferences? _preferences;
  static String bookmarks = "bookmarks";

  static Future init() async =>
      _preferences = await SharedPreferences.getInstance();

  static Future setBookmartk(String movieId) async {
    final bookmarkedMovies = _preferences?.getStringList(bookmarks);
    if (bookmarkedMovies == null){
      await _preferences?.setStringList(bookmarks, [movieId]);
      return true;
    } else if(bookmarkedMovies.contains(movieId)){
      bookmarkedMovies.remove(movieId);
      await _preferences?.setStringList(bookmarks, bookmarkedMovies);
      return false;
    } else {
      bookmarkedMovies.add(movieId);
      await _preferences?.setStringList(bookmarks, bookmarkedMovies);
      return true;
    }

  }
  
  static bool isBookmarked(String movieId) {
    final bookmarkedMovies = _preferences?.getStringList(bookmarks);
    return bookmarkedMovies!= null && bookmarkedMovies.contains(movieId);
  }

  static List<String> getAllBookmarkedIds() {
    return _preferences?.getStringList(bookmarks) ?? [];
  }

  static Future<List<String>> getAllBookmarked()async {
    final movieIds = _preferences?.getStringList(bookmarks) ?? [];
    List<String> movies = [];

    for (String id in movieIds) {
      final String movie = await getMovie(id);
      movies.add(movie);
    }

    return movies;
  }
}

 Future<String> getMovie(String id) async {
  String baseUrl = getBaseUrl();
    try {
      final request = await http.Request('GET',Uri.parse('$baseUrl/$id'));
      http.StreamedResponse response = await request.send();
      if (response.statusCode == 200) {
        final http.Response result = await http.Response.fromStream(response);
        return result.body;
      } else {
        throw ServerException(
            statusCode: response.statusCode,
            message: "Failed to fetch movie data!!");
      }
    } catch (e) {
      throw ServerException(
          statusCode: 500, message: "Failed to fetch movie: $e");
    }
  }