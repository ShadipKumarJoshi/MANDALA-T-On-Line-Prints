import 'package:dartz/dartz.dart';
import 'package:final_assignment/core/failure/failure.dart';
import 'package:final_assignment/features/orders/data/data_source/remote/order_remote_data_source.dart';
import 'package:final_assignment/features/orders/domain/entity/order_entity.dart';
import 'package:final_assignment/features/orders/domain/repository/i_order_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final orderRemoteRepositoryProvider = Provider<IOrderRepository>((ref) {
  final orderRemoteDataSource = ref.watch(orderRemoteDataSourceProvider);
  return OrderRemoteRepository(orderRemoteDataSource: orderRemoteDataSource);
});

class OrderRemoteRepository implements IOrderRepository {
  final OrderRemoteDataSource orderRemoteDataSource;

  OrderRemoteRepository({required this.orderRemoteDataSource});

  @override
  Future<Either<Failure, bool>> createOrder(OrderEntity orderEntity) {
    return orderRemoteDataSource.createOrder(orderEntity);
  }

  @override
  Future<Either<Failure, List<OrderEntity>>> getOrder() {
    return orderRemoteDataSource.getOrder();
  }
}
