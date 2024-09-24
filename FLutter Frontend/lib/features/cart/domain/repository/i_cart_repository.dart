import 'package:dartz/dartz.dart';
import 'package:final_assignment/core/failure/failure.dart';
import 'package:final_assignment/features/cart/data/repository/cart_remote_repository.dart';
import 'package:final_assignment/features/cart/domain/entity/cart_entity.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final cartRepositoryProvider =
    Provider<ICartRepository>((ref) => ref.read(cartRemoteRepositoryProvider));

abstract class ICartRepository {
  Future<Either<Failure, bool>> addToCart(CartEntity cartEntity);
  Future<Either<Failure, List<CartEntity>>> getCart();
  Future<Either<Failure, bool>> removeFromCart(String designId);
  Future<Either<Failure, bool>> updateQuantity(
      String designId, int quantity, double price);
  Future<Either<Failure, bool>> clearCart();

  Future<Either<Failure, bool>> changeStatus();
}
