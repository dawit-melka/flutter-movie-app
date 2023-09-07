import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:mobile/features/movie/presentation/bloc/movie_bloc.dart';
import 'package:mobile/features/movie/presentation/screens/home_screen.dart';
import 'package:mobile/features/movie/presentation/screens/movie_detail.dart';
import 'package:mobile/features/onboarding/presentation/screens/onboarding_page.dart';
import 'package:mobile/injection/injection_container.dart';

class AlemCinema extends StatelessWidget {
  const AlemCinema({super.key});

  @override
  Widget build(BuildContext context) {
    final GoRouter router =
        GoRouter(navigatorKey: GlobalKey<NavigatorState>(), routes: [
      GoRoute(path: '/', builder: (context, state) => OnboardingScreen()),
      GoRoute(
        path: '/movie',
        builder: (context, state) => MovieDetailScreen(
          id: state.extra! as String,
        ),
      ),
      GoRoute(path: '/home', builder: (context, state) => HomeScreen())
    ]);
    return MaterialApp(
        title: "Alem Cinema",
        debugShowCheckedModeBanner: false,
        home: BlocProvider(
          create: (context) => sl<MovieBloc>(),
          child: MaterialApp.router(
            debugShowCheckedModeBanner: false,
            routerConfig: router,
          ),
        )

        // home: MultiBlocProvider(
        //   providers: [],
        //   child: MaterialApp.router(
        //     debugShowCheckedModeBanner: false,
        //     routerConfig: router,
        //   ),
        // ),
        // home: MaterialApp.router(
        //   debugShowCheckedModeBanner: false,
        //   routerConfig: router,
        // ),
        );
  }
}
