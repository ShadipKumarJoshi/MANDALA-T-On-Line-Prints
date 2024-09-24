// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'favourites_api_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

FavouritesApiModel _$FavouritesApiModelFromJson(Map<String, dynamic> json) =>
    FavouritesApiModel(
      id: json['_id'] as String?,
      productId:
          DesignApiModel.fromJson(json['productId'] as Map<String, dynamic>),
      userId: json['userId'] as String?,
    );

Map<String, dynamic> _$FavouritesApiModelToJson(FavouritesApiModel instance) =>
    <String, dynamic>{
      '_id': instance.id,
      'productId': instance.productId,
      'userId': instance.userId,
    };
