import 'package:final_assignment/features/edit_sell/presentation/navigator/edit_sell_design_navigator.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final editSellDesignViewModelProvider =
    StateNotifierProvider<EditSellDesignViewModel, void>(
  (ref) => EditSellDesignViewModel(ref.watch(editSellDesignViewNavigatorProvider)),
);

// This line defines a StateNotifierProvider named editSellDesignViewModelProvider.
// It creates an instance of EditSellDesignViewModel and associates it with the editSellDesignViewNavigatorProvider.
// The void type parameter indicates that this provider doesn’t have any state value; it only manages actions.
class EditSellDesignViewModel extends StateNotifier<void> {
  EditSellDesignViewModel(this.navigator) : super(null);

  final EditSellDesignViewNavigator navigator;

  void openDashboardView() {
    navigator.openDashboardView();
  }

  void openSellDesignView() {
    navigator.openSellDesignView();
  }
}
