// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserDto _$UserDtoFromJson(Map<String, dynamic> json) => UserDto(
      json['email'] as String? ?? '',
      json['name'] as String? ?? '',
      json['phone'] as String? ?? '',
      json['profile_picture'] as String? ?? '',
      json['type'] as String? ?? '',
    );

Map<String, dynamic> _$UserDtoToJson(UserDto instance) => <String, dynamic>{
      'email': instance.email,
      'name': instance.name,
      'phone': instance.phone,
      'profile_picture': instance.profilePictureId,
      'type': instance.type,
    };
