import 'package:final_assignment/features/cart/domain/entity/cart_entity.dart';
import 'package:final_assignment/features/cart/domain/usecases/cart_usecase.dart';
import 'package:final_assignment/features/customize/presentation/navigator/customize_navigator.dart';
import 'package:final_assignment/features/customize/presentation/state/customize_state.dart';
import 'package:final_assignment/features/design/domain/usecases/design_usecase.dart';
import 'package:final_assignment/features/sell/domain/usecases/product_usecase.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final customizeViewModelProvider =
    StateNotifierProvider<CustomizeViewModel, CustomizeState>(
  (ref) => CustomizeViewModel(
    ref.read(customizeViewNavigatorProvider),
    ref.read(productUseCaseProvider),
    ref.read(designUseCaseProvider),
    ref.read(cartUsecaseProvider),
  ),
);

// This line defines a StateNotifierProvider named customizeViewModelProvider.
// It creates an instance of CustomizeViewModel and associates it with the customizeViewNavigatorProvider.
// The void type parameter indicates that this provider doesn’t have any state value; it only manages actions.
class CustomizeViewModel extends StateNotifier<CustomizeState> {
  CustomizeViewModel(
    this.navigator,
    this.productUseCase,
    this.designUseCase,
    this.cartUsecase,
  ) : super(CustomizeState.initial());

  final CustomizeViewNavigator navigator;
  final ProductUseCase productUseCase;
  final DesignUseCase designUseCase;
  final CartUsecase cartUsecase;

  void openDashboardView() {
    navigator.openDashboardView();
  }

  void openSellDesignView() {
    navigator.openSellDesignView();
  }

  init() {
    fetchProducts();
    fetchDesigns();
  }

  fetchProducts() async {
    state = state.copyWith(isLoading: true);
    final data = await productUseCase.getAllProduct();

    data.fold(
      (failure) => state = state.copyWith(
        isLoading: false,
        error: failure.error,
      ),
      (data) {
        state = state.copyWith(
          products: data,
          isLoading: false,
        );
        final sizes = data[0].productSize;
        for (int i = 0; i < sizes.length; i++) {
          print(sizes[i]);
        }
      },
    );
  }

  fetchDesigns() async {
    state = state.copyWith(isLoading: true);
    final data = await designUseCase.getAllDesigns();

    data.fold(
      (failure) => state = state.copyWith(
        isLoading: false,
        error: failure.error,
      ),
      (data) {
        state = state.copyWith(
          designs: data,
          isLoading: false,
        );
      },
    );
  }

  addToCart(CartEntity cartEntity) async {
    state = state.copyWith(isLoading: true);
    final data = await cartUsecase.addToCart(cartEntity);

    data.fold(
      (failure) => state = state.copyWith(
        error: failure.error,
        isLoading: false,
      ),
      (data) {
        state = state.copyWith(isLoading: false, error: null);
      },
    );
  }
}
