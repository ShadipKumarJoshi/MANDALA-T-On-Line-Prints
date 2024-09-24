import 'package:final_assignment/app/constants/api_endpoint.dart';
import 'package:final_assignment/features/orders/domain/entity/order_entity.dart';
import 'package:final_assignment/features/orders/presentation/viewmodel/order_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:lottie/lottie.dart';

class OrderView extends ConsumerStatefulWidget {
  const OrderView({super.key});

  @override
  ConsumerState<OrderView> createState() => _OrderViewState();
}

class _OrderViewState extends ConsumerState<OrderView> {
  @override
  void initState() {
    super.initState();
    Future.microtask(
        () => ref.read(orderViewModelProvider.notifier).fetchOrders());
  }

  @override
  Widget build(BuildContext context) {
    final orderState = ref.watch(orderViewModelProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Your Orders',
            style: TextStyle(fontWeight: FontWeight.bold)),
        actions: [
          IconButton(
            icon: const Icon(Icons.sort),
            onPressed: () {
              // Implement sorting logic
            },
          ),
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: () {
              ref.read(orderViewModelProvider.notifier).fetchOrders();
            },
          ),
        ],
      ),
      body: orderState.isLoading
          ? const Center(child: CircularProgressIndicator())
          : orderState.error != null
              ? Center(child: Text('Error: ${orderState.error}'))
              : orderState.orders.isEmpty
                  ? _buildEmptyState()
                  : _buildOrderList(
                      orderState.orders,
                      (orderEntity) {
                        // display a modal bottom sheet with order details

                        modalBottomSheet(context, orderEntity);
                      },
                    ),
    );
  }

  Future<dynamic> modalBottomSheet(BuildContext context, OrderEntity order) {
    return showModalBottomSheet(
      context: context,
      builder: (context) {
        return Container(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Order ID: ${order.id}',
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                'Total: Rs ${order.total}',
                style: const TextStyle(
                  fontSize: 16,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                'Address: ${order.address}',
                style: const TextStyle(
                  fontSize: 16,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                'Payment Type: ${order.paymentType}',
                style: const TextStyle(
                  fontSize: 16,
                ),
              ),
              const SizedBox(height: 8),
              const Divider(),
              const SizedBox(height: 8),
              const Text(
                'Items',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 8),
              Expanded(
                child: ListView.builder(
                  itemCount: order.carts.length,
                  itemBuilder: (context, index) {
                    final cart = order.carts[index];
                    return ListTile(
                      leading: Image.network(
                          '${ApiEndpoints.designImage}${cart.designEntity.designImage}'),
                      title: Text(cart.designEntity.designName),
                      subtitle: Text('Quantity: ${cart.quantity}'),
                      trailing: Text('Rs ${cart.designEntity.designPrice}'),
                    );
                  },
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Lottie.asset(
            'assets/lottie/empty_orders.json',
            height: 200,
            width: 200,
          ),
          const SizedBox(height: 20),
          const Text(
            'No orders yet',
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 10),
          const Text(
            'You have not placed any orders yet.',
            style: TextStyle(fontSize: 16, color: Colors.grey),
          ),
          const SizedBox(height: 20),
          ElevatedButton.icon(
            onPressed: () {
              // Navigate to shopping page
            },
            icon: const Icon(Icons.shopping_bag),
            label: const Text('Start Shopping'),
            style: ElevatedButton.styleFrom(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildOrderList(List<OrderEntity> orders, onTap) {
    return MasonryGridView.count(
      crossAxisCount: 1,
      mainAxisSpacing: 4,
      crossAxisSpacing: 4,
      itemCount: orders.length,
      itemBuilder: (context, index) {
        return OrderItem(
          orderEntity: orders[index],
          onTap: () {
            onTap(orders[index]);
          },
        );
      },
    );
  }
}

class OrderItem extends StatelessWidget {
  final OrderEntity orderEntity;
  final VoidCallback? onTap;

  const OrderItem({
    super.key,
    required this.orderEntity,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Card(
        elevation: 2,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Stack(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.vertical(top: Radius.circular(15)),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 8),
                  Text(
                    'Total: Rs ${orderEntity.total}',
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 8),
                  // carts
                  Text(
                    'Items: ${orderEntity.carts.length}',
                    style: const TextStyle(
                      fontSize: 14,
                    ),
                  ),

                  const SizedBox(height: 8),
                  Text(
                    'Address: ${orderEntity.address}',
                    style: const TextStyle(
                      fontSize: 14,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    'Payment Type: ${orderEntity.paymentType}',
                    style: const TextStyle(
                      fontSize: 14,
                    ),
                  ),
                  const SizedBox(height: 8),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
