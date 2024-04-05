import 'package:json_annotation/json_annotation.dart';

part 'user_dto.g.dart';

@JsonSerializable()
class UserDto {
  UserDto(
    this.email,
    this.name,
    this.phone,
    this.profilePicturePath,
    this.type,
  );

  factory UserDto.fromJson(Map<String, dynamic> json) =>
      _$UserDtoFromJson(json);

  Map<String, dynamic> toJson() => _$UserDtoToJson(this);

  @JsonKey(name: 'email', defaultValue: '')
  final String email;

  @JsonKey(name: 'name', defaultValue: '')
  final String name;

  @JsonKey(name: 'phone', defaultValue: '')
  final String phone;

  @JsonKey(name: 'profile_picture_path', defaultValue: '')
  final String profilePicturePath;

  @JsonKey(name: 'type', defaultValue: '')
  final String type;
}
