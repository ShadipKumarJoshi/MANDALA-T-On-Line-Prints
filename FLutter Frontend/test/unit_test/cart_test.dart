import 'package:final_assignment/features/cart/domain/usecases/cart_usecase.dart';
import 'package:final_assignment/features/cart/presentation/viewmodel/cart_view_model.dart';
import 'package:final_assignment/features/orders/domain/usecases/order_usecase.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';

import 'cart_test.mocks.dart';

@GenerateNiceMocks([MockSpec<OrderUsecase>(), MockSpec<CartUsecase>()])
void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  late OrderUsecase mockOrderUsecase;
  late CartUsecase mockCartUsecase;
  late ProviderContainer container;

  setUp(() {
    mockOrderUsecase = MockOrderUsecase();
    mockCartUsecase = MockCartUsecase();

    container = ProviderContainer(overrides: [
      cartViewModelProvider.overrideWith(
        (ref) => CartViewModel(
          mockCartUsecase,
          mockOrderUsecase,
        ),
      )
    ]);
  });
}


