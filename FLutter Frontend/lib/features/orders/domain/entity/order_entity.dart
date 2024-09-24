import 'package:equatable/equatable.dart';
import 'package:final_assignment/features/cart/domain/entity/cart_entity.dart';

class OrderEntity extends Equatable {
  final String? id;
  final String? userId;
  final List<CartEntity> carts;
  final double total;
  final String address;
  final String paymentType;

  const OrderEntity({
    this.id,
    this.userId,
    required this.carts,
    required this.total,
    required this.address,
    required this.paymentType,
  });

  @override
  List<Object?> get props => [
        id,
        userId,
        carts,
        total,
        address,
        paymentType,
      ];
}
