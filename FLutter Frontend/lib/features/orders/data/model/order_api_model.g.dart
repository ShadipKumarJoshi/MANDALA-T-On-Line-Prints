// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'order_api_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

OrderApiModel _$OrderApiModelFromJson(Map<String, dynamic> json) =>
    OrderApiModel(
      id: json['_id'] as String?,
      userId: json['userId'] as String?,
      carts: (json['carts'] as List<dynamic>?)
          ?.map((e) => CartApiModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      total: (json['total'] as num).toDouble(),
      address: json['address'] as String,
      paymentType: json['paymentType'] as String,
    );

Map<String, dynamic> _$OrderApiModelToJson(OrderApiModel instance) =>
    <String, dynamic>{
      '_id': instance.id,
      'userId': instance.userId,
      'carts': instance.carts,
      'total': instance.total,
      'address': instance.address,
      'paymentType': instance.paymentType,
    };
