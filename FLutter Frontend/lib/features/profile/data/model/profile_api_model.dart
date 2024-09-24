import 'package:equatable/equatable.dart';
import 'package:final_assignment/features/profile/domain/entity/profile_entity.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:json_annotation/json_annotation.dart';

part 'profile_api_model.g.dart';

final profileApiModelProvider = Provider<ProfileApiModel>((ref) {
  return const ProfileApiModel.empty();
});

@JsonSerializable()
class ProfileApiModel extends Equatable {
  @JsonKey(name: '_id')
  final String? id;
  final String? fullName;
  final String? userName;
  final String? phoneNumber;
  final String? email;
  final String? userAddress;
  final String? userOptionalAddress;
  final String? userImage;

  const ProfileApiModel({
    this.id,
    required this.fullName,
    required this.userName,
    required this.phoneNumber,
    required this.email,
    required this.userAddress,
    required this.userOptionalAddress,
    required this.userImage,
  });

  // Empty constructor
  const ProfileApiModel.empty()
      : id = '',
        fullName = '',
        userName = '',
        phoneNumber = '',
        email = '',
        userAddress = '',
        userOptionalAddress = '',
        userImage = '';

  factory ProfileApiModel.fromJson(Map<String, dynamic> json) =>
      _$ProfileApiModelFromJson(json);

  Map<String, dynamic> toJson() => _$ProfileApiModelToJson(this);

// To entity
  ProfileEntity toEntity(user) {
    return ProfileEntity(
      id: id,
      fullName: fullName,
      userName: userName,
      phoneNumber: phoneNumber,
      email: email,
      userAddress: userAddress,
      userOptionalAddress: userOptionalAddress,
      userImage: userImage,
    );
  }

// From entity
  factory ProfileApiModel.fromEntity(ProfileEntity entity) {
    return ProfileApiModel(
      fullName: entity.fullName,
      userName: entity.userName,
      phoneNumber: entity.phoneNumber,
      email: entity.email,
      userAddress: entity.userAddress,
      userOptionalAddress: entity.userOptionalAddress,
      userImage: entity.userImage,
    );
  }

  @override
  List<Object?> get props => [
        id,
        fullName,
        userName,
        phoneNumber,
        email,
        userAddress,
        userOptionalAddress,
        userImage,
      ];
}
