import 'package:dartz/dartz.dart';
import 'package:final_assignment/core/failure/failure.dart';
import 'package:final_assignment/features/orders/domain/entity/order_entity.dart';
import 'package:final_assignment/features/orders/domain/repository/i_order_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final orderUsecaseProvider = Provider<OrderUsecase>((ref) {
  final orderRepository = ref.watch(orderRepositoryProvider);
  return OrderUsecase(orderRepository: orderRepository);
});

class OrderUsecase {
  final IOrderRepository orderRepository;

  OrderUsecase({required this.orderRepository});

  Future<Either<Failure, bool>> createOrder(OrderEntity orderEntity) async {
    return orderRepository.createOrder(orderEntity);
  }

  Future<Either<Failure, List<OrderEntity>>> getOrder() async {
    return orderRepository.getOrder();
  }
}
