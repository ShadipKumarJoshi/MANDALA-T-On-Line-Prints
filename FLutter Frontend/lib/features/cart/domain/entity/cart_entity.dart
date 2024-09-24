import 'package:equatable/equatable.dart';
import 'package:final_assignment/features/design/domain/entity/design_entity.dart';
import 'package:final_assignment/features/sell/domain/entity/product_entity.dart';

class CartEntity extends Equatable {
  final String? id;
  final ProductEntity productEntity;
  final DesignEntity designEntity;
  final int quantity;
  final String productSize;
  final String productColor;
  final double customizePrice;
  final double total; // Ensure total is computed correctly

  const CartEntity({
    this.id,
    required this.productEntity,
    required this.designEntity,
    required this.quantity,
    required this.productSize,
    required this.productColor,
    required this.customizePrice,
    required this.total,
  });

  @override
  List<Object?> get props => [
        id,
        productEntity,
        designEntity,
        quantity,
        productSize,
        productColor,
        customizePrice,
        total,
      ];
}
