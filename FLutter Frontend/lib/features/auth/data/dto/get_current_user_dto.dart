import 'package:final_assignment/features/auth/domain/entity/auth_entity.dart';
import 'package:json_annotation/json_annotation.dart';

part 'get_current_user_dto.g.dart';

@JsonSerializable()
class GetCurrentUserDto {
  @JsonKey(name: "_id")
  final String id;
  final String fullname;
  final String username;
  final String phoneNumber;
  final String email;

  GetCurrentUserDto({
    required this.id,
    required this.fullname,
    required this.username,
    required this.phoneNumber,
    required this.email,
  });

  AuthEntity toEntity() {
    return AuthEntity(
        id: id,
        fullname: fullname,
        username: username,
        phoneNumber: phoneNumber,
        email: email,
        password: '');
  }

  factory GetCurrentUserDto.fromJson(Map<String, dynamic> json) =>
      _$GetCurrentUserDtoFromJson(json);

  Map<String, dynamic> toJson() => _$GetCurrentUserDtoToJson(this);
}
