import 'dart:io';

import 'package:moviesdb/apis/movie-db-api.dart';
import 'package:moviesdb/models/movie_list_result.dart';
import 'package:moviesdb/models/movie_result.dart';
import 'package:moviesdb/models/tv_list_result.dart';

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

  Future<List<MovieListResult>> getPopularMovies(int page) async {
    return await _movieDbApi.getPopularMovies(page, _locale, _region!);
  }

  Future<List<MovieListResult>> getMoviesByCategory(String category,
      [int page = 1]) async {
    return await _movieDbApi.getMoviesByCategory(
        category, page, _locale, _region!);
  }

  Future<MovieResult> getMovieDetails(int id) async {
    return await _movieDbApi.getMovieDetails(id);
  }

  Future<List<TvListResult>> getRandomTvShows(int page) async {
    return await _movieDbApi.getRandomTvShows(page, _locale, _region!);
  }
}
