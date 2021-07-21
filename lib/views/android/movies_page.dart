import 'package:flutter/material.dart';
import 'package:moviesdb/views/android/shared/movies_grid_list_view.dart';

class MoviesPage extends StatefulWidget {
  const MoviesPage({Key? key}) : super(key: key);

  @override
  _MoviesPageState createState() => _MoviesPageState();
}

class _MoviesPageState extends State<MoviesPage> {
  final tabs = {
    "now_playing": Tab(text: "Now playing"),
    "popular": Tab(text: "Popular"),
    "upcoming": Tab(text: "Upcoming"),
    "top_rated": Tab(text: "Top rated"),
  };

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        // The number of tabs / content sections to display.
        length: tabs.length,
        child: Center(
            child: Scaffold(
                appBar: AppBar(
                  title: Text("Movies"),
                  bottom: TabBar(
                    isScrollable: true,
                    tabs: tabs.values.toList(),
                  ),
                ),
                body: TabBarView(
                  children: tabs.keys
                      .map((e) => MoviesGridListView(category: e))
                      .toList(),
                ))));
  }
}
