import 'package:flutter/material.dart';
import 'package:moviesdb/models/movie_result.dart';

class MovieAboutView extends StatefulWidget {
  final MovieResult? movie;
  const MovieAboutView({Key? key, this.movie}) : super(key: key);

  @override
  _MovieAboutViewState createState() => _MovieAboutViewState();
}

class _MovieAboutViewState extends State<MovieAboutView> {
  var aboutMaxLine = 3;
  var expandedAbout = false;

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              widget.movie?.overview ?? "No description",
              maxLines: aboutMaxLine,
              overflow: TextOverflow.ellipsis,
            ),
            Padding(
                padding: EdgeInsets.symmetric(vertical: 10),
                child: InkWell(
                    onTap: () => setState(() {
                          expandedAbout = !expandedAbout;
                          aboutMaxLine = expandedAbout ? 20 : 3;
                        }),
                    child: Text(
                      expandedAbout ? "Less" : "Read more",
                      style:
                          TextStyle(color: ColorScheme.fromSwatch().secondary),
                    ))),
            SizedBox(
              height: 10,
            ),
            Text("Genres"),
            Wrap(
                children: widget.movie!.genres!
                    .map((e) => Padding(
                        padding: EdgeInsets.only(right: 5),
                        child: Chip(
                          label: Text(e.name!),
                        )))
                    .toList()),
            SizedBox(
              height: 10,
            ),
            Text("Movie info"),
            Row(
              children: [
                Expanded(
                    flex: 1,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("Original Title"),
                        Text("Col2"),
                      ],
                    )),
                Expanded(
                    flex: 1,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(widget.movie!.originalTitle!),
                        Text("Col2"),
                      ],
                    ))
              ],
            )
          ],
        ));
  }
}
