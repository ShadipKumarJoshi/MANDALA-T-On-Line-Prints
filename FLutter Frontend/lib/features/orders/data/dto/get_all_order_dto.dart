

import 'package:final_assignment/features/orders/data/model/order_api_model.dart';
import 'package:json_annotation/json_annotation.dart';

part 'get_all_order_dto.g.dart';

@JsonSerializable()
class GetAllOrderDto {
  final List<OrderApiModel> orders;

  GetAllOrderDto({required this.orders});

  factory GetAllOrderDto.fromJson(Map<String, dynamic> json) {
    try {
      return _$GetAllOrderDtoFromJson(json);
    } catch (e) {
      print('error $e');
      rethrow;
    }
  }

  Map<String, dynamic> toJson() {
    return _$GetAllOrderDtoToJson(this);
  }
}
