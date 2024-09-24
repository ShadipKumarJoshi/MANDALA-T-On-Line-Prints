import 'package:final_assignment/app/constants/api_endpoint.dart';
import 'package:final_assignment/core/common/dashboard_Tab_View_Heading.dart';
import 'package:final_assignment/features/cart/domain/entity/cart_entity.dart';
import 'package:final_assignment/features/cart/presentation/state/cart_state.dart';
import 'package:final_assignment/features/cart/presentation/viewmodel/cart_view_model.dart';
import 'package:final_assignment/features/dashboard/presentation/view/dashboard_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:khalti_flutter/khalti_flutter.dart';
import 'package:lottie/lottie.dart';

class CartView extends ConsumerStatefulWidget {
  const CartView({super.key});

  @override
  ConsumerState<CartView> createState() => _CartViewState();
}

class _CartViewState extends ConsumerState<CartView> {
  String _selectedPaymentMethod = 'cash';
  bool _isOrderSummaryExpanded = false;

  @override
  void initState() {
    super.initState();
    Future.microtask(
        () => ref.read(cartViewModelProvider.notifier).fetchCart());
  }

  @override
  Widget build(BuildContext context) {
    final cartState = ref.watch(cartViewModelProvider);

    return SizedBox.expand(
      child: Column(
        children: [
          const Center(
            child: DashboardTabViewHeading(text: 'Cart'),
          ),
          Expanded(
            child: cartState.items.isEmpty
                ? _buildEmptyCartView()
                : _buildCartItemsList(cartState),
          ),
          if (cartState.items.isNotEmpty) _buildOrderSummaryToggle(cartState),
        ],
      ),
    );
  }

  Widget _buildEmptyCartView() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Lottie.asset('assets/lottie/shopping_cart.json',
              height: 201, width: 201),
          Text('Your cart is empty',
              style: TextStyle(
                  fontSize: 22,
                  color: Colors.grey[800],
                  fontWeight: FontWeight.w600)),
          const SizedBox(height: 15),
          ElevatedButton(
            onPressed: () => Navigator.push(context,
                MaterialPageRoute(builder: (context) => const DashboardView())),
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.black,
              padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 15),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30)),
            ),
            child: const Text('Start Shopping', style: TextStyle(fontSize: 16)),
          ),
        ],
      ),
    );
  }

  Widget _buildCartItemsList(CartState cartState) {
    return ListView.builder(
      itemCount: cartState.items.length,
      itemBuilder: (context, index) {
        final item = cartState.items[index];
        return CartItem(
          cartEntity: item,
          onIncrement: () => ref
              .read(cartViewModelProvider.notifier)
              .incrementItemQuantity(item.id!, item.customizePrice),
          onDecrement: () => ref
              .read(cartViewModelProvider.notifier)
              .decrementItemQuantity(item.id!, item.customizePrice),
          onRemove: () =>
              ref.read(cartViewModelProvider.notifier).removeFromCart(item.id!),
        );
      },
    );
  }

  Widget _buildOrderSummaryToggle(CartState cartState) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
              color: Colors.grey.withOpacity(0.1),
              spreadRadius: 1,
              blurRadius: 10,
              offset: const Offset(0, -5))
        ],
      ),
      child: Column(
        children: [
          ListTile(
            title: const Text('Order Summary',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600)),
            trailing: Icon(
                _isOrderSummaryExpanded
                    ? Icons.keyboard_arrow_up
                    : Icons.keyboard_arrow_down,
                color: Colors.black),
            onTap: () => setState(
                () => _isOrderSummaryExpanded = !_isOrderSummaryExpanded),
          ),
          AnimatedCrossFade(
            firstChild: Container(),
            secondChild: _buildOrderSummaryAndCheckout(cartState),
            crossFadeState: _isOrderSummaryExpanded
                ? CrossFadeState.showSecond
                : CrossFadeState.showFirst,
            duration: const Duration(milliseconds: 300),
          ),
        ],
      ),
    );
  }

  Widget _buildOrderSummaryAndCheckout(CartState cartState) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          OrderSummary(
              items: cartState.totalItems,
              subtotal: cartState.subtotal.toInt(),
              deliveryCharge: 50),
          const SizedBox(height: 20),
          const Text('Payment Method',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600)),
          const SizedBox(height: 10),
          _buildPaymentOption('Cash on Delivery', 'cash'),
          _buildPaymentOption('Pay with Khalti', 'khalti'),
          const SizedBox(height: 20),
          ElevatedButton(
            onPressed: () => _handleCheckout(cartState),
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.black,
              padding: const EdgeInsets.symmetric(vertical: 15),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10)),
              minimumSize: const Size(double.infinity, 50),
            ),
            child: const Text('Proceed to Checkout',
                style: TextStyle(fontSize: 16)),
          ),
        ],
      ),
    );
  }

  Widget _buildPaymentOption(String title, String value) {
    return RadioListTile<String>(
      title: Text(title),
      value: value,
      groupValue: _selectedPaymentMethod,
      onChanged: (String? newValue) =>
          setState(() => _selectedPaymentMethod = newValue!),
      activeColor: Colors.black,
    );
  }

  void _handleCheckout(CartState cartState) {
    if (_selectedPaymentMethod == 'cash') {
      ref
          .read(cartViewModelProvider.notifier)
          .checkoutCart('cash', cartState.subtotal.toInt() + 50);
    } else if (_selectedPaymentMethod == 'khalti') {
      _payWithKhalti(cartState);
      // _payWithKhalti(cartState);
    }
  }

  void _payWithKhalti(CartState cartState) {
    final config = PaymentConfig(
      amount: cartState.subtotal.toInt() * 100,
      productIdentity: cartState.items.first.designEntity.designName,
      productName: cartState.items.first.designEntity.designName,
      productUrl: 'https://example.com/product-url',
      additionalData: {'custom_field': 'value'},
    );
    KhaltiScope.of(context).pay(
      config: config,
      preferences: [PaymentPreference.khalti],
      onSuccess: (_) {
        ref
            .read(cartViewModelProvider.notifier)
            .checkoutCart('khalti', cartState.subtotal.toInt() + 50);
        ref.read(cartViewModelProvider.notifier).clearCart();
      },
      onFailure: (_) => ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
              content: Text('Payment Failed!'), backgroundColor: Colors.red)),
      onCancel: () => ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text('Payment Cancelled!'), backgroundColor: Colors.orange)),
    );
  }
}

