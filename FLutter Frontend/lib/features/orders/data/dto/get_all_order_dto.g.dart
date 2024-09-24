// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'get_all_order_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GetAllOrderDto _$GetAllOrderDtoFromJson(Map<String, dynamic> json) =>
    GetAllOrderDto(
      orders: (json['orders'] as List<dynamic>)
          .map((e) => OrderApiModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$GetAllOrderDtoToJson(GetAllOrderDto instance) =>
    <String, dynamic>{
      'orders': instance.orders,
    };
