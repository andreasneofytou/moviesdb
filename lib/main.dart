import 'dart:io';

import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:injector/injector.dart';
import 'package:moviesdb/apis/movie-db-api.dart';
import 'package:moviesdb/services/movies-service.dart';

import 'main_android.dart';

void main() {
  // Use this static instance
  final injector = Injector.appInstance;

  // Register a dependency
  injector.registerDependency<MovieDbApi>(() => MovieDbApi());
  injector.registerDependency<MoviesService>(() {
    var api = injector.get<MovieDbApi>();
    return MoviesService(api);
  });

  runApp(Main());
}

class Main extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);

    if (Platform.isIOS) {
      return MainAndroid();
    }
    return MainAndroid();
  }
}