class CartItem extends StatelessWidget {
  final CartEntity cartEntity;
  final VoidCallback onIncrement;
  final VoidCallback onDecrement;
  final VoidCallback onRemove;

  const CartItem(
      {super.key,
      required this.cartEntity,
      required this.onIncrement,
      required this.onDecrement,
      required this.onRemove});

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      key: Key(cartEntity.id.toString()),
      direction: DismissDirection.endToStart,
      onDismissed: (_) => onRemove(),
      background: Container(
        alignment: Alignment.centerRight,
        padding: const EdgeInsets.only(right: 20),
        color: Colors.red,
        child: const Icon(Icons.delete, color: Colors.white),
      ),
      child: Card(
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        elevation: 0,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Row(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: Image.network(
                    '${ApiEndpoints.designImage}${cartEntity.designEntity.designImage}',
                    width: 80,
                    height: 80,
                    fit: BoxFit.cover),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          children: [
                            Text(cartEntity.designEntity.designName,
                                style: const TextStyle(
                                    fontSize: 16, fontWeight: FontWeight.w600)),
                            const SizedBox(height: 4),
                            Text('Rs ${cartEntity.total}',
                                style: const TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w500,
                                    color: Colors.black87)),
                            const SizedBox(height: 8),
                          ],
                        ),
                        Column(
                          children: [
                            Column(children: [
                              Text(cartEntity.productEntity.productCategory,
                                  style: const TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w600)),
                              const SizedBox(height: 4),
                              Text('${cartEntity.productSize}',
                                  style: const TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w500,
                                      color: Colors.black87)),
                              Text('${cartEntity.productColor}',
                                  style: const TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w500,
                                      color: Colors.black87)),
                              const SizedBox(height: 8),
                            ])
                          ],
                        )
                      ],
                    ),
                    Row(
                      children: [
                        IconButton(
                            icon: const Icon(Icons.remove_circle_outline,
                                size: 20),
                            onPressed: onDecrement,
                            color: Colors.grey[600]),
                        Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 12, vertical: 4),
                          decoration: BoxDecoration(
                              border: Border.all(color: Colors.grey[300]!),
                              borderRadius: BorderRadius.circular(20)),
                          child: Text('${cartEntity.quantity}',
                              style: const TextStyle(
                                  fontSize: 14, fontWeight: FontWeight.w600)),
                        ),
                        IconButton(
                            icon:
                                const Icon(Icons.add_circle_outline, size: 20),
                            onPressed: onIncrement,
                            color: Colors.grey[600]),
                        IconButton(
                          icon: const Icon(Icons.delete, size: 20),
                          onPressed: onRemove,
                          color: Colors.red,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class OrderSummary extends StatelessWidget {
  final int items;
  final int subtotal;
  final int deliveryCharge;

  const OrderSummary(
      {super.key,
      required this.items,
      required this.subtotal,
      required this.deliveryCharge});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildSummaryRow('Items', items.toString()),
        _buildSummaryRow('Subtotal', 'Rs $subtotal'),
        _buildSummaryRow('Delivery Charge', 'Rs $deliveryCharge'),
        const Divider(height: 24, thickness: 1),
        _buildSummaryRow('Total', 'Rs ${subtotal + deliveryCharge}',
            isTotal: true),
      ],
    );
  }

  Widget _buildSummaryRow(String label, String value, {bool isTotal = false}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label,
              style: TextStyle(
                  fontSize: isTotal ? 18 : 16,
                  fontWeight: isTotal ? FontWeight.w600 : FontWeight.w400,
                  color: isTotal ? Colors.black : Colors.grey[600])),
          Text(value,
              style: TextStyle(
                  fontSize: isTotal ? 18 : 16,
                  fontWeight: isTotal ? FontWeight.w600 : FontWeight.w500,
                  color: isTotal ? Colors.black : Colors.black87)),
        ],
      ),
    );
  }
}
