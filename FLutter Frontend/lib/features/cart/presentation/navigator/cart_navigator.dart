import 'package:final_assignment/app/navigator/navigator.dart';
import 'package:final_assignment/features/cart/presentation/view/cart_view.dart';
import 'package:final_assignment/features/dashboard/presentation/navigator/dashboard_navigator.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final cartViewNavigatorProvider = Provider((ref) => CartViewNavigator());

class CartViewNavigator
    with DashboardViewRoute {}

mixin CartViewRoute {
  openCartView() {
    NavigateRoute.pushRoute(const CartView());
  }
}
