// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'get_all_carts_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GetAllCartsDto _$GetAllCartsDtoFromJson(Map<String, dynamic> json) =>
    GetAllCartsDto(
      carts: (json['carts'] as List<dynamic>)
          .map((e) => CartApiModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$GetAllCartsDtoToJson(GetAllCartsDto instance) =>
    <String, dynamic>{
      'carts': instance.carts,
    };
