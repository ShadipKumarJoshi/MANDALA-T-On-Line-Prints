import 'package:final_assignment/app/navigator/navigator.dart';
import 'package:final_assignment/features/dashboard/presentation/navigator/dashboard_navigator.dart';
import 'package:final_assignment/features/menu/presentation/view/menu_view.dart';
import 'package:final_assignment/features/orders/presentation/navigator/order_navigator.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final menuViewNavigatorProvider = Provider((ref) => MenuViewNavigator());

class MenuViewNavigator
    with DashboardViewRoute, OrderViewRoute {}

mixin MenuViewRoute {
  openMenuView() {
    NavigateRoute.pushRoute(const MenuView());
  }
}
