import 'package:final_assignment/features/favourites/data/model/favourites_api_model.dart';
import 'package:json_annotation/json_annotation.dart';

part 'get_all_favourites_dto.g.dart';

@JsonSerializable()
class GetAllFavouritesDto {
  final List<FavouritesApiModel> favorites;

  GetAllFavouritesDto({required this.favorites});

  factory GetAllFavouritesDto.fromJson(Map<String, dynamic> json) {
    try {
      return _$GetAllFavouritesDtoFromJson(json);
    } catch (e) {
      print('error $e');
      rethrow;
    }
  }

  Map<String, dynamic> toJson() {
    return _$GetAllFavouritesDtoToJson(this);
  }
}
