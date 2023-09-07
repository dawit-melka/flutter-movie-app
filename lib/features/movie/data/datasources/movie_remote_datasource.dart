import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:mobile/core/error/exception.dart';
import 'package:mobile/core/util/constants.dart';
import 'package:mobile/features/movie/data/models/movie_model.dart';

abstract class MovieRemoteDatasource {
  Future<MovieModel> getMovie(String id);
  Future<List<MovieModel>> getAllMovies();
  Future<List<MovieModel>> searchMovies(String searchParams);
}

class MovieRemoteDatasourceImpl implements MovieRemoteDatasource {
  final http.Client client;

  MovieRemoteDatasourceImpl({required this.client});
  final uriString = 'https://film-db.onrender.com/api/v1/article';
  String baseUrl = getBaseUrl();
  @override
  Future<List<MovieModel>> getAllMovies() async {
    debugPrint("+++++============ I read remote ds");
    try {
      final response = await client.get(Uri.parse(baseUrl));
      if (response.statusCode == 200) {
        List<dynamic> jsonResponse = jsonDecode(response.body)["data"];
        print('Helloooooo$jsonResponse');
        List<MovieModel> result = [];
        for (Map<String, dynamic> data in jsonResponse) {
          print(data);
          try {
            result.add(MovieModel.fromMap(data));
          } catch (e) {
            print('ooooops$e');
          }
          print(result);
        }
        // jsonResponse
        //     .map((movieData) {
        //       print("xxx$movieData");
        //       final m = MovieModel.fromMap(movieData);
        //       print ("yyyyyyyyy$m");
        //       return m;
        //       })
        //     .toList();
        // print('Hiiiiiiiiii$result');
        return result;
      } else {
        print("NOOOOO");
        throw ServerException(
            statusCode: response.statusCode,
            message: "Failed to fetch movies data!!");
      }
    } catch (e) {
      throw ServerException(
          statusCode: 500, message: "Failed to fetch movies: $e");
    }
  }

  @override
  Future<MovieModel> getMovie(String id) async {
    try {
      final response = await client.get(Uri.parse('$baseUrl/$id'));
      if (response.statusCode == 200) {
        Map<String, dynamic> jsonResponse = jsonDecode(response.body)["data"];
        MovieModel result = MovieModel.fromMap(jsonResponse);
        return result;
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

  @override
  Future<List<MovieModel>> searchMovies(String searchParams) async {
    try {
      final response =
          await client.get(Uri.parse('$baseUrl?searchParams=$searchParams'));
      if (response.statusCode == 200) {
        List<dynamic> jsonResponse = jsonDecode(response.body)["data"];
        List<MovieModel> result = jsonResponse
            .map((movieData) => MovieModel.fromMap(movieData))
            .toList();
        return result;
      } else {
        throw ServerException(
            statusCode: response.statusCode,
            message: "Failed to fetch movies data!!");
      }
    } catch (e) {
      throw ServerException(
          statusCode: 500, message: "Failed to fetch movies: $e");
    }
  }
}
