// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'design_api_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DesignApiModel _$DesignApiModelFromJson(Map<String, dynamic> json) =>
    DesignApiModel(
      id: json['_id'] as String?,
      designName: json['designName'] as String,
      designPrice: (json['designPrice'] as num).toDouble(),
      designCategory: json['designCategory'] as String,
      designDescription: json['designDescription'] as String,
      designImage: json['designImage'] as String,
      createAt: json['createAt'] as String,
      createdBy: json['createdBy'] as String,
    );

Map<String, dynamic> _$DesignApiModelToJson(DesignApiModel instance) =>
    <String, dynamic>{
      '_id': instance.id,
      'designName': instance.designName,
      'designPrice': instance.designPrice,
      'designCategory': instance.designCategory,
      'designDescription': instance.designDescription,
      'designImage': instance.designImage,
      'createAt': instance.createAt,
      'createdBy': instance.createdBy,
    };
