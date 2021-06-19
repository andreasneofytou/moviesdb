// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'tv_list_result.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TvListResult _$TvListResultFromJson(Map<String, dynamic> json) {
  return TvListResult(
    json['id'] as int,
    (json['popularity'] as num).toDouble(),
    json['voteCount'] as int?,
    json['poster_path'] as String,
    json['backdrop_path'] as String,
    json['original_language'] as String,
    (json['origin_country'] as List<dynamic>).map((e) => e as String).toList(),
    json['original_name'] as String,
    (json['genre_ids'] as List<dynamic>).map((e) => e as int).toList(),
    json['name'] as String,
    (json['vote_average'] as num).toDouble(),
    json['overview'] as String,
    DateTime.parse(json['first_air_date'] as String),
  );
}

Map<String, dynamic> _$TvListResultToJson(TvListResult instance) =>
    <String, dynamic>{
      'id': instance.id,
      'popularity': instance.popularity,
      'voteCount': instance.voteCount,
      'poster_path': instance.posterUrl,
      'backdrop_path': instance.backdropUrl,
      'original_language': instance.originalLang,
      'original_name': instance.originalName,
      'origin_country': instance.originCountry,
      'genre_ids': instance.genreIds,
      'name': instance.name,
      'vote_average': instance.voteAverage,
      'overview': instance.overview,
      'first_air_date': instance.firstAirDate.toIso8601String(),
    };
