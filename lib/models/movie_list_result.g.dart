// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'movie_list_result.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MovieListResult _$MovieListResultFromJson(Map<String, dynamic> json) {
  return MovieListResult(
    json['id'] as int,
    (json['popularity'] as num).toDouble(),
    json['voteCount'] as int?,
    json['video'] as bool,
    json['poster_path'] == null ? "" : json['poster_path'] as String,
    json['adult'] as bool,
    json['backdrop_path'] == null ? "" : json['backdrop_path'] as String,
    json['original_language'] == null
        ? ""
        : json['original_language'] as String,
    json['original_title'] == null ? "" : json['original_title'] as String,
    (json['genre_ids'] as List<dynamic>).map((e) => e as int).toList(),
    json['title'] == null ? "" : json['title'] as String,
    (json['vote_average'] as num).toDouble(),
    json['overview'] == null ? "" : json['overview'] as String,
    DateTime.parse(json['release_date'] == null
        ? "1970-01-01"
        : json['release_date'] as String),
  );
}

Map<String, dynamic> _$MovieListResultToJson(MovieListResult instance) =>
    <String, dynamic>{
      'id': instance.id,
      'popularity': instance.popularity,
      'voteCount': instance.voteCount,
      'video': instance.hasVideo,
      'poster_path': instance.posterUrl,
      'adult': instance.isAdult,
      'backdrop_path': instance.backdropUrl,
      'original_language': instance.originalLang,
      'original_title': instance.originalTitle,
      'genre_ids': instance.genreIds,
      'title': instance.title,
      'vote_average': instance.voteAverage,
      'overview': instance.overview,
      'release_date': instance.releaseDate.toIso8601String(),
    };
