import 'package:dartz/dartz.dart';
import 'package:final_assignment/core/failure/failure.dart';
import 'package:final_assignment/features/cart/domain/entity/cart_entity.dart';
import 'package:final_assignment/features/cart/domain/repository/i_cart_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final cartUsecaseProvider = Provider<CartUsecase>((ref) {
  final cartRepository = ref.watch(cartRepositoryProvider);
  return CartUsecase(cartRepository: cartRepository);
});

class CartUsecase {
  final ICartRepository cartRepository;

  CartUsecase({required this.cartRepository});

  Future<Either<Failure, bool>> addToCart(CartEntity cartEntity) async {
    return cartRepository.addToCart(cartEntity);
  }

  Future<Either<Failure, List<CartEntity>>> getCart() async {
    return cartRepository.getCart();
  }

  Future<Either<Failure, bool>> removeFromCart(String productId) async {
    return cartRepository.removeFromCart(productId);
  }

  Future<Either<Failure, bool>> updateQuantity(
      String productId, int quantity, double price) async {
    return cartRepository.updateQuantity(productId, quantity, price);
  }

  Future<Either<Failure, bool>> clearCart() async {
    return cartRepository.clearCart();
  }
  Future<Either<Failure, bool>> changeStatus() async {
    return cartRepository.changeStatus();
  }

  
}
