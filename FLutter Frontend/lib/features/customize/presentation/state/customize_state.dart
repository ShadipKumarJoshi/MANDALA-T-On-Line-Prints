import '../../../design/domain/entity/design_entity.dart';
import '../../../sell/domain/entity/product_entity.dart';

class CustomizeState {
  final bool isLoading;
  final List<ProductEntity> products;
  final List<DesignEntity> designs;
  final String? error;
  final List<String> productSizes;
  final List<String> productColors;

  CustomizeState(
      {required this.isLoading,
      required this.products,
      required this.designs,
      required this.error,
      required this.productSizes,
      required this.productColors});

  factory CustomizeState.initial() {
    return CustomizeState(
      isLoading: false,
      products: [],
      designs: [],
      error: '',
      productSizes: [],
      productColors: [],
    );
  }

  CustomizeState copyWith({
    bool? isLoading,
    List<ProductEntity>? products,
    List<DesignEntity>? designs,
    String? error,
    List<String>? productSizes,
    List<String>? productColors,
  }) {
    return CustomizeState(
      isLoading: isLoading ?? this.isLoading,
      products: products ?? this.products,
      designs: designs ?? this.designs,
      error: error ?? this.error,
      productSizes: productSizes ?? this.productSizes,
      productColors: productColors ?? this.productColors,
    );
  }
}
