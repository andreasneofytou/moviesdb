import 'dart:io';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:moviesdb/apis/movie-db-api.dart';
import 'package:moviesdb/models/movie_result.dart';
import 'package:moviesdb/services/movies-service.dart';
import 'package:moviesdb/views/android/shared/movie_about_view.dart';

class MoviePage extends StatefulWidget {
  final int id;
  const MoviePage({Key? key, required this.id}) : super(key: key);

  @override
  _MoviePageState createState() => _MoviePageState();
}

class _MoviePageState extends State<MoviePage>
    with SingleTickerProviderStateMixin {
  final String locale = Platform.localeName;
  late final MoviesService moviesService;
  late ScrollController scrollController;
  late TabController tabController;
  MovieResult? movie;

  var pages = {
    "About": MovieAboutView(),
    "Cast": Center(child: Text("Cast Tab")),
    "Comments": Center(child: Text("Comments Tab")),
    "Reviews": Center(child: Text("Reviews Tab")),
    "Recommendations": Center(child: Text("Recommendations Tab")),
    "Similar": Center(child: Text("Similar Tab")),
  };

  _MoviePageState() {
    moviesService = MoviesService();
  }

  void getMovie() async {
    var res = await moviesService.getMovieDetails(widget.id);

    setState(() {
      movie = res;
      pages["About"] = MovieAboutView(movie: res);
    });
  }

  @override
  void initState() {
    super.initState();
    scrollController = ScrollController()
      ..addListener(() => setState(() => {}));
    tabController = TabController(length: pages.length, vsync: this)
      ..addListener(() => setState(() => {}));
    getMovie();
  }

  @override
  void dispose() {
    scrollController.dispose();
    tabController.dispose();
    super.dispose();
  }

  Widget buildFlexibleSpace() {
    Text? text;
    if (scrollController.hasClients) {
      double offset = scrollController.offset;
      if (offset > 130) {
        text = Text(
          movie!.title!,
        );
      }
    }

    return FlexibleSpaceBar(
        // titlePadding: EdgeInsets.only(left: 120),
        collapseMode: CollapseMode.pin,
        title: text,
        background: Image.network(
          MovieDbApi.BASE_IMAGE_URL + "/w500" + movie!.backdropPath!,
          fit: BoxFit.fitWidth,
        ));
  }

  Widget buildPoster() {
    //starting fab position
    final double defaultTopMargin = 150.0 - 4.0;
    //pixels from top where scaling should start
    final double scaleStart = 60.0;
    //pixels from top where scaling should end
    final double scaleEnd = scaleStart / 2;

    double top = defaultTopMargin;
    double scale = 1.0;
    if (scrollController.hasClients) {
      double offset = scrollController.offset;
      top -= offset;
      if (offset < defaultTopMargin - scaleStart) {
        //offset small => don't scale down
        scale = 1.0;
      } else if (offset < defaultTopMargin - scaleEnd) {
        //offset between scaleStart and scaleEnd => scale down
        scale = (defaultTopMargin - scaleEnd - offset) / scaleEnd;
      } else {
        //offset passed scaleEnd => hide fab
        scale = 0.0;
      }
    }

    return new Positioned(
      height: 130,
      top: top,
      left: 16.0,
      child: new Transform(
          transform: new Matrix4.identity()..scale(scale),
          alignment: Alignment.center,
          child: Image.network(
              MovieDbApi.BASE_IMAGE_URL + "/w154" + movie!.posterPath!)),
    );
  }

  @override
  Widget build(BuildContext context) {
    if (movie == null) {
      return Center(child: CircularProgressIndicator());
    } else {
      return Scaffold(
          body: Stack(children: [
        NestedScrollView(
          controller: scrollController,
          headerSliverBuilder: (context, innerBoxIsScrolled) {
            return <Widget>[
              SliverOverlapAbsorber(
                handle:
                    NestedScrollView.sliverOverlapAbsorberHandleFor(context),
                sliver: SliverSafeArea(
                  top: false,
                  sliver: SliverAppBar(
                    pinned: true,
                    snap: false,
                    floating: false,
                    stretch: true,
                    expandedHeight: 180.0,
                    flexibleSpace: buildFlexibleSpace(),
                  ),
                ),
              ),
              SliverToBoxAdapter(
                child: SizedBox(
                    child: Padding(
                        padding: EdgeInsets.only(left: 110),
                        child: Container(
                            padding: EdgeInsets.all(5),
                            child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    movie!.title!,
                                    style: TextStyle(fontSize: 22),
                                  ),
                                  Row(children: [
                                    Text(
                                      DateFormat.yMMMMd(locale)
                                          .format(movie!.releaseDate!),
                                      style: TextStyle(
                                          fontSize: 16, color: Colors.grey),
                                    ),
                                    Text(
                                      " · ",
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          color: Colors.grey),
                                    ),
                                    Text(movie!.runtime!.toString() + " mins",
                                        style: TextStyle(
                                            fontSize: 16, color: Colors.grey))
                                  ]),
                                  SizedBox(
                                    height: 15,
                                  )
                                ])))),
              ),
            ];
          },
          body: Container(
            padding: EdgeInsets.symmetric(vertical: 0),
            child: Column(
              children: <Widget>[
                TabBar(
                  labelColor: Theme.of(context).textTheme.headlineLarge!.color,
                  isScrollable: true,
                  controller: tabController,
                  tabs: pages.keys.map((e) => Tab(text: e)).toList(),
                ),
                Expanded(
                  child: Container(
                    child: TabBarView(
                      controller: tabController,
                      children: pages.values.toList(),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        buildPoster()
      ]));
    }
  }
}
