

import 'package:final_assignment/features/sell/data/model/product_api_model.dart';
import 'package:json_annotation/json_annotation.dart';

part 'product_dto.g.dart';

@JsonSerializable()
class ProductDto {
  final bool success;
  final String message;
  final List<ProductApiModel> products;

  ProductDto({
    required this.success,
    required this.message,
    required this.products,
  });

  Map<String, dynamic> toJson() => _$ProductDtoToJson(this);

  factory ProductDto.fromJson(Map<String, dynamic> json) =>
      _$ProductDtoFromJson(json);
}
