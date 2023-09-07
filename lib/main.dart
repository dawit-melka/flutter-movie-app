import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobile/alem_cinema.dart';
import 'package:mobile/core/util/bloc_observer.dart';
import 'package:mobile/core/util/bookmark_preferences.dart';
import 'injection/injection_container.dart' as dependency_injection;
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dependency_injection.init();
  await BookmarkPreferences.init();
  // Bloc.observer = AppBlocObserver();
  runApp(const AlemCinema());
}
