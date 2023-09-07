import 'package:dartz/dartz.dart';
import 'package:mobile/core/error/failure.dart';
import 'package:mobile/core/use_case/usecase.dart';
import 'package:mobile/features/movie/domain/entities/movie.dart';

import '../repositories/movie_repository.dart';

class GetMovieUsecase implements UseCase<Movie, String> {
  final MovieRepository _repository;

  GetMovieUsecase(this._repository);

  @override
  Future<Either<Failure, Movie>> call(String id) {
    return _repository.getMovie(id: id);
  }
  
} 