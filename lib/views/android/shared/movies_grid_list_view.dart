import 'package:flutter/material.dart';
import 'package:moviesdb/apis/movie-db-api.dart';
import 'package:moviesdb/models/movie_list_result.dart';
import 'package:moviesdb/services/movies-service.dart';
import 'package:moviesdb/views/android/movie_page.dart';

class MoviesGridListView extends StatefulWidget {
  final String category;
  const MoviesGridListView({Key? key, required this.category})
      : super(key: key);

  @override
  _MoviesGridListViewState createState() => _MoviesGridListViewState();
}

class _MoviesGridListViewState extends State<MoviesGridListView> {
  late final MoviesService moviesService;
  ScrollController? controller;
  var movies = <MovieListResult>[];
  var page = 1;

  _MoviesGridListViewState() {
    moviesService = MoviesService();
  }

  void scrollListener() async {
    if (page * 20 <= movies.length && controller!.position.extentAfter < 501) {
      page++;
      getMovies();
    }
  }

  void getMovies() async {
    var res = await moviesService.getMoviesByCategory(widget.category, page);
    setState(() {
      movies.addAll(res);
    });
  }

  void onTapMovie(int id) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => MoviePage(id: id)),
    );
  }

  @override
  void initState() {
    super.initState();
    getMovies();
    controller = ScrollController()..addListener(scrollListener);
  }

  @override
  void dispose() {
    controller!.removeListener(scrollListener);

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

    final double itemHeight = size.height / 1;
    final double itemWidth = size.width / .75;

    return GridView.count(
        controller: controller,
        padding: EdgeInsets.symmetric(horizontal: 5),
        crossAxisCount: 3,
        childAspectRatio: (itemWidth / itemHeight),
        children: movies
            .map((item) => Padding(
                padding: EdgeInsets.symmetric(horizontal: 5),
                child: Center(
                    child: InkWell(
                        onTap: () => onTapMovie(item.id),
                        child: ClipRRect(
                            borderRadius: BorderRadius.circular(8.0),
                            child: item.posterUrl != ""
                                ? Image.network(MovieDbApi.BASE_IMAGE_URL +
                                    "/w154" +
                                    item.posterUrl)
                                : Image.asset(
                                    "assets/images/No_Image_Available.jpg"))))))
            .toList());
  }
}
