// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'get_all_favourites_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GetAllFavouritesDto _$GetAllFavouritesDtoFromJson(Map<String, dynamic> json) =>
    GetAllFavouritesDto(
      favorites: (json['favorites'] as List<dynamic>)
          .map((e) => FavouritesApiModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$GetAllFavouritesDtoToJson(
        GetAllFavouritesDto instance) =>
    <String, dynamic>{
      'favorites': instance.favorites,
    };
