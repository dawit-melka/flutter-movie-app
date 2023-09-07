import 'package:get_it/get_it.dart';
import 'package:http/http.dart' as http;
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:mobile/features/movie/data/datasources/movie_local_datasource.dart';
import 'package:mobile/features/movie/domain/usecases/get_bookmarked_movies.dart';
import 'package:mobile/features/movie/presentation/bloc/movie_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../core/network/network_info.dart';
import '../features/movie/data/datasources/movie_remote_datasource.dart';
import '../features/movie/data/repository/movie_repository_impl.dart';
import '../features/movie/domain/repositories/movie_repository.dart';
import '../features/movie/domain/usecases/get_all_movies.dart';
import '../features/movie/domain/usecases/get_movie.dart';
import '../features/movie/domain/usecases/search_movies.dart';

final sl = GetIt.instance;

Future<void> init() async {
  sl.registerFactory(
    () => MovieBloc(
      getAllMovies: sl(),
      getMovie: sl(),
      searchMovie: sl(),
      getBookmarked: sl(),
    ),
  );
  sl.registerLazySingleton(() => GetAllMoviesUsecase(sl()));
  sl.registerLazySingleton(() => GetMovieUsecase(sl()));
  sl.registerLazySingleton(() => SearchMovieUsecase(sl()));
  sl.registerLazySingleton(() => GetBookmarkedMoviesUsecase(sl()));

  sl.registerLazySingleton<MovieRepository>(() => MovieRepositoryImpl(
        remoteDatasource: sl(),
        localDataSource: sl(),
        networkInfo: sl(),
      ));

  sl.registerLazySingleton<MovieRemoteDatasource>(
      () => MovieRemoteDatasourceImpl(client: sl()));
  
  sl.registerLazySingleton<MovieLocalDataSource>(() => MovieLocalDataSourceImpl());

  // sl.registerLazySingleton(() => MovieBloc(
  //       getAllMovies: sl(),
  //       getMovie: sl(),
  //       searchMovie: sl(),
  //       getBookmarked: sl(),
  //     ));

  sl.registerLazySingleton<NetworkInfo>(() => NetworkInfoImpl(sl()));

  sl.registerLazySingleton(() => InternetConnectionChecker());

  sl.registerLazySingleton(() => http.Client());

  final sharedPreferences = await SharedPreferences.getInstance();
  sl.registerLazySingleton(() => sharedPreferences);
}
