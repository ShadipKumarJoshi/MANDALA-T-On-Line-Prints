import 'package:final_assignment/features/profile/data/model/profile_api_model.dart';
import 'package:json_annotation/json_annotation.dart';

part'profile_dto.g.dart';

@JsonSerializable()
class ProfileDto {
  final ProfileApiModel user;

  ProfileDto({
    required this.user,
  });


// to json
  Map<String, dynamic> toJson() => _$ProfileDtoToJson(this);

// from json
  factory ProfileDto.fromJson(Map<String, dynamic> json) =>
      _$ProfileDtoFromJson(json);
}
