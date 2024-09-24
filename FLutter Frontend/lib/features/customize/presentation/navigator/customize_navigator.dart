import 'package:final_assignment/app/navigator/navigator.dart';
import 'package:final_assignment/features/dashboard/presentation/navigator/dashboard_navigator.dart';
import 'package:final_assignment/features/customize/presentation/view/customize_view.dart';
import 'package:final_assignment/features/sell/presentation/navigator/sell_design_navigator.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final customizeViewNavigatorProvider = Provider((ref) => CustomizeViewNavigator());

class CustomizeViewNavigator
    with DashboardViewRoute, SellDesignViewRoute {}

mixin CustomizeViewRoute {
  openCustomizeView() {
    NavigateRoute.pushRoute(const CustomizeView());
  }



}
