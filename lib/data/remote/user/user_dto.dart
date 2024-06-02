import 'package:json_annotation/json_annotation.dart';

part 'user_dto.g.dart';

@JsonSerializable()
class UserDto {
  UserDto(
    this.email,
    this.is2FaActivated,
    this.name,
    this.phone,
    this.profilePictureId,
    this.type,
  );

  factory UserDto.fromJson(Map<String, dynamic> json) => _$UserDtoFromJson(json);

  Map<String, dynamic> toJson() => _$UserDtoToJson(this);

  @JsonKey(name: 'email', defaultValue: '')
  final String email;

  @JsonKey(name: 'is_2fa_activated', defaultValue: false)
  final bool is2FaActivated;

  @JsonKey(name: 'name', defaultValue: '')
  final String name;

  @JsonKey(name: 'phone', defaultValue: '')
  final String phone;

  @JsonKey(name: 'profile_picture', defaultValue: '')
  final String profilePictureId;

  @JsonKey(name: 'type', defaultValue: '')
  final String type;
}
