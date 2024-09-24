import 'package:final_assignment/features/cart/domain/entity/cart_entity.dart';

class CartState {
  final List<CartEntity> items;
  final bool isLoading;
  final String? error;
  final String? pidx;

  CartState({
    required this.items,
    required this.isLoading,
    required this.error,
    required this.pidx,
  });

  factory CartState.initial() {
    return CartState(
      items: [],
      isLoading: false,
      error: null,
      pidx: null,
    );
  }

  CartState copyWith({
    List<CartEntity>? items,
    bool? isLoading,
    String? error,
  }) {
    return CartState(
      items: items ?? this.items,
      isLoading: isLoading ?? this.isLoading,
      error: error ?? this.error,
      pidx: pidx,
    );
  }

  int get totalItems {
    return items.fold(0, (sum, item) => sum + item.quantity);
  }

  double get subtotal {
    return items.fold(
      0.0,
      (sum, item) => sum + (item.designEntity.designPrice * item.quantity),
    );
  }

  double get total {
    return subtotal + 50; // Assuming delivery charge is a fixed amount
  }
}
