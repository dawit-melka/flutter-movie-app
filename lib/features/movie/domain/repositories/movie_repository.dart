import 'package:dartz/dartz.dart';
import 'package:mobile/features/movie/domain/entities/movie.dart';

import '../../../../core/error/failure.dart';

abstract class MovieRepository {
  Future<Either<Failure, Movie>> getMovie({required String id});
  Future<Either<Failure, List<Movie>>> getAllMovies();
  Future<Either<Failure, List<Movie>>> searchMovies({required String searchParams});
  Future<Either<Failure, List<Movie>>> getBookmarkedMovies();
  // Future<Either<Failure, >
}