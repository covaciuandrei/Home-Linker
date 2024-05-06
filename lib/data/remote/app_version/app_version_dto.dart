import 'package:cloud_firestore/cloud_firestore.dart';

class AppVersionDto {
  AppVersionDto(
    this.appVersion,
    this.releaseDate,
  );

  factory AppVersionDto.fromJson(Map<String, dynamic> json) => _$AppVersionDtoFromJson(json);

  Map<String, dynamic> toJson() => _$AppVersionDtoToJson(this);

  final String appVersion;
  final DateTime releaseDate;
}

AppVersionDto _$AppVersionDtoFromJson(Map<String, dynamic> json) => AppVersionDto(
      json['app_version'] as String,
      (json['release_date'] as Timestamp).toDate(),
    );

Map<String, dynamic> _$AppVersionDtoToJson(AppVersionDto instance) => <String, dynamic>{
      'app_version': instance.appVersion,
      'release_date': instance.releaseDate,
    };
