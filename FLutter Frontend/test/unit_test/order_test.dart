import 'package:dartz/dartz.dart';
import 'package:final_assignment/core/failure/failure.dart';
import 'package:final_assignment/features/orders/domain/entity/order_entity.dart';
import 'package:final_assignment/features/orders/domain/usecases/order_usecase.dart';
import 'package:final_assignment/features/orders/presentation/state/order_state.dart';
import 'package:final_assignment/features/orders/presentation/viewmodel/order_view_model.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'order_test.mocks.dart';
import 'test_data/order_entity_data.dart';

@GenerateNiceMocks([
  MockSpec<OrderUsecase>(),
])

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  late OrderUsecase mockOrderUsecase;
  late ProviderContainer container;
  late List<OrderEntity> lstOrders;

  setUp(() {
    mockOrderUsecase = MockOrderUsecase();
    lstOrders = OrderTestData.getOrderTestData();

    container = ProviderContainer(
      overrides: [
        orderViewModelProvider.overrideWith(
          (ref) => OrderViewModel(orderUsecase: mockOrderUsecase),
        )
      ],
    );
  });

  test('initial state should be OrderState.initial()', () {
    final orderViewModel = container.read(orderViewModelProvider.notifier);
    expect(orderViewModel.state, OrderState.initial());
  });

  test('fetchOrders should update state with a list of orders on success', () async {
    when(mockOrderUsecase.getOrder()).thenAnswer(
      (_) async => Right(lstOrders),
    );

    final orderViewModel = container.read(orderViewModelProvider.notifier);

    await orderViewModel.fetchOrders();

    final updatedState = container.read(orderViewModelProvider);
    expect(updatedState.isLoading, false);
    expect(updatedState.error, isNull);
    expect(updatedState.orders, lstOrders);
  });

  test('fetchOrders should update state with an error message on failure', () async {
    const failureMessage = 'Failed to fetch orders';
    when(mockOrderUsecase.getOrder()).thenAnswer(
      (_) async => Left(Failure(error: failureMessage)),
    );

    final orderViewModel = container.read(orderViewModelProvider.notifier);

    await orderViewModel.fetchOrders();

    final updatedState = container.read(orderViewModelProvider);
    expect(updatedState.isLoading, false);
    expect(updatedState.error, failureMessage);
    expect(updatedState.orders, isEmpty);
  });

  test('addOrder should add a new order to the state', () async {
    final newOrder = OrderEntity(
      id: "new_id",
      userId: "new_user_id",
      carts: [],
      total: 500,
      address: "Bhaktapur",
      paymentType: "Cash on Delivery",
    );

    final orderViewModel = container.read(orderViewModelProvider.notifier);

    orderViewModel.addOrder(newOrder);

    final updatedState = container.read(orderViewModelProvider);
    expect(updatedState.orders.length, lstOrders.length + 1);
    expect(updatedState.orders.contains(newOrder), true);
  });

  // dispose the container from   provider
  tearDown(
    () {
      container.dispose();
    },
  );
}
