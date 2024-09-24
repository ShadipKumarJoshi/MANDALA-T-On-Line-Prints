import 'package:final_assignment/features/cart/domain/usecases/cart_usecase.dart';
import 'package:final_assignment/features/customize/presentation/navigator/customize_navigator.dart';
import 'package:final_assignment/features/design/domain/entity/design_entity.dart';
import 'package:final_assignment/features/design/domain/usecases/design_usecase.dart';
import 'package:final_assignment/features/design/presentation/viewmodel/design_view_model.dart';
import 'package:final_assignment/features/sell/domain/usecases/product_usecase.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';

import 'design_test.mocks.dart';
import 'test_data/design_entity_data.dart';

@GenerateNiceMocks([
  MockSpec<DesignUseCase>(),
])

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  late ProviderContainer container;
  late CustomizeViewNavigator mockNavigator;
  late ProductUseCase mockProductUseCase;
  late DesignUseCase mockDesignUsecase;
  late CartUsecase mockCartUsecase;
 

  setUp(() {
    
  });
}