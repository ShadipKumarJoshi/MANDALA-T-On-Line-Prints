
import 'package:final_assignment/core/common/my_snackbar.dart';
import 'package:final_assignment/features/orders/domain/entity/order_entity.dart';
import 'package:final_assignment/features/orders/domain/usecases/order_usecase.dart';
import 'package:final_assignment/features/orders/presentation/state/order_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final orderViewModelProvider =
    StateNotifierProvider<OrderViewModel, OrderState>(
  (ref) => OrderViewModel(
    orderUsecase: ref.read(orderUsecaseProvider),
  ),
);

class OrderViewModel extends StateNotifier<OrderState> {
  OrderViewModel({required this.orderUsecase}) : super(OrderState.initial()) {
    fetchOrders();
  }

  final OrderUsecase orderUsecase;

  Future fetchOrders() async {
    state = state.copyWith(isLoading: true);
    final result = await orderUsecase.getOrder();
    result.fold(
      (failure) {
        state = state.copyWith(isLoading: false, error: failure.error);
        showMySnackBar(message: failure.error, color: Colors.red);
      },
      (data) => state = state.copyWith(
        isLoading: false,
        orders: data,
        error: null,
      ),
    );
  }

  void addOrder(OrderEntity order) {
    final updatedOrders = List<OrderEntity>.from(state.orders)..add(order);
    state = state.copyWith(orders: updatedOrders);
    showMySnackBar(message: 'Order placed successfully', color: Colors.green);
  }
}
