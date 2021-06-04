import 'dart:io';

import 'package:moviesdb/apis/movie-db-api.dart';
import 'package:moviesdb/models/movie_list_result.dart';

class MoviesService {
  final String _locale = Platform.localeName;
  final MovieDbApi _movieDbApi;
  String? _region;

  MoviesService(this._movieDbApi) {
    _region = _locale.split('_').last;
  }

  Future<List<MovieListResult>> getRandomMovies(int page) async {
    return await _movieDbApi.getRandomMovies(page, _locale, _region!);
  }
}
