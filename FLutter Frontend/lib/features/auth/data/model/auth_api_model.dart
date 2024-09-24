import 'package:final_assignment/features/auth/domain/entity/auth_entity.dart';
import 'package:json_annotation/json_annotation.dart';

part 'auth_api_model.g.dart';

@JsonSerializable()
class AuthApiModel {
  @JsonKey(name: '_id')
  final String? id;
  final String fullname;
  final String username;
  final String phoneNumber;
  final String email;
  final String? password;

  AuthApiModel({
    this.id,
    required this.fullname,
    required this.username,
    required this.phoneNumber,
    required this.email,
    required this.password,
  });

  // empty api model
  factory AuthApiModel.empty() {
    return AuthApiModel(
      id: '',
      fullname: '',
      username: '',
      phoneNumber: '',
      email: '',
      password: '',
    );
  }

  factory AuthApiModel.fromJson(Map<String, dynamic> json) =>
      _$AuthApiModelFromJson(json);

  Map<String, dynamic> toJson() => _$AuthApiModelToJson(this);

  // To Entity
  AuthEntity toEntity() {
    return AuthEntity(
      id: id,
      fullname: fullname,
      username: username,
      phoneNumber: phoneNumber,
      email: email,
      password: password ?? '',
    );
  }

//   From entity
  factory AuthApiModel.fromEntity(AuthEntity entity) {
    return AuthApiModel(
      id: entity.id,
      fullname: entity.fullname,
      username: entity.username,
      phoneNumber: entity.phoneNumber,
      email: entity.email,
      password: entity.password,
    );
  }
}
