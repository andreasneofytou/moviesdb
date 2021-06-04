import 'package:json_annotation/json_annotation.dart';

part 'movie_list_result.g.dart';

@JsonSerializable()
class MovieListResult {
  MovieListResult(
      this.id,
      this.popularity,
      this.voteCount,
      this.hasVideo,
      this.posterUrl,
      this.isAdult,
      this.backdropUrl,
      this.originalLang,
      this.originalTitle,
      this.genreIds,
      this.title,
      this.voteAverage,
      this.overview,
      this.releaseDate);

  int id;
  double popularity;
  int? voteCount;
  @JsonKey(name: 'video')
  bool hasVideo;
  @JsonKey(name: 'poster_path')
  String posterUrl;
  @JsonKey(name: 'adult')
  bool isAdult;
  @JsonKey(name: 'backdrop_path')
  String backdropUrl;
  @JsonKey(name: 'original_language')
  String originalLang;
  @JsonKey(name: 'original_title')
  String originalTitle;
  @JsonKey(name: 'genre_ids')
  List<int> genreIds;
  String title;
  @JsonKey(name: 'vote_average')
  double voteAverage;
  String overview;
  @JsonKey(name: 'release_date')
  DateTime releaseDate;

  factory MovieListResult.fromJson(Map<String, dynamic> json) =>
      _$MovieListResultFromJson(json);

  Map<String, dynamic> toJson() => _$MovieListResultToJson(this);
}
