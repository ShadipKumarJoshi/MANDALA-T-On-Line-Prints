import 'package:equatable/equatable.dart';
import 'package:final_assignment/features/cart/data/model/cart_api_model.dart';
import 'package:final_assignment/features/orders/domain/entity/order_entity.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:json_annotation/json_annotation.dart';

part 'order_api_model.g.dart';

final orderApiModelProvider = Provider<OrderApiModel>((ref) {
  return OrderApiModel.empty();
});

@JsonSerializable()
class OrderApiModel extends Equatable {
  @JsonKey(name: '_id')
  final String? id;
  final String? userId;
  final List<CartApiModel>? carts;
  final double total;
  final String address;
  final String paymentType;

  const OrderApiModel({
    required this.id,
    required this.userId,
    required this.carts,
    required this.total,
    required this.address,
    required this.paymentType,
  });

  OrderApiModel.empty()
      : id = '',
        userId = '',
        carts = [],
        total = 0,
        address = '',
        paymentType = '';

  OrderEntity toEntity() {
    return OrderEntity(
      id: id,
      userId: userId,
      carts: carts?.map((cart) => cart.toEntity()).toList() ?? [],
      total: total,
      address: address,
      paymentType: paymentType,
    );
  }

  factory OrderApiModel.fromEntity(OrderEntity entity) {
    return OrderApiModel(
      id: entity.id,
      userId: entity.userId,
      carts: entity.carts.map((cart) => CartApiModel.fromEntity(cart)).toList(),
      total: entity.total,
      address: entity.address,
      paymentType: entity.paymentType,
    );
  }

  factory OrderApiModel.fromJson(Map<String, dynamic> json) =>
      _$OrderApiModelFromJson(json);

  Map<String, dynamic> toJson() => _$OrderApiModelToJson(this);

  List<OrderApiModel> fromEntityList(List<OrderEntity> entityList) {
    return entityList.map((e) => OrderApiModel.fromEntity(e)).toList();
  }

  List<OrderEntity> toEntityList(List<OrderApiModel> modelList) {
    return modelList.map((e) => e.toEntity()).toList();
  }

  @override
  List<Object?> get props => [id, userId, carts, total, address, paymentType];
}
