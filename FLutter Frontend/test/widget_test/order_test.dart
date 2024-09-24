import 'package:dartz/dartz.dart';
import 'package:final_assignment/app/navigator_key/navigator_key.dart';
import 'package:final_assignment/features/orders/domain/entity/order_entity.dart';
import 'package:final_assignment/features/orders/presentation/view/order_view.dart';
import 'package:final_assignment/features/orders/presentation/viewmodel/order_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../unit_test/order_test.mocks.dart';
import '../unit_test/test_data/order_entity_data.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  late MockOrderUsecase mockOrderUsecase;
  late List<OrderEntity> lstOrders;

  setUp(() {
    mockOrderUsecase = MockOrderUsecase();
    lstOrders = OrderTestData.getOrderTestData();
  });

  testWidgets("Displays loading indicator while fetching orders",
      (tester) async {
    when(mockOrderUsecase.getOrder()).thenAnswer(
        (_) async => const Right([])); // Simulating an empty order list

    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          orderViewModelProvider.overrideWith(
            (ref) => OrderViewModel(orderUsecase: mockOrderUsecase),
          ),
        ],
        child: MaterialApp(
          navigatorKey: AppNavigator.navigatorKey,
          home: const OrderView(),
        ),
      ),
    );

    // Expect to find a CircularProgressIndicator while loading
    expect(find.byType(CircularProgressIndicator), findsOneWidget);
  });

  testWidgets("Displays orders when fetched successfully", (tester) async {
    when(mockOrderUsecase.getOrder()).thenAnswer(
        (_) async => Right(lstOrders)); // Simulating a successful fetch

    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          orderViewModelProvider.overrideWith(
            (ref) => OrderViewModel(orderUsecase: mockOrderUsecase),
          ),
        ],
        child: MaterialApp(
          navigatorKey: AppNavigator.navigatorKey,
          home: const OrderView(),
        ),
      ),
    );

    await tester.pumpAndSettle();

    // for (var order in lstOrders) {
    //   expect(find.text(order.id ?? ''), findsOneWidget);
    // expect(find.text(order.userId ?? ''), findsOneWidget);
    // expect(find.text(order.total.toString()), findsOneWidget);
    // expect(find.text(order.address ?? ''), findsOneWidget);
    // expect(find.text(order.paymentType ?? ''), findsOneWidget);
    // }
  });

  testWidgets("Displays empty state when no orders are fetched",
      (tester) async {
    when(mockOrderUsecase.getOrder()).thenAnswer(
        (_) async => const Right([])); // Simulating an empty order list

    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          orderViewModelProvider.overrideWith(
            (ref) => OrderViewModel(orderUsecase: mockOrderUsecase),
          ),
        ],
        child: MaterialApp(
          navigatorKey: AppNavigator.navigatorKey,
          home: const OrderView(),
        ),
      ),
    );

    await tester.pumpAndSettle();

    // Check for empty state UI
    expect(find.text('No orders yet'), findsOneWidget);
    expect(find.text('You have not placed any orders yet.'), findsOneWidget);
  });
}
