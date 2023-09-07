import 'package:dartz/dartz.dart';
import 'package:mobile/core/error/failure.dart';
import 'package:mobile/core/network/network_info.dart';
import 'package:mobile/features/movie/data/datasources/movie_local_datasource.dart';
import 'package:mobile/features/movie/data/datasources/movie_remote_datasource.dart';
import 'package:mobile/features/movie/domain/entities/movie.dart';
import 'package:mobile/features/movie/domain/repositories/movie_repository.dart';

import '../../../../core/error/exception.dart';

class MovieRepositoryImpl implements MovieRepository {
  final MovieRemoteDatasource remoteDatasource;
  final MovieLocalDataSource localDataSource;
  final NetworkInfo networkInfo;

  MovieRepositoryImpl({
    required this.remoteDatasource,
    required this.localDataSource,
    required this.networkInfo,
  });

  @override
  Future<Either<Failure, List<Movie>>> getAllMovies() async {
    if (await networkInfo.isConnected) {
      try {
        final result = await remoteDatasource.getAllMovies();
        return Right(result);
      } on ServerException catch(_){
        return const Left(ServerFailure(message: "Couldn't Fetch movies", statusCode: 500));
        
      }
    } else {
      return const Left(ServerFailure(
        message: "Oops, No Intenet Connection",
        statusCode: 500,
      ));
    }
  }

  @override
  Future<Either<Failure, Movie>> getMovie({required String id}) async {
    if (await networkInfo.isConnected) {
       try {
        final result = await remoteDatasource.getMovie(id);
        return Right(result);
      } on ServerException catch(_){
        return const Left(ServerFailure(message: "Couldn't Fetch movie", statusCode: 500));
        
      }
    } else {
      return const Left(ServerFailure(
        message: "Oops, No Intenet Connection",
        statusCode: 500,
      ));
    }
  }

  @override
  Future<Either<Failure, List<Movie>>> searchMovies(
      {required String searchParams}) async{
    if (await networkInfo.isConnected) {
       try {
        final result = await remoteDatasource.searchMovies(searchParams);
        return Right(result);
      } on ServerException catch(_){
        return const Left(ServerFailure(message: "Couldn't Fetch movies", statusCode: 500));
        
      }
    } else {
      return const Left(ServerFailure(
        message: "Oops, No Intenet Connection",
        statusCode: 500,
      ));
    }
  }
  
  @override
  Future<Either<Failure, List<Movie>>> getBookmarkedMovies() async {
    if (await networkInfo.isConnected){
      try {
        final result = await localDataSource.getBookmarkedMovies();
        return Right(result);
      } catch (e) {
        return const Left(CacheFailure(message: "Couldn't Fetch bookmarks", statusCode: 500));
      }
    } else {
      return const Left(ServerFailure(
        message: "Oops, No Intenet Connection",
        statusCode: 500,
      ));
    }
  }
}
