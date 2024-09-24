import 'package:final_assignment/features/cart/data/model/cart_api_model.dart';
import 'package:json_annotation/json_annotation.dart';

part 'get_all_carts_dto.g.dart';

@JsonSerializable()
class GetAllCartsDto {
  final List<CartApiModel> carts;

  GetAllCartsDto({required this.carts});

  factory GetAllCartsDto.fromJson(Map<String, dynamic> json) {
    return _$GetAllCartsDtoFromJson(json);
  }

  Map<String, dynamic> toJson() {
    return _$GetAllCartsDtoToJson(this);
  }
}
