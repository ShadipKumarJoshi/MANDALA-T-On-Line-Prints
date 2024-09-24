import 'package:final_assignment/features/add_design/presentation/navigator/add_design_navigator.dart';
import 'package:final_assignment/features/edit_sell/presentation/navigator/edit_sell_design_navigator.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final addDesignViewModelProvider =
    StateNotifierProvider<AddDesignViewModel, void>(
  (ref) => AddDesignViewModel(ref.watch(addDesignViewNavigatorProvider)),
);

// This line defines a StateNotifierProvider named addDesignViewModelProvider.
// It creates an instance of AddDesignViewModel and associates it with the addDesignViewNavigatorProvider.
// The void type parameter indicates that this provider doesn’t have any state value; it only manages actions.
class AddDesignViewModel extends StateNotifier<void> {
  AddDesignViewModel(this.navigator) : super(null);

  final AddDesignViewNavigator navigator;

  void openDashboardView() {
    navigator.openDashboardView();
  }

  void openSellDesignView() {
    navigator.openSellDesignView();
  }
}
