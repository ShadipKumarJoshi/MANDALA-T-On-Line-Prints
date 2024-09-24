import 'package:equatable/equatable.dart';
import 'package:final_assignment/features/cart/domain/entity/cart_entity.dart';
import 'package:final_assignment/features/design/data/model/design_api_model.dart';
import 'package:final_assignment/features/sell/data/model/product_api_model.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:json_annotation/json_annotation.dart';

part 'cart_api_model.g.dart';

final cartApiModelProvider = Provider<CartApiModel>((ref) {
  return CartApiModel.empty();
});

@JsonSerializable()
class CartApiModel extends Equatable {
  @JsonKey(name: '_id')
  final String? id;
  final ProductApiModel productId;
  final DesignApiModel designId;
  final int quantity;
  final String productSize;
  final String productColor;
  final double customizePrice;
  final double total;

  const CartApiModel(
      {required this.id,
      required this.productId,
      required this.designId,
      required this.quantity,
      required this.productSize,
      required this.productColor,
      required this.customizePrice,
      required this.total});

  CartApiModel.empty()
      : id = '',
        productId = ProductApiModel.empty(),
        designId = const DesignApiModel.empty(),
        quantity = 0,
        productSize = '',
        productColor = '',
        customizePrice = 0.0,
        total = 0.0;

  CartEntity toEntity() {
    return CartEntity(
      id: id,
      productEntity: productId.toEntity(),
      designEntity: designId.toEntity(),
      quantity: quantity,
      productSize: productSize,
      productColor: productColor,
      customizePrice: customizePrice,
      total: total,
    );
  }

  factory CartApiModel.fromEntity(CartEntity entity) {
    return CartApiModel(
        id: entity.id,
        productId: ProductApiModel.fromEntity(entity.productEntity),
        designId: DesignApiModel.fromEntity(entity.designEntity),
        quantity: entity.quantity,
        productSize: entity.productSize,
        productColor: entity.productColor,
        customizePrice: entity.customizePrice,
        total: entity.quantity * entity.customizePrice);
  }

  factory CartApiModel.fromJson(Map<String, dynamic> json) {
    return CartApiModel(
      id: json['_id'],
      productId: ProductApiModel.fromJson(json['productId']),
      designId: DesignApiModel.fromJson(json['designId']),
      quantity: json['quantity'],
      productSize: json['productSize'],
      productColor: json['productColor'],
      customizePrice: (json['customizePrice'] as num).toDouble(),
      total: (json['total'] as num).toDouble(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'productId': productId.id,
      'designId': designId.id,
      'quantity': quantity,
      'productSize': productSize,
      'productColor': productColor,
      'customizePrice': customizePrice,
      'total': total,
    };
  }

  List<CartApiModel> fromEntityList(List<CartEntity> entityList) {
    return entityList.map((e) => CartApiModel.fromEntity(e)).toList();
  }

  List<CartEntity> toEntityList(List<CartApiModel> modelList) {
    return modelList.map((e) => e.toEntity()).toList();
  }

  @override
  List<Object?> get props => [
        id,
        productId,
        designId,
        quantity,
        productSize,
        productColor,
        customizePrice,
        total
      ];
}
