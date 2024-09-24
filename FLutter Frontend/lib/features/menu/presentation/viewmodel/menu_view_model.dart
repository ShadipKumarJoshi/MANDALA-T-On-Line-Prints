import 'package:final_assignment/features/menu/presentation/navigator/menu_navigator.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final menuViewModelProvider = StateNotifierProvider<MenuViewModel, void>(
  (ref) => MenuViewModel(ref.read(menuViewNavigatorProvider)),
);

// This line defines a StateNotifierProvider named menuViewModelProvider.
// It creates an instance of MenuViewModel and associates it with the menuViewNavigatorProvider.
// The void type parameter indicates that this provider doesn’t have any state value; it only manages actions.
class MenuViewModel extends StateNotifier<void> {
  MenuViewModel(this.navigator) : super(null);

  final MenuViewNavigator navigator;

  void openDashboardView() {
    navigator.openDashboardView();
  }

  void openOrderView() {
    navigator.openOrderView();
  }
}
