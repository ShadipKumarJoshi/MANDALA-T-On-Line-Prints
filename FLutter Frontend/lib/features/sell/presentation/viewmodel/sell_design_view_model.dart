import 'package:final_assignment/features/sell/presentation/navigator/sell_design_navigator.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final sellDesignViewModelProvider = StateNotifierProvider<SellViewModel, void>(
  (ref) => SellViewModel(ref.read(sellDesignViewNavigatorProvider)),
);

// This line defines a StateNotifierProvider named sellDesignViewModelProvider.
// It creates an instance of SellViewModel and associates it with the sellDesignViewNavigatorProvider.
// The void type parameter indicates that this provider doesn’t have any state value; it only manages actions.
class SellViewModel extends StateNotifier<void> {
  SellViewModel(this.navigator) : super(null);

  final SellDesignViewNavigator navigator;
  void openDashboardView() {
    navigator.openDashboardView();
  }

  void openEditSellDesignView() {
    navigator.openEditSellDesignView();
  }

  void openAddDesignView() {
    navigator.openAddDesignView();
  }
}
