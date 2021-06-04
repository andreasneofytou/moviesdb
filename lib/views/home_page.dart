import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:injector/injector.dart';
import 'package:moviesdb/apis/movie-db-api.dart';
import 'package:moviesdb/models/movie_list_result.dart';
import 'package:moviesdb/services/movies-service.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final injector = Injector.appInstance;
  late MoviesService moviesService;
  bool isLoading = false;

  _HomePageState() {
    moviesService = injector.get<MoviesService>();
  }

  var movies = <MovieListResult>[];
  void getMovies() async {
    isLoading = true;
    final res = await moviesService.getRandomMovies(1);
    if (!mounted) return;
    setState(() {
      movies = res;
    });
    isLoading = false;
  }

  @override
  void initState() {
    super.initState();
    getMovies();
  }

  @override
  Widget build(BuildContext context) {
    // return Text(AppLocalizations.of(context)!.appTitle);

    if (isLoading) {
      return Center(child: CircularProgressIndicator());
    } else if (movies.isEmpty) {
      return Center(
        child: Text("We couldn't find any movies"),
      );
    } else {
      // return GenericVerticalList(
      //     contentList: movies
      //         .map((i) => ListMediaItem(
      //             i.id, MoviesService.BASE_IMAGE_URL + "/w154" + i.posterUrl))
      //         .toList());
      return Container(
          margin: EdgeInsets.symmetric(vertical: 5.0),
          height: 154.0,
          child: ListView.builder(
              padding: EdgeInsets.fromLTRB(0, 0, 10, 0),
              itemCount: movies.length,
              scrollDirection: Axis.horizontal,
              itemBuilder: (context, index) {
                final item = movies[index];
                return Container(
                    padding: EdgeInsets.fromLTRB(10, 0, 0, 0),
                    height: 154.0,
                    width: 112.0,
                    child: InkWell(
                        // onTap: () => callback(item.id),
                        child: ClipRRect(
                            borderRadius: BorderRadius.circular(8.0),
                            child: Image.network(MovieDbApi.BASE_IMAGE_URL +
                                "/w154" +
                                item.posterUrl))));
              }));
    }
  }
}
