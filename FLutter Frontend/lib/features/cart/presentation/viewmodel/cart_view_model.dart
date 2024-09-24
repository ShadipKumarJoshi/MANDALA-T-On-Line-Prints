import 'package:final_assignment/features/cart/domain/entity/cart_entity.dart';
import 'package:final_assignment/features/cart/domain/usecases/cart_usecase.dart';
import 'package:final_assignment/features/cart/presentation/state/cart_state.dart';
import 'package:final_assignment/features/orders/domain/entity/order_entity.dart';
import 'package:final_assignment/features/orders/domain/usecases/order_usecase.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final cartViewModelProvider = StateNotifierProvider<CartViewModel, CartState>(
  (ref) => CartViewModel(
    ref.read(cartUsecaseProvider),
    ref.read(orderUsecaseProvider),
  ),
);

class CartViewModel extends StateNotifier<CartState> {
  final CartUsecase cartUsecase;
  final OrderUsecase orderUsecase;

  CartViewModel(this.cartUsecase, this.orderUsecase)
      : super(CartState.initial()) {
    fetchCart();
  }

  Future<void> fetchCart() async {
    state = state.copyWith(isLoading: true);
    print('Fetching cart...');
    final result = await cartUsecase.getCart();

    result.fold(
      (failure) {
        state = state.copyWith(
          isLoading: false,
          error: failure.error,
        );
        print('Fetch Cart Error: ${failure.error}');
      },
      (data) {
        state = state.copyWith(
          items: data,
          isLoading: false,
        );
        print('Cart fetched successfully.');
      },
    );
  }

  Future<void> addToCart(CartEntity cartEntity) async {
    state = state.copyWith(isLoading: true);
    print('Adding to cart: $cartEntity');
    final result = await cartUsecase.addToCart(cartEntity);

    result.fold(
      (failure) {
        state = state.copyWith(
          isLoading: false,
          error: failure.error,
        );
        print('Add to Cart Error: ${failure.error}');
      },
      (success) {
        fetchCart(); // Refresh the cart after adding item
        print('Item added to cart.');
      },
    );
  }

  Future<void> removeFromCart(String productId) async {
    state = state.copyWith(isLoading: true);
    print('Removing from cart: $productId');
    final result = await cartUsecase.removeFromCart(productId);

    result.fold(
      (failure) {
        state = state.copyWith(
          isLoading: false,
          error: failure.error,
        );
        print('Remove from Cart Error: ${failure.error}');
      },
      (success) {
        state = state.copyWith(
          items: state.items.where((item) => item.id != productId).toList(),
          isLoading: false,
        );
        print('Item removed from cart.');
      },
    );
  }

  Future<void> updateQuantity(
      String productId, int quantity, double price) async {
    state = state.copyWith(isLoading: true);
    print('Updating quantity for $productId to $quantity');

    final result = await cartUsecase.updateQuantity(productId, quantity, price);

    result.fold(
      (failure) {
        state = state.copyWith(
          isLoading: false,
          error: failure.error,
        );
        print('Update Quantity Error: ${failure.error}');
      },
      (success) {
        fetchCart(); // Refresh the cart after updating quantity
        print('Quantity updated successfully.');
      },
    );
  }

  Future<void> incrementItemQuantity(String productId, double price) async {
    final item = state.items.firstWhere((item) => item.id == productId);
    print('Incrementing quantity for $productId');
    await updateQuantity(
        productId, item.quantity + 1, price); // Ensure item.quantity is an int
  }

  Future<void> decrementItemQuantity(String productId, double price) async {
    final item = state.items.firstWhere((item) => item.id == productId);
    print('Decrementing quantity for $productId');
    if (item.quantity > 1) {
      await updateQuantity(productId, item.quantity - 1,
          price); // Ensure item.quantity is an int
    } else {
      await removeFromCart(productId);
    }
  }

  Future<void> clearCart() async {
    state = state.copyWith(isLoading: true);
    print('Clearing cart...');
    final result = await cartUsecase.clearCart();

    result.fold(
      (failure) {
        state = state.copyWith(
          isLoading: false,
          error: failure.error,
        );
        print('Clear Cart Error: ${failure.error}');
      },
      (success) {
        state = state.copyWith(
          items: [],
          isLoading: false,
        );
        print('Cart cleared successfully.');
      },
    );
  }

  // Change status of cart to 'checked out'
  Future<void> changeStatus() async {
    state = state.copyWith(isLoading: true);
    print('Changing status of cart...');
    final result = await cartUsecase.changeStatus();

    result.fold(
      (failure) {
        state = state.copyWith(
          isLoading: false,
          error: failure.error,
        );
        print('Change Status Error: ${failure.error}');
      },
      (success) {
        state = state.copyWith(
          items: [],
          isLoading: false,
        );
        print('Cart status changed successfully.');
      },
    );
  }

  Future<void> checkoutCart(String paymentMethod, double total) async {
    state = state.copyWith(isLoading: true);
    print('Checking out cart...');
    final order = OrderEntity(
        carts: state.items,
        total: total,
        address: 'KTM',
        paymentType: paymentMethod);
    final result = await orderUsecase.createOrder(order);

    result.fold(
      (failure) {
        state = state.copyWith(
          isLoading: false,
          error: failure.error,
        );
        print('Checkout Cart Error: ${failure.error}');
      },
      (success) async {
        state = state.copyWith(
          items: [],
          isLoading: false,
        );
        await changeStatus();
        print('Cart checked out successfully.');
      },
    );
  }

  int get totalItems {
    return state.totalItems;
  }

  double get subtotal {
    return state.subtotal;
  }

  double get total {
    return state.total;
  }
}
