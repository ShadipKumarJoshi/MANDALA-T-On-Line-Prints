// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'get_current_user_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GetCurrentUserDto _$GetCurrentUserDtoFromJson(Map<String, dynamic> json) =>
    GetCurrentUserDto(
      id: json['_id'] as String,
      fullname: json['fullname'] as String,
      username: json['username'] as String,
      phoneNumber: json['phoneNumber'] as String,
      email: json['email'] as String,
    );

Map<String, dynamic> _$GetCurrentUserDtoToJson(GetCurrentUserDto instance) =>
    <String, dynamic>{
      '_id': instance.id,
      'fullname': instance.fullname,
      'username': instance.username,
      'phoneNumber': instance.phoneNumber,
      'email': instance.email,
    };
