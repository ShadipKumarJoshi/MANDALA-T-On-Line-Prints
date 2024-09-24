import 'package:equatable/equatable.dart';

class ProductEntity extends Equatable {
  final String? id;
  final String productCategory;
  final double productPrice;
  final List<String> productSize;
  final List<String> productColor;
  final String productDescription;
  final String productImage;
  final String createAt;

  const ProductEntity(
      {required this.id,
      required this.productCategory,
      required this.productPrice,
      required this.productSize,
      required this.productColor,
      required this.productDescription,
      required this.productImage,
      required this.createAt});

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
