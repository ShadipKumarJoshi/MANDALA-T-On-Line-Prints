import 'package:dartz/dartz.dart';
import 'package:final_assignment/core/failure/failure.dart';
import 'package:final_assignment/features/cart/data/data_source/remote/cart_remote_data_source.dart';
import 'package:final_assignment/features/cart/domain/entity/cart_entity.dart';
import 'package:final_assignment/features/cart/domain/repository/i_cart_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final cartRemoteRepositoryProvider = Provider<ICartRepository>((ref) {
  final cartRemoteDataSource = ref.watch(cartRemoteDataSourceProvider);
  return CartRemoteRepository(cartRemoteDataSource: cartRemoteDataSource);
});

class CartRemoteRepository implements ICartRepository {
  final CartRemoteDataSource cartRemoteDataSource;

  CartRemoteRepository({required this.cartRemoteDataSource});

  @override
  Future<Either<Failure, bool>> addToCart(CartEntity cartEntity) {
    return cartRemoteDataSource.addToCart(cartEntity);
  }

  @override
  Future<Either<Failure, List<CartEntity>>> getCart() {
    return cartRemoteDataSource.getCart();
  }

  @override
  Future<Either<Failure, bool>> removeFromCart(String designId) {
    return cartRemoteDataSource.removeFromCart(designId);
  }

  @override
  Future<Either<Failure, bool>> updateQuantity(
      String designId, int quantity, double price) {
    return cartRemoteDataSource.updateQuantity(designId, quantity, price);
  }

  @override
  Future<Either<Failure, bool>> clearCart() {
    return cartRemoteDataSource.clearCart();
  }

  @override
  Future<Either<Failure, bool>> changeStatus() {
    return cartRemoteDataSource.changeStatus();
  }
}
