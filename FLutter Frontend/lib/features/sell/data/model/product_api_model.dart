import 'package:equatable/equatable.dart';
import 'package:final_assignment/features/sell/domain/entity/product_entity.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:json_annotation/json_annotation.dart';

part 'product_api_model.g.dart';

final productApiModelProvider = Provider<ProductApiModel>((ref) {
  return ProductApiModel.empty();
});

@JsonSerializable()
class ProductApiModel extends Equatable {
  @JsonKey(name: '_id')
  final String? id;
  final String productCategory;
  final double productPrice;
  final List<String> productSize;
  final List<String> productColor;
  final String productDescription;
  final String productImage;
  final String createAt;

  const ProductApiModel(
      {required this.id,
      required this.productCategory,
      required this.productPrice,
      required this.productSize,
      required this.productColor,
      required this.productDescription,
      required this.productImage,
      required this.createAt});

  // Empty constructor
  ProductApiModel.empty()
      : id = '',
        productCategory = '',
        productPrice = 0.0,
        productSize = [],
        productColor = [],
        productDescription = '',
        productImage = '',
        createAt = '';

  factory ProductApiModel.fromJson(Map<String, dynamic> json) =>
      _$ProductApiModelFromJson(json);

  Map<String, dynamic> toJson() => _$ProductApiModelToJson(this);

// To entity
  ProductEntity toEntity() {
    final size = productSize[0];
    final color = productColor[0];

    return ProductEntity(
      id: id,
      productCategory: productCategory,
      productPrice: productPrice,
      productSize: size.split(','),
      productColor: color.split(','),
      productDescription: productDescription,
      productImage: productImage,
      createAt: createAt,
    );
  }

  // From entity
  factory ProductApiModel.fromEntity(ProductEntity entity) {
    return ProductApiModel(
      id: entity.id,
      productCategory: entity.productCategory,
      productPrice: entity.productPrice,
      productSize: entity.productSize,
      productColor: entity.productColor,
      productDescription: entity.productDescription,
      productImage: entity.productImage,
      createAt: entity.createAt,
    );
  }

  // To list of entity
  List<ProductEntity> toEntities(List<ProductApiModel> products) {
    return products.map((product) => product.toEntity()).toList();
  }

  // From list of entity
  List<ProductApiModel> fromEntities(List<ProductEntity> products) {
    return products
        .map((product) => ProductApiModel.fromEntity(product))
        .toList();
  }

  @override
  List<Object?> get props => [
        id,
        productCategory,
        productPrice,
        productSize,
        productColor,
        productDescription,
        productImage,
        createAt
      ];
}
