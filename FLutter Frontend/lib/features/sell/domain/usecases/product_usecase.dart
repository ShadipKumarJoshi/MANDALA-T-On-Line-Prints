import 'package:dartz/dartz.dart';
import 'package:final_assignment/core/failure/failure.dart';
import 'package:final_assignment/features/sell/domain/entity/product_entity.dart';
import 'package:final_assignment/features/sell/domain/repository/i_product_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final productUseCaseProvider = Provider<ProductUseCase>((ref) {
  final productRepository = ref.watch(productRepositoryProvider);
  return ProductUseCase(productRepository: productRepository);
});

class ProductUseCase {
  final IProductRepository productRepository;

  ProductUseCase({
    required this.productRepository,
  });

  Future<Either<Failure, List<ProductEntity>>> getAllProduct() {
    return productRepository.getAllProduct();
  }
}
