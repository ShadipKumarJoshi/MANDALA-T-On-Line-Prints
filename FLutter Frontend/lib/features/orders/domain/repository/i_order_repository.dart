import 'package:dartz/dartz.dart';
import 'package:final_assignment/core/failure/failure.dart';
import 'package:final_assignment/features/orders/data/repository/order_remote_repository.dart';
import 'package:final_assignment/features/orders/domain/entity/order_entity.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final orderRepositoryProvider = Provider<IOrderRepository>(
    (ref) => ref.read(orderRemoteRepositoryProvider));

abstract class IOrderRepository {
  Future<Either<Failure, bool>> createOrder(OrderEntity orderEntity);
  Future<Either<Failure, List<OrderEntity>>> getOrder();
}
