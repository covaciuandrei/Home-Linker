import 'package:cloud_firestore/cloud_firestore.dart';

class ImageDto {
  ImageDto(
    this.name,
    this.path,
    this.uploadDate,
  );

  factory ImageDto.fromJson(Map<String, dynamic> json) =>
      _$ImageDtoFromJson(json);

  Map<String, dynamic> toJson() => _$ImageDtoToJson(this);

  final String name;
  final String path;
  final DateTime uploadDate;
}

ImageDto _$ImageDtoFromJson(Map<String, dynamic> json) => ImageDto(
      json['name'] as String,
      json['path'] as String,
      (json['upload_date'] as Timestamp).toDate(),
    );

Map<String, dynamic> _$ImageDtoToJson(ImageDto instance) => <String, dynamic>{
      'name': instance.name,
      'path': instance.path,
      'upload_date': instance.uploadDate,
    };
