import 'package:dartz/dartz.dart';
import 'package:mobile/core/error/failure.dart';
import 'package:mobile/core/use_case/usecase.dart';
import 'package:mobile/features/movie/domain/entities/movie.dart';
import 'package:mobile/features/movie/domain/repositories/movie_repository.dart';

class SearchMovieUsecase implements UseCase<List<Movie>, String>{
  final MovieRepository _repository;

  SearchMovieUsecase(this._repository);

  @override
  Future<Either<Failure, List<Movie>>> call(String searchParms) {
    return _repository.searchMovies(searchParams: searchParms);
  }
}