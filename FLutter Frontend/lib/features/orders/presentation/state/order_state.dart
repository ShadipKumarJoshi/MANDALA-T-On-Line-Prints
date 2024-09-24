import 'package:final_assignment/features/orders/domain/entity/order_entity.dart';

class OrderState {
  final List<OrderEntity> orders;
  final bool isLoading;
  final String? error;

  OrderState({
    required this.orders,
    required this.isLoading,
    required this.error,
  });

  factory OrderState.initial() {
    return OrderState(
      orders: [],
      isLoading: false,
      error: null,
    );
  }

  OrderState copyWith({
    List<OrderEntity>? orders,
    bool? isLoading,
    String? error,
  }) {
    return OrderState(
      orders: orders ?? this.orders,
      isLoading: isLoading ?? this.isLoading,
      error: error ?? this.error,
    );
  }

  int get totalOrders {
    return orders.length;
  }
}
