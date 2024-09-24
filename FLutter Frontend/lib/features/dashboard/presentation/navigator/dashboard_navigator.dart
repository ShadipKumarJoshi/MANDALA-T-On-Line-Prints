import 'package:final_assignment/app/navigator/navigator.dart';
import 'package:final_assignment/features/cart/presentation/navigator/cart_navigator.dart';
import 'package:final_assignment/features/customize/presentation/navigator/customize_navigator.dart';
import 'package:final_assignment/features/dashboard/presentation/view/dashboard_view.dart';
import 'package:final_assignment/features/design/presentation/navigator/design_navigator.dart';
import 'package:final_assignment/features/edit_profile/presentation/navigator/edit_profile_navigator.dart';
import 'package:final_assignment/features/edit_sell/presentation/navigator/edit_sell_design_navigator.dart';
import 'package:final_assignment/features/favourites/presentation/navigator/favourites_navigator.dart';
import 'package:final_assignment/features/menu/presentation/navigator/menu_navigator.dart';
import 'package:final_assignment/features/profile/presentation/navigator/profile_navigator.dart';
import 'package:final_assignment/features/sell/presentation/navigator/sell_design_navigator.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final dashboardViewNavigatorProvider =
    Provider((ref) => DashboardViewNavigator());

class DashboardViewNavigator
    with
        SellDesignViewRoute,
        EditSellDesignViewRoute,
        CartViewRoute,
        DesignViewRoute,
        FavouritesViewRoute,
        CustomizeViewRoute,
        MenuViewRoute,
        ProfileViewRoute,
        EditProfileViewRoute {}

mixin DashboardViewRoute {
  openDashboardView() {
    NavigateRoute.popAndPushRoute(const DashboardView());
  }
}
