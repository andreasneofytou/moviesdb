import 'package:json_annotation/json_annotation.dart';

part 'tv_list_result.g.dart';

@JsonSerializable()
class TvListResult {
  TvListResult(
      this.id,
      this.popularity,
      this.voteCount,
      this.posterUrl,
      this.backdropUrl,
      this.originalLang,
      this.originCountry,
      this.originalName,
      this.genreIds,
      this.name,
      this.voteAverage,
      this.overview,
      this.firstAirDate);

  int id;
  double popularity;
  int? voteCount;
  @JsonKey(name: 'poster_path')
  String posterUrl;
  @JsonKey(name: 'backdrop_path')
  String backdropUrl;
  @JsonKey(name: 'original_language')
  String originalLang;
  @JsonKey(name: 'original_name')
  String originalName;
  @JsonKey(name: 'origin_country')
  List<String> originCountry;
  @JsonKey(name: 'genre_ids')
  List<int> genreIds;
  String name;
  @JsonKey(name: 'vote_average')
  double voteAverage;
  String overview;
  @JsonKey(name: 'first_air_date')
  DateTime firstAirDate;

  factory TvListResult.fromJson(Map<String, dynamic> json) =>
      _$TvListResultFromJson(json);

  Map<String, dynamic> toJson() => _$TvListResultToJson(this);
}
