import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:injector/injector.dart';
import 'package:moviesdb/apis/movie-db-api.dart';
import 'package:moviesdb/models/ListMediaItem.dart';
import 'package:moviesdb/models/movie_list_result.dart';
import 'package:moviesdb/models/tv_list_result.dart';
import 'package:moviesdb/services/movies-service.dart';
import 'package:moviesdb/views/shared/horizontal_list.dart';

enum ViewAllType { MOVIES, TV_SHOWS }

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  void onViewAllTap(ViewAllType type) {
    if (type == ViewAllType.MOVIES) {
      // Navigator.push(
      //   context,
      //   MaterialPageRoute(builder: (context) => MoviesPage()),
      // );
    } else {
      // Navigator.push(
      //   context,
      //   MaterialPageRoute(builder: (context) => TvShowsPage()),
      // );
    }
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        Column(
          children: [
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
              Padding(
                  padding: EdgeInsets.fromLTRB(10, 10, 0, 0),
                  child: Text(
                    AppLocalizations.of(context)!.movies,
                    style: TextStyle(color: Colors.grey[600], fontSize: 20),
                  )),
              Padding(
                  padding: EdgeInsets.fromLTRB(0, 5, 15, 0),
                  child: TextButton(
                      onPressed: () => onViewAllTap(ViewAllType.MOVIES),
                      child: Text(
                        AppLocalizations.of(context)!.viewAll,
                        textAlign: TextAlign.end,
                        style: TextStyle(color: Colors.grey[500]),
                      ))),
            ]),
            MoviesHorizontalList()
          ],
        ),
        Column(
          children: [
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
              Padding(
                  padding: EdgeInsets.fromLTRB(10, 10, 0, 0),
                  child: Text(
                    AppLocalizations.of(context)!.tvShows,
                    style: TextStyle(color: Colors.grey[600], fontSize: 20),
                  )),
              Padding(
                  padding: EdgeInsets.fromLTRB(0, 5, 15, 0),
                  child: TextButton(
                      onPressed: () => onViewAllTap(ViewAllType.TV_SHOWS),
                      child: Text(
                        AppLocalizations.of(context)!.viewAll,
                        textAlign: TextAlign.end,
                        style: TextStyle(color: Colors.grey[500]),
                      ))),
            ]),
            TvHorizontalList()
          ],
        ),
      ],
    );
  }
}

class MoviesHorizontalList extends StatefulWidget {
  const MoviesHorizontalList({Key? key}) : super(key: key);

  @override
  _MoviesHorizontalListState createState() => _MoviesHorizontalListState();
}

class _MoviesHorizontalListState extends State<MoviesHorizontalList> {
  final injector = Injector.appInstance;
  late final MoviesService moviesService;
  var movies = <MovieListResult>[];
  bool isLoading = false;

  _MoviesHorizontalListState() {
    moviesService = injector.get<MoviesService>();
  }

  void getRandomMovies() async {
    isLoading = true;
    final res = await moviesService.getRandomMovies(1);
    if (!mounted) return;
    setState(() {
      movies = res;
    });
    isLoading = false;
  }

  void onMovieClick(int id) {
    // Navigator.push(
    //   context,
    //   MaterialPageRoute(builder: (context) => MoviePage(id)),
    // );
  }

  @override
  void initState() {
    super.initState();
    getRandomMovies();
  }

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return Center(child: CircularProgressIndicator());
    } else if (movies.isEmpty) {
      return Center(
        child: Text("Something went wrong"),
      );
    } else {
      return HorizontalList(
        movies
            .map((i) => ListMediaItem(
                i.id, MovieDbApi.BASE_IMAGE_URL + "/w154" + i.posterUrl))
            .toList(),
        onMovieClick,
      );
    }
  }
}

class TvHorizontalList extends StatefulWidget {
  @override
  _TvHorizontalListState createState() => _TvHorizontalListState();
}

class _TvHorizontalListState extends State<TvHorizontalList> {
  final injector = Injector.appInstance;
  late final MoviesService moviesService;
  var shows = <TvListResult>[];
  bool isLoading = false;

  _TvHorizontalListState() {
    moviesService = injector.get<MoviesService>();
  }

  void getRandomTvShows() async {
    isLoading = true;
    final res = await moviesService.getRandomTvShows(1);
    setState(() {
      shows = res;
    });
    isLoading = false;
  }

  void onTvShowClick(int id) {
    // Navigator.push(
    //   context,
    //   MaterialPageRoute(builder: (context) => MoviePage(id)),
    // );
  }

  @override
  void initState() {
    super.initState();
    getRandomTvShows();
  }

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return Center(child: CircularProgressIndicator());
    } else if (shows.isEmpty) {
      return Center(
        child: Text("Something went wrong"),
      );
    } else {
      return HorizontalList(
          shows
              .map((i) => ListMediaItem(
                  i.id, MovieDbApi.BASE_IMAGE_URL + "/w154" + i.posterUrl))
              .toList(),
          onTvShowClick);
    }
  }
}
