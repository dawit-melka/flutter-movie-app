import 'package:dartz/dartz.dart';
import 'package:mobile/core/use_case/usecase.dart';
import 'package:mobile/features/movie/domain/entities/movie.dart';
import 'package:mobile/features/movie/domain/repositories/movie_repository.dart';

import '../../../../core/error/failure.dart';

class GetAllMoviesUsecase implements UseCase<List<Movie>, NoParams>{
  final MovieRepository _repository;

  GetAllMoviesUsecase(this._repository);

  @override
  Future<Either<Failure, List<Movie>>> call(NoParams params) async {
    return _repository.getAllMovies();
  }
}