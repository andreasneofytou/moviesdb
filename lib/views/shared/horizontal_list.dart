import 'package:flutter/material.dart';
import 'package:moviesdb/apis/movie-db-api.dart';
import 'package:moviesdb/models/ListMediaItem.dart';

class HorizontalList extends StatelessWidget {
  final List<ListMediaItem> _contentList;
  final void Function(int) _callback;
  const HorizontalList(this._contentList, this._callback, {Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: EdgeInsets.symmetric(vertical: 5.0),
        height: 154.0,
        child: ListView.builder(
            padding: EdgeInsets.fromLTRB(0, 0, 10, 0),
            itemCount: _contentList.length,
            scrollDirection: Axis.horizontal,
            itemBuilder: (context, index) {
              final item = _contentList[index];
              return Container(
                  padding: EdgeInsets.fromLTRB(10, 0, 0, 0),
                  height: 154.0,
                  width: 112.0,
                  child: InkWell(
                      onTap: () => _callback(item.id),
                      child: ClipRRect(
                          borderRadius: BorderRadius.circular(8.0),
                          child: Image.network(MovieDbApi.BASE_IMAGE_URL +
                              "/w154" +
                              item.imageUrl))));
            }));
  }
}
