import 'package:final_assignment/app/navigator/navigator.dart';
import 'package:final_assignment/features/dashboard/presentation/navigator/dashboard_navigator.dart';
import 'package:final_assignment/features/menu/presentation/navigator/menu_navigator.dart';
import 'package:final_assignment/features/orders/presentation/view/order_view.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final orderViewNavigatorProvider = Provider((ref) => OrderViewNavigator());

class OrderViewNavigator
    with DashboardViewRoute, MenuViewRoute {}

mixin OrderViewRoute {
  openOrderView() {
    NavigateRoute.pushRoute(const OrderView());
  }
}
