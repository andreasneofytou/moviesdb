import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:moviesdb/models/movie_list_result.dart';
import 'package:moviesdb/models/movie_result.dart';
import 'package:moviesdb/models/tv_list_result.dart';

class MovieDbApi {
  static const String BASE_URL = 'https://api.themoviedb.org/3';
  static const String BASE_IMAGE_URL = 'https://image.tmdb.org/t/p';
  static const String TOKEN =
      'eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiJiNjBkYjU2YjdiN2QwNjA2OTA0ZmUzZDhmYjI2MDE3ZiIsInN1YiI6IjVmNjcwYjFhODQ0NDhlMDAzNzc1OGY0NCIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.qwHOfUIjdG75HlWO4dy1vvLSQ748gevTYOnWbpeOjG0';

  Future<List<MovieListResult>> getRandomMovies(
      [int page = 1, String locale = 'en_US', String region = 'us']) async {
    final url = Uri.parse(
        '$BASE_URL/discover/movie?language=$locale&region=$region&sort_by=popularity.desc&include_adult=false&include_video=false&page=$page');
    final response = await http
        .get(url, headers: {HttpHeaders.authorizationHeader: 'Bearer $TOKEN'});

    if (response.statusCode == 200 && response.body.isNotEmpty) {
      // If the server did return a 200 OK response,
      // then parse the JSON.
      List<MovieListResult> movies =
          ((json.decode(response.body))["results"] as List)
              .map((data) => MovieListResult.fromJson(data))
              .toList();

      return movies;
    }
    return <MovieListResult>[];
  }

  Future<MovieResult> getMovieDetails(
      [int id = 1, String locale = 'en_US', String region = 'us']) async {
    final url =
        Uri.parse('$BASE_URL/movie/$id?language=$locale&region=$region');
    final response = await http
        .get(url, headers: {HttpHeaders.authorizationHeader: 'Bearer $TOKEN'});

    if (response.statusCode == 200 && response.body.isNotEmpty) {
      // If the server did return a 200 OK response,
      // then parse the JSON.
      MovieResult movie = MovieResult.fromJson(json.decode(response.body));

      return movie;
    }
    return MovieResult();
  }

  Future<List<MovieListResult>> getPopularMovies(
      [int page = 1, String locale = 'en_US', String region = 'us']) async {
    final url = Uri.parse(
        '$BASE_URL/movie/popular?language=$locale&region=$region&sort_by=popularity.desc&include_adult=false&include_video=false&page=$page');
    final response = await http
        .get(url, headers: {HttpHeaders.authorizationHeader: 'Bearer $TOKEN'});

    if (response.statusCode == 200 && response.body.isNotEmpty) {
      // If the server did return a 200 OK response,
      // then parse the JSON.
      List<MovieListResult> movies =
          ((json.decode(response.body))["results"] as List)
              .map((data) => MovieListResult.fromJson(data))
              .toList();

      return movies;
    }
    return <MovieListResult>[];
  }

  Future<List<MovieListResult>> getMoviesByCategory(String category,
      [int page = 1, String locale = 'en_US', String region = 'us']) async {
    final url = Uri.parse(
        '$BASE_URL/movie/$category?language=$locale&region=$region&sort_by=popularity.desc&include_adult=false&include_video=false&page=$page');
    final response = await http
        .get(url, headers: {HttpHeaders.authorizationHeader: 'Bearer $TOKEN'});

    if (response.statusCode == 200 && response.body.isNotEmpty) {
      // If the server did return a 200 OK response,
      // then parse the JSON.
      List<MovieListResult> movies =
          ((json.decode(response.body))["results"] as List)
              .map((data) => MovieListResult.fromJson(data))
              .toList();

      return movies;
    }
    return <MovieListResult>[];
  }

  Future<List<TvListResult>> getPopularTvShows(
      [int page = 1, String locale = 'en_US', String region = 'us']) async {
    final url = Uri.parse(
        '$BASE_URL/tv/popular?language=$locale&region=$region&sort_by=popularity.desc&include_adult=false&include_video=false&page=$page');
    final response = await http
        .get(url, headers: {HttpHeaders.authorizationHeader: 'Bearer $TOKEN'});

    if (response.statusCode == 200 && response.body.isNotEmpty) {
      // If the server did return a 200 OK response,
      // then parse the JSON.
      List<TvListResult> shows =
          ((json.decode(response.body))["results"] as List)
              .map((data) => TvListResult.fromJson(data))
              .toList();

      return shows;
    }
    return <TvListResult>[];
  }

  Future<List<TvListResult>> getRandomTvShows(
      [int page = 1, String locale = 'en_US', String region = 'us']) async {
    final url = Uri.parse(
        '$BASE_URL/discover/tv?language=$locale&region=$region&sort_by=popularity.desc&include_adult=false&include_video=false&page=$page');
    final response = await http
        .get(url, headers: {HttpHeaders.authorizationHeader: 'Bearer $TOKEN'});

    if (response.statusCode == 200 && response.body.isNotEmpty) {
      // If the server did return a 200 OK response,
      // then parse the JSON.
      List<TvListResult> tvShows =
          ((json.decode(response.body))["results"] as List)
              .map((data) => TvListResult.fromJson(data))
              .toList();

      return tvShows;
    }
    return <TvListResult>[];
  }
}
