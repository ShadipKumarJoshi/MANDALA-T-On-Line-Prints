import 'package:final_assignment/features/dashboard/presentation/navigator/dashboard_navigator.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final dashboardViewModelProvider =
    StateNotifierProvider<DashboardViewModel, void>(
  (ref) => DashboardViewModel(ref.read(dashboardViewNavigatorProvider)),
);

// This line defines a StateNotifierProvider named dashboardViewModelProvider.
// It creates an instance of DashboardViewModel and associates it with the dashboardViewNavigatorProvider.
// The void type parameter indicates that this provider doesn’t have any state value; it only manages actions.
class DashboardViewModel extends StateNotifier<void> {
  DashboardViewModel(this.navigator) : super(null);

  final DashboardViewNavigator navigator;

  void openCartView() {
    navigator.openCartView();
  }

  void openHomeView() {
    navigator.openCustomizeView();
  }

  void openDesignView() {
    navigator.openDesignView();
  }

  void openSellDesignView() {
    navigator.openSellDesignView();
  }

  void openEditSellDesignView() {
    navigator.openEditSellDesignView();
  }

  // void openFavoriteView() {
  //   navigator.openFavouritesView();
  // }

  void openFavouritesView() {
    navigator.openFavouritesView();
  }

  void openCustomizeView() {
    navigator.openCustomizeView();
  }

  void openMenuView() {
    navigator.openMenuView();
  }

  void openProfileView() {
    navigator.openProfileView();
  }

  void openEditProfileView() {
    navigator.openEditProfileView();
  }
}
